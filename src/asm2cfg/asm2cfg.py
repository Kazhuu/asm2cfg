"""
Module containing main building blocks to parse assembly and draw CFGs.
"""

import re
import sys
import tempfile

from graphviz import Digraph


# TODO: make this a command-line flag
VERBOSE = 0


def escape(instruction):
    """
    Escape used dot graph characters in given instruction so they will be
    displayed correctly.
    """
    instruction = instruction.replace('<', r'\<')
    instruction = instruction.replace('>', r'\>')
    instruction = instruction.replace('|', r'\|')
    instruction = instruction.replace('{', r'\{')
    instruction = instruction.replace('}', r'\}')
    instruction = instruction.replace('	', ' ')
    return instruction


class BasicBlock:
    """
    Class to represent a node in CFG with straight lines of code without jump
    or calls instructions.
    """

    def __init__(self, key):
        self.key = key
        self.instructions = []
        self.jump_edge = None
        self.no_jump_edge = None

    def add_instruction(self, instruction):
        """
        Add instruction to this block.
        """
        self.instructions.append(instruction)

    def add_jump_edge(self, basic_block_key):
        """
        Add jump target block to this block.
        """
        if isinstance(basic_block_key, BasicBlock):
            self.jump_edge = basic_block_key.key
        else:
            self.jump_edge = basic_block_key

    def add_no_jump_edge(self, basic_block_key):
        """
        Add no jump target block to this block.
        """
        if isinstance(basic_block_key, BasicBlock):
            self.no_jump_edge = basic_block_key.key
        else:
            self.no_jump_edge = basic_block_key

    def get_label(self):
        """
        Return content of the block for dot graph.
        """
        # Left align in dot.
        label = r'\l'.join([escape(i.text) for i in self.instructions])
        # Left justify the last line too.
        label += r'\l'
        if self.jump_edge:
            if self.no_jump_edge:
                label += '|{<s0>No Jump|<s1>Jump}'
            else:
                label += '|{<s1>Jump}'
        return '{' + label + '}'

    def __str__(self):
        return '\n'.join([i.text for i in self.instructions])

    def __repr__(self):
        return '\n'.join([i.text for i in self.instructions])


def print_assembly(basic_blocks):
    """
    Debug function to print the assembly.
    """
    for basic_block in basic_blocks.values():
        print(basic_block)


def read_lines(file_path):
    """ Read lines from the file and return then as a list. """
    lines = []
    with open(file_path, 'r', encoding='utf8') as asm_file:
        lines = asm_file.readlines()
    return lines


# Common regexes
HEX_PATTERN = r'[0-9a-fA-F]+'
HEX_LONG_PATTERN = r'(?:0x0*)?' + HEX_PATTERN


class InputFormat:  # pylint: disable=too-few-public-methods
    """
    An enum which represents various supported input formats
    """
    GDB = 'GDB'
    OBJDUMP = 'OBJDUMP'


def parse_function_header(line):
    """
    Return function name of memory range from the given string line.

    Match lines for non-stripped binaries:
    'Dump of assembler code for function test_function:'
    lines for stripped binaries:
    'Dump of assembler code from 0x555555555faf to 0x555555557008:'
    and lines for obdjdump disassembly:
    '0000000000016bb0 <_obstack_allocated_p@@Base>:'
    """

    objdump_name_pattern = re.compile(fr'{HEX_PATTERN} <([a-zA-Z_0-9@.]+)>:')
    function_name = objdump_name_pattern.search(line)
    if function_name is not None:
        return InputFormat.OBJDUMP, function_name[1]

    function_name_pattern = re.compile(r'function (\w+):$')
    function_name = function_name_pattern.search(line)
    if function_name is not None:
        return InputFormat.GDB, function_name[1]

    memory_range_pattern = re.compile(fr'(?:Address range|from) ({HEX_LONG_PATTERN}) to ({HEX_LONG_PATTERN}):$')
    memory_range = memory_range_pattern.search(line)
    if memory_range is not None:
        return InputFormat.GDB, f'{memory_range[1]}-{memory_range[2]}'

    return None, None


class Address:
    """
    Represents location in program which may be absolute or relative
    """
    def __init__(self, abs_addr, base=None, offset=None):
        self.abs = abs_addr
        self.base = base
        self.offset = offset

    def is_absolute(self):
        return self.base is None

    def is_relative(self):
        return not self.is_absolute()

    def __str__(self):
        if self.offset is not None:
            return f'0x{self.abs:x} ({self.base}+{self.offset})'
        return f'0x{self.abs}'

    def merge(self, other):
        if self.abs is not None:
            assert self.abs is None or self.abs == other.abs
            self.abs = other.abs
        if self.base is not None:
            assert self.base is None or self.base == other.base
            self.base = other.base
        if self.offset is not None:
            assert self.offset is None or self.offset == other.offset
            self.offset = other.offset


