"""
Module containing main building blocks to parse assembly and draw CFGs.
"""

import re
import sys
import tempfile

from graphviz import Digraph


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


def get_stripped_and_function_name(line):
    """
    Return function name of memory range from the given string line. Return
    tuple where first element contains information is the binary stripped or
    not and second element is the function name.

    Match lines for non-stripped binary:
    'Dump of assembler code for function test_function:'
    and lines for stripped binary:
    'Dump of assembler code from 0x555555555faf to 0x555555557008:'
    """
    function_name_pattern = re.compile(r'function (\w+):$')
    memory_range_pattern = re.compile(fr'from ({HEX_LONG_PATTERN}) to ({HEX_LONG_PATTERN}):$')
    function_name = function_name_pattern.search(line)
    memory_range = memory_range_pattern.search(line)
    if function_name is None and memory_range is None:
        print('First line of the file does not contain a function name or valid memory range')
        sys.exit(1)
    if function_name is None:
        return True, f'{memory_range[1]}-{memory_range[2]}'
    return False, function_name[1]


class Address:
    """
    Represents location in program which may be absolute or relative
    """
    def __init__(self, abs_addr, base=None, offset=0):
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


class Instruction:
    """
    Represents a single assembly instruction with it operands, location and
    optional branch target
    """
    def __init__(self, body, text, lineno, address, opcode, ops, target, imm):  # pylint: disable=too-many-arguments
        self.body = body
        self.text = text
        self.lineno = lineno
        self.address = address
        self.opcode = opcode
        self.ops = ops
        self.target = target
        if imm is not None and (self.is_jump() or self.is_call()):
            if self.target is None:
                self.target = imm
            else:
                self.target.merge(imm)

    def is_call(self):
        # Various flavors of call:
        #   call   *0x26a16(%rip)
        #   call   0x555555555542
        #   addr32 call 0x55555558add0
        return 'call' in self.opcode

    def is_jump(self):
        return self.opcode[0] == 'j'

    def is_unconditional_jump(self):
        return self.opcode.startswith('jmp')

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


def parse_body(line):
    """
    Parses instruction body (opcode and operands)
    """
    body_match = re.match(r'^\s*([^#<]+)(.*)', line)
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
    target_match = re.match(r'\s*<([a-zA-Z_@0-9]+)([+-][0-9]+)?>(.*)', line)
    if target_match is None:
        return None, line
    offset = target_match[2] or '+0'
    address = Address(None, target_match[1], int(offset))
    return address, target_match[3]


def parse_imm(line):
    """
    Parses optional instruction imm hint
    """
    imm_match = re.match(fr'^\s*#\s*(?:0x)?({HEX_PATTERN})\s*(<.*>)?(.*)', line)
    if imm_match is None:
        return None, line
    abs_addr = int(imm_match[1], 16)
    if imm_match[2]:
        target, _ = parse_target(imm_match[2])
        target.abs = abs_addr
    else:
        target = Address(abs_addr)
    return target, imm_match[3]


def parse_line(line, lineno):
    """
    Parses a single line of assembly to create Instruction instance
    """

    if line.startswith('=> '):
        # Strip GDB marker
        line = line[3:]
    line = line.strip()

    address, line = parse_address(line)
    if address is None:
        return None
    original_line = line
    body, opcode, ops, line = parse_body(line)
    if opcode is None:
        return None
    target, line = parse_target(line)
    imm, line = parse_imm(line)
    if line:
        # Expecting complete parse
        return None
    return Instruction(body, original_line, lineno, address, opcode, ops, target, imm)


def parse_lines(lines, skip_calls):  # noqa pylint: disable=too-many-locals,too-many-branches,too-many-statements,unused-argument
    stripped, function_name = get_stripped_and_function_name(lines[0])
    del lines[0]

    # Parse function body
    instructions = []
    for num, line in enumerate(lines, 1):
        instruction = parse_line(line, num)
        if instruction is not None:
            instructions.append(instruction)
            continue
        if line.startswith('End of assembler dump'):
            continue
        if not line:
            continue
        print(f'Unexpected assembly at line {num}:\n  {line}')
        sys.exit(1)

    for instruction in instructions:
        if not stripped:
            # Set base symbol for relative addresses
            instruction.address.base = function_name
        if stripped and instruction.is_jump():
            # Infer target address for jump instructions
            if instruction.target is None:
                instruction.target = Address(0)
            instruction.target.abs = int(instruction.ops[0], 16)

    if VERBOSE:
        print('Instructions:')
        for instruction in instructions:
            if instruction is not None:
                print(f'  {instruction}')

    # Dict key contains address where the jump begins and value which address
    # to jump to. This also includes calls.
    jump_table = {}
    # Set containing addresses where jumps end inside the current function.
    jump_destinations = set()

    # Iterate over the lines and collect jump targets and branching points.
    for instruction in instructions:
        if instruction is None or not instruction.is_jump():
            continue
        branch_point = instruction.address.abs if stripped else instruction.address.offset
        jump_point = instruction.target.abs if stripped else instruction.target.offset
        jump_table[branch_point] = jump_point, instruction.is_unconditional_jump()
        jump_destinations.add(jump_point)

    if VERBOSE:
        print('Branch destinations:')
        for dst in jump_destinations:
            print(f'  {dst}')
        print('Branches:')
        for src, dst in jump_table.items():
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
        program_point = instruction.address.abs if stripped else instruction.address.offset

        if current_basic_block is None:
            current_basic_block = BasicBlock(program_point)
            current_basic_block.add_instruction(instruction)
            # Previous basic block ended in jump instruction. Add the basic
            # block what follows if the jump was not taken.
            if previous_jump_block is not None:
                previous_jump_block.add_no_jump_edge(current_basic_block)
                previous_jump_block = None
            # If this block only contains jump/call instruction then we
            # need immediately create a new basic block.
            if program_point in jump_table:
                jump_point, is_unconditional = jump_table[program_point]
                current_basic_block.add_jump_edge(jump_point)
                basic_blocks[current_basic_block.key] = current_basic_block
                previous_jump_block = None if is_unconditional else current_basic_block
                current_basic_block = None
        elif program_point in jump_destinations:
            temp_block = current_basic_block
            basic_blocks[current_basic_block.key] = current_basic_block
            current_basic_block = BasicBlock(program_point)
            current_basic_block.add_instruction(instruction)
            temp_block.add_no_jump_edge(current_basic_block)
        elif program_point in jump_table:
            jump_point, is_unconditional = jump_table[program_point]
            current_basic_block.add_instruction(instruction)
            current_basic_block.add_jump_edge(jump_point)
            basic_blocks[current_basic_block.key] = current_basic_block
            previous_jump_block = None if is_unconditional else current_basic_block
            current_basic_block = None
        else:
            current_basic_block.add_instruction(instruction)

    if current_basic_block is not None:
        # Add the last basic block from end of the function.
        basic_blocks[current_basic_block.key] = current_basic_block
    elif previous_jump_block is not None:
        # If last instruction of the function is jump/call, then add dummy
        # block to designate end of the function.
        end_block = BasicBlock('end_of_function')
        end_block.add_instruction('end of function')
        previous_jump_block.add_no_jump_edge(end_block.key)
        basic_blocks[end_block.key] = end_block

    return function_name, basic_blocks


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
