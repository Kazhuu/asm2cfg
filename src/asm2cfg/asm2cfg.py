"""
Module containing main building blocks to parse assembly and draw CFGs.
"""

import re
import sys
import tempfile

from graphviz import Digraph


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
        self.instructions.append(escape(instruction))

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
        label = r'\l'.join(self.instructions)
        # Left justify the last line too.
        label += r'\l'
        if self.jump_edge:
            if self.no_jump_edge:
                label += '|{<s0>No Jump|<s1>Jump}'
            else:
                label += '|{<s1>Jump}'
        return '{' + label + '}'

    def __str__(self):
        return '\n'.join(self.instructions)

    def __repr__(self):
        return '\n'.join(self.instructions)

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
        return [True, f'{memory_range[1]}-{memory_range[2]}']
    return [False, function_name[1]]


def get_call_pattern(stripped):
    """
    Match call patterns in the assembly. Need to match following lines.
    Stripped:
    0x000055555556fd8c:	call   *0x26a16(%rip)        # 0x5555555967a8
    0x0000555555556188:	call   0x555555555542
    0x000055555557259c:	addr32 call 0x55555558add0 <_Z19exportDebugifyStats>
    Non-stripped:
    0x000055555556fd8c <+1084>:	call   *0x26a16(%rip)        # 0x5555555967a8
    0x000055555556fe46 <+1270>:	call   0x0555555578a4
    0x000055555557259c <+11340>:	addr32 call 0x55555558add0 <_Z19exportDebugifyStats>
    """
    if stripped:
        return re.compile(fr'0x0*({HEX_PATTERN}):.*callq?\s*(.*{HEX_PATTERN}.*)$')
    return re.compile(fr'<[+-](\d+)>:.*callq?\s*(.*{HEX_PATTERN}.*)$')


def get_jump_pattern(stripped, function_name):
    """
    Return regexp pattern used to identify jump assembly lines. Support
    for stripped and non-stripped versions.

    Need to match non-stripped lines:
    '0x00007ffff7fbf124 <+68>:  jmp  0x7ffff7fbf7c2 <test_function+1762>'
    and stripped lines:
    '0x000055555555600f:        jmp  0x55555555603d'
    """
    if stripped:
        return re.compile(fr'0x0*({HEX_PATTERN}):\W+\w+\W+0x0*({HEX_PATTERN})$')
    return re.compile(fr'<[+-](\d+)>:.+<{function_name}[+-](\d+)>')


def get_unconditional_branch_pattern():
    """
    Return regexp pattern used to identify unconditional jumps.
    """
    return re.compile(r'jmpq?\b')


def get_assembly_line_pattern(stripped):
    """
    Return regexp pattern used for matching regular assembly lines in the file.
    Support for stripped and non-stripped versions.

    Need to match non-stripped lines:
    '0x00007ffff7fbf158 <+120>: and  $0xfffffffffffffff8,%r12'
    and stripped lines:
    '0x000055555555602a:        mov  rax,QWORD PTR [rip+0x311f]  # 0x555555559150'
    """
    if stripped:
        return re.compile(fr'0x0*({HEX_PATTERN}):\W+(.+)$')
    return re.compile(r'<[+-](\d+)>:\W+(.+)$')


def parse_lines(lines, skip_calls): # pylint: disable=too-many-locals,too-many-branches,too-many-statements
    # TODO: Pylint complexity warnings disabled. When refactored see can we get rid of any.
    stripped, function_name = get_stripped_and_function_name(lines[0])
    # Dict key contains address where the jump begins and value which address
    # to jump to. This also includes calls.
    jump_table = {}
    # Set containing addresses where jumps end inside the current function.
    jump_destinations = set()
    call_pattern = get_call_pattern(stripped)
    jump_pattern = get_jump_pattern(stripped, function_name)
    uncond_jump_pattern = get_unconditional_branch_pattern()

    # Iterate over the lines and collect jump targets and branching points.
    for line in lines[1:-1]:
        match = call_pattern.search(line)
        if match is not None and skip_calls:
            continue
        match = jump_pattern.search(line)
        if match is not None:
            branch_point = match[1]
            jump_point = match[2]
            is_unconditional = bool(uncond_jump_pattern.search(line))
            jump_table[branch_point] = jump_point, is_unconditional
            jump_destinations.add(jump_point)

    # Now iterate over the assembly again and split it to basic blocks using
    # the branching information from earlier.
    line_pattern = get_assembly_line_pattern(stripped)
    basic_blocks = {}
    current_basic_block = None
    previous_jump_block = None
    for line in lines[1:-1]:
        line_match = line_pattern.search(line)
        if line_match is not None:
            # Current offset/address inside the function.
            program_point = line_match[1]
            # Current instruction.
            instruction = line_match[2]
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
        elif 'End of assembler dump' in line:
            break
        elif line.startswith('Address range'):
            continue
        else:
            print(f'unsupported line: {line}')
            sys.exit(1)

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
    return [function_name, basic_blocks]


def draw_cfg(function_name, basic_blocks, view):
    dot = Digraph(name=function_name, comment=function_name, engine='dot')
    dot.attr('graph', label=function_name)
    for key, basic_block in basic_blocks.items():
        dot.node(key, shape='record', label=basic_block.get_label())
    for basic_block in basic_blocks.values():
        if basic_block.jump_edge:
            if basic_block.no_jump_edge is not None:
                dot.edge(f'{basic_block.key}:s0', basic_block.no_jump_edge)
            dot.edge(f'{basic_block.key}:s1', basic_block.jump_edge)
        elif basic_block.no_jump_edge:
            dot.edge(basic_block.key, basic_block.no_jump_edge)
    if view:
        dot.format = 'gv'
        with tempfile.NamedTemporaryFile(mode='w+b', prefix=function_name) as filename:
            dot.view(filename.name)
            print(f'Opening a file {filename.name}.{dot.format} with default viewer. Don\'t forget to delete it later.')
    else:
        dot.format = 'pdf'
        dot.render(filename=function_name, cleanup=True)
        print(f'Saved CFG to a file {function_name}.{dot.format}')