class Encoding:
    """
    Represents a sequence of bytes used for instruction encoding
    e.g. the '31 c0' in
    '16bd3:	31 c0                	xor    %eax,%eax'
    """
    def __init__(self, bites):
        self.bites = bites

    def size(self):
        return len(self.bites)

    def __str__(self):
        return ' '.join(map(lambda b: f'{b:#x}', self.bites))


class X86TargetInfo:
    """
    Contains instruction info for X86-compatible targets.
    """

    def __init__(self):
        pass

    def comment(self):
        return '#'

    def is_call(self, instruction):
        # Various flavors of call:
        #   call   *0x26a16(%rip)
        #   call   0x555555555542
        #   addr32 call 0x55555558add0
        return 'call' in instruction.opcode

    def is_jump(self, instruction):
        return instruction.opcode[0] == 'j'

    def is_unconditional_jump(self, instruction):
        return instruction.opcode.startswith('jmp')

    def is_sink(self, instruction):
        """
        Is this an instruction which terminates function execution e.g. return?
        """
        return instruction.opcode.startswith('ret')


class ARMTargetInfo:
    """
    Contains instruction info for ARM-compatible targets.
    """

    def __init__(self):
        pass

    def comment(self):
        return ';'

    def is_call(self, instruction):
        # Various flavors of call:
        #   bl 0x19d90 <_IO_vtable_check>
        # Note that we should be careful to not mix it with conditional
        # branches like 'ble'.
        return instruction.opcode.startswith('bl') \
            and instruction.opcode not in ('blt', 'ble', 'bls')

    def is_jump(self, instruction):
        return instruction.opcode[0] == 'b' and not self.is_call(instruction)

    def is_unconditional_jump(self, instruction):
        return instruction.opcode == 'b'

    def is_sink(self, instruction):
        """
        Is this an instruction which terminates function execution e.g. return?
        Detect various flavors of return like
          bx lr
          pop {r2-r6,pc}
        Note that we do not consider conditional branches (e.g. 'bxle') to sink.
        """
        return re.search(r'\bpop\b.*\bpc\b', instruction.body) \
            or (instruction.opcode == 'bx' and instruction.ops[0] == 'lr') \
            or instruction.opcode == 'udf'


class Instruction:
    """
    Represents a single assembly instruction with it operands, location and
    optional branch target
    """
    def __init__(self, body, text, lineno, address, opcode, ops, target, imm, target_info):  # noqa
        self.body = body
        self.text = text
        self.lineno = lineno
        self.address = address
        self.opcode = opcode
        self.ops = ops
        self.target = target
        self.info = target_info
        if imm is not None and (self.is_jump() or self.is_call()):
            if self.target is None:
                self.target = imm
            else:
                self.target.merge(imm)

    def is_call(self):
        return self.info.is_call(self)

    def is_jump(self):
        return self.info.is_jump(self)

    def is_direct_jump(self):
        return self.is_jump() and re.match(fr'{HEX_LONG_PATTERN}', self.ops[0])

    def is_sink(self):
        return self.info.is_sink(self)

    def is_unconditional_jump(self):
        return self.info.is_unconditional_jump(self)

    def __str__(self):
        result = f'{self.address}: {self.opcode}'
        if self.ops:
            result += f' {self.ops}'
        return result


def parse_address(line):
    """
    Parses leading address of instruction
    """
    address_match = re.match(fr'^\s*(?:0x)?({HEX_PATTERN})\s*(?:<([+-][0-9]+)>)?:(.*)', line)
    if address_match is None:
        return None, line
    address = Address(int(address_match[1], 16), None, int(address_match[2]) if address_match[2] else None)
    return address, address_match[3]


def split_nth(string, count):
    """
    Splits string to equally-sized chunks
    """
    return [string[i:i+count] for i in range(0, len(string), count)]


def parse_encoding(line):
    """
    Parses byte encoding of instruction for objdump disassemblies
    e.g. the '31 c0' in
    '16bd3:	31 c0                	xor    %eax,%eax'
    In addition to X86 supports ARM encoding styles:
    '4:	e1a01000 	mov	r1, r0'
    '50:	f7ff fffe 	bl	0 <__aeabi_dadd>'
    '54:	0002      	movs	r2, r0'
    """
    # Encoding is separated from assembly mnemonic via tab
    # so we allow whitespace separators between bytes
    # to avoid accidentally matching the mnemonic.
    enc_match = re.match(r'^\s*((?:[0-9a-f]{2,8} +)+)(.*)', line)
    if enc_match is None:
        return None, line
    bites = []
    for chunk in enc_match[1].strip().split(' '):
        bites.extend(int(byte, 16) for byte in split_nth(chunk, 2))
    return Encoding(bites), enc_match[2]


def parse_body(line, target_info):
    """
    Parses instruction body (opcode and operands)
    """
    comment_symbol = target_info.comment()
    body_match = re.match(fr'^\s*([^{comment_symbol}<]+)(.*)', line)
    if body_match is None:
        return None, None, None, line
    body = body_match[1].strip()
    line = body_match[2]
    opcode_match = re.match(r'^(\S*)\s*(.*)', body)
    if opcode_match is None:
        return None, None, None, line
    opcode = opcode_match[1]
    ops = opcode_match[2].split(',') if opcode_match[2] else []
    return body, opcode, ops, line


def parse_target(line):
    """
    Parses optional instruction branch target hint
    """
    target_match = re.match(r'\s*<([a-zA-Z_@0-9]+)([+-]0x[0-9a-f]+|[+-][0-9]+)?>(.*)', line)
    if target_match is None:
        return None, line
    offset = target_match[2] or '+0'
    address = Address(None, target_match[1], int(offset, 0))
    return address, target_match[3]


def parse_comment(line, target_info):
    """
    Parses optional instruction comment
    """
    comment_symbol = target_info.comment()
    comment_match = re.match(fr'^\s*{comment_symbol}\s*(.*)', line)
    if comment_match is None:
        return None, line
    comment = comment_match[1]
    imm_match = re.match(fr'^(?:0x)?({HEX_PATTERN})\s*(<.*>)?(.*)', comment)
    if imm_match is None:
        # If no imm was found, ignore the comment.
        # In particular this takes care of useless ARM comments like
        # '82:	46c0      	nop			; (mov r8, r8)'
        return None, ''
    abs_addr = int(imm_match[1], 16)
    if imm_match[2]:
        target, _ = parse_target(imm_match[2])
        target.abs = abs_addr
    else:
        target = Address(abs_addr)
    return target, imm_match[3]


def parse_line(line, lineno, function_name, fmt, target_info):
    """
    Parses a single line of assembly to create Instruction instance
    """

    # Strip GDB prefix and leading whites
    if line.startswith('=> '):
        # Strip GDB marker
        line = line[3:]
    line = line.lstrip()

    address, line = parse_address(line)
    if address is None:
        return None

    if fmt == InputFormat.OBJDUMP:
        encoding, line = parse_encoding(line)
        if not line:
            return encoding

    original_line = line
    body, opcode, ops, line = parse_body(line, target_info)
    if opcode is None:
        return None

    target, line = parse_target(line)

    imm, line = parse_comment(line, target_info)
    if line:
        # Expecting complete parse
        return None

    # Set base symbol for relative addresses
    if address.base is None:
        address.base = function_name
    if target is not None and target.base is None:
        target.base = function_name

    return Instruction(body, original_line, lineno, address, opcode, ops, target, imm, target_info)


class JumpTable:
    """
    Holds info about branch sources and destinations in asm function.
    """

    def __init__(self, instructions):
        # Address where the jump begins and value which address
        # to jump to. This also includes calls.
        self.abs_sources = {}
        self.rel_sources = {}

        # Addresses where jumps end inside the current function.
        self.abs_destinations = set()
        self.rel_destinations = set()

        # Iterate over the lines and collect jump targets and branching points.
        for inst in instructions:
            if inst is None or not inst.is_direct_jump():
                continue

            self.abs_sources[inst.address.abs] = inst.target
            self.abs_destinations.add(inst.target.abs)

            self.rel_sources[inst.address.offset] = inst.target
            self.rel_destinations.add(inst.target.offset)

    def is_destination(self, address):
        if address.abs is not None:
            return address.abs in self.abs_destinations
        if address.offset is not None:
            return address.offset in self.rel_destinations
        return False

    def get_target(self, address):
        if address.abs is not None:
            return self.abs_sources.get(address.abs)
        if address.offset is not None:
            return self.rel_sources.get(address.offset)
        return None


def parse_lines(lines, skip_calls, target_name):  # noqa pylint: disable=unused-argument
    if target_name == 'x86':
        target_info = X86TargetInfo()
    elif target_name == 'arm':
        target_info = ARMTargetInfo()
    else:
        print(f'Unsupported platform {target_name}')
        sys.exit(1)

    instructions = []
    current_function_name = current_format = None
    for num, line in enumerate(lines, 1):
        fmt, function_name = parse_function_header(line)
        if function_name is not None:
            assert current_function_name is None, 'we handle only one function for now'
            if VERBOSE:
                print(f'New function {function_name} (format {fmt})')
            current_function_name = function_name
            current_format = fmt
            continue

        instruction_or_encoding = parse_line(line, num, current_function_name, current_format, target_info)
        if isinstance(instruction_or_encoding, Encoding):
            # Partial encoding for previous instruction, skip it
            continue
        if instruction_or_encoding is not None:
            instructions.append(instruction_or_encoding)
            continue

        if line.startswith('End of assembler dump') or not line:
            continue

        if line.strip() == '':
            continue

        print(f'Unexpected assembly at line {num}:\n  {line}')
        sys.exit(1)

    # Infer target address for jump instructions
    for instruction in instructions:
        if (instruction.target is None or instruction.target.abs is None) \
                and instruction.is_direct_jump():
            if instruction.target is None:
                instruction.target = Address(0)
            instruction.target.abs = int(instruction.ops[0], 16)

    # Infer relative addresses (for objdump or stripped gdb)
    start_address = instructions[0].address.abs
    end_address = instructions[-1].address.abs
    for instruction in instructions:
        for address in (instruction.address, instruction.target):
            if address is not None \
                    and address.offset is None \
                    and start_address <= address.abs <= end_address:
                address.offset = address.abs - start_address

    if VERBOSE:
        print('Instructions:')
        for instruction in instructions:
            if instruction is not None:
                print(f'  {instruction}')

    jump_table = JumpTable(instructions)

    if VERBOSE:
        print('Absolute destinations:')
        for dst in jump_table.abs_destinations:
            print(f'  {dst:#x}')
        print('Relative destinations:')
        for dst in jump_table.rel_destinations:
            print(f'  {dst}')
        print('Absolute branches:')
        for src, dst in jump_table.abs_sources.items():
            print(f'  {src:#x} -> {dst}')
        print('Relative branches:')
        for src, dst in jump_table.rel_sources.items():
            print(f'  {src} -> {dst}')

    # Now iterate over the assembly again and split it to basic blocks using
    # the branching information from earlier.
    basic_blocks = {}
    current_basic_block = None
    previous_jump_block = None
    for line, instruction in zip(lines, instructions):
        if instruction is None:
            continue

        # Current offset/address inside the function.
        program_point = instruction.address
        jump_point = jump_table.get_target(program_point)
        is_unconditional = instruction.is_unconditional_jump()

        if current_basic_block is None:
            current_basic_block = BasicBlock(program_point.abs)
            basic_blocks[current_basic_block.key] = current_basic_block
            # Previous basic block ended in jump instruction. Add the basic
            # block what follows if the jump was not taken.
            if previous_jump_block is not None:
                previous_jump_block.add_no_jump_edge(current_basic_block)
                previous_jump_block = None
        elif jump_table.is_destination(program_point):
            temp_block = current_basic_block
            current_basic_block = BasicBlock(program_point.abs)
            basic_blocks[current_basic_block.key] = current_basic_block
            temp_block.add_no_jump_edge(current_basic_block)

        current_basic_block.add_instruction(instruction)

        if jump_point is not None:
            current_basic_block.add_jump_edge(jump_point.abs)
            previous_jump_block = None if is_unconditional else current_basic_block
            current_basic_block = None
        elif instruction.is_sink():
            previous_jump_block = current_basic_block = None

    if previous_jump_block is not None:
        # If last instruction of the function is jump/call, then add dummy
        # block to designate end of the function.
        end_block = BasicBlock('end_of_function')
        dummy_instruction = Instruction('', 'end of function', 0, None, None, [], None, None, target_info)
        end_block.add_instruction(dummy_instruction)
        previous_jump_block.add_no_jump_edge(end_block.key)
        basic_blocks[end_block.key] = end_block

    return current_function_name, basic_blocks


def draw_cfg(function_name, basic_blocks, view):
    dot = Digraph(name=function_name, comment=function_name, engine='dot')
    dot.attr('graph', label=function_name)
    for address, basic_block in basic_blocks.items():
        key = str(address)
        dot.node(key, shape='record', label=basic_block.get_label())
    for basic_block in basic_blocks.values():
        if basic_block.jump_edge:
            if basic_block.no_jump_edge is not None:
                dot.edge(f'{basic_block.key}:s0', str(basic_block.no_jump_edge))
            dot.edge(f'{basic_block.key}:s1', str(basic_block.jump_edge))
        elif basic_block.no_jump_edge:
            dot.edge(str(basic_block.key), str(basic_block.no_jump_edge))
    if view:
        dot.format = 'gv'
        with tempfile.NamedTemporaryFile(mode='w+b', prefix=function_name) as filename:
            dot.view(filename.name)
            print(f'Opening a file {filename.name}.{dot.format} with default viewer. Don\'t forget to delete it later.')
    else:
        dot.format = 'pdf'
        dot.render(filename=function_name, cleanup=True)
        print(f'Saved CFG to a file {function_name}.{dot.format}')
