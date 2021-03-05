#!/usr/bin/env python3

import argparse
import re

from graphviz import Digraph


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
        self.instructions.append(self._escape(instruction))

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
            assert(self.no_jump_edge is not None)
            label += '|{<s0>No Jump|<s1>Jump}'
        return '{' + label + '}'

    def __str__(self):
        return '\n'.join(self.instructions)

    def __repr__(self):
        return '\n'.join(self.instructions)

    def _escape(self, instruction):
        instruction = instruction.replace('<', r'\<')
        instruction = instruction.replace('>', r'\>')
        instruction = instruction.replace('|', r'\|')
        instruction = instruction.replace('{', r'\{')
        instruction = instruction.replace('}', r'\}')
        return instruction


def print_assembly(basic_blocks):
    """
    Debug function to print the assembly.
    """
    for basic_block in basic_blocks.values():
        print(basic_block)
        print()


def read_lines(file_path):
    lines = []
    with open(file_path, 'r') as asm_file:
        lines = asm_file.readlines()
    return lines


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
    memory_range_pattern = re.compile(r'from (0x[0-9a-fA-F]+) to (0x[0-9a-fA-F]+):$')
    function_name = function_name_pattern.search(line)
    memory_range = memory_range_pattern.search(line)
    if function_name is None and memory_range is None:
        print('First line of the file does not contain a function name or valid memory range')
        exit(1)
    if function_name is None:
        return [True, f'{memory_range[1]}-{memory_range[2]}']
    return [False, function_name[1]]


def get_jump_pattern(stripped, function_name):
    """
    Return regexp pattern used to identify jump/call assembly lines. Support
    for stripped and non-stripped versions.

    Need to match non-stripped lines:
    '0x00007ffff7fbf124 <+68>:  jmp  0x7ffff7fbf7c2 <test_function+1762>'
    and stripped lines:
    '0x000055555555600f:        jmp  0x55555555603d'
    """
    if stripped:
        return re.compile(r'0x0*([01-9a-fA-F]+):\W+\w+\W+0x0*([01-9a-fA-F]+)$')
    return re.compile(fr'<\+(\d+)>:.+<{function_name}\+(\d+)>')


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
        return re.compile(r'0x0*([0-9a-fA-F]+):\W+(.+)$')
    return re.compile(r'<\+(\d+)>:\W+(.+)$')


def parse_lines(lines):
    stripped, function_name = get_stripped_and_function_name(lines[0])
    branch_points = set()
    jump_table = {}
    jump_destinations = set()
    jump_pattern = get_jump_pattern(stripped, function_name)

    # Iterate over the lines and collect jump targets and branching points.
    for line in lines[1:-1]:
        match = jump_pattern.search(line)
        if match is not None:
            branch_point = match[1]
            jump_point = match[2]
            branch_points.add(branch_point)
            branch_points.add(jump_point)
            jump_table[branch_point] = jump_point
            jump_destinations.add(jump_point)

    # Now iterate over the assembly again and split it to basic blocks using
    # the jump information from earlier.
    line_pattern = get_assembly_line_pattern(stripped)
    basic_blocks = {}
    current_basic_block = None
    previous_jump_block = None
    for line in lines[1:-1]:
        line_match = line_pattern.search(line)
        if line_match is not None:
            program_point = line_match[1]
            instruction = line_match[2]
            if current_basic_block is None:
                current_basic_block = BasicBlock(program_point)
                current_basic_block.add_instruction(instruction)
                # Previous basic block ended in jump instruction. Add the basic
                # block what follows if the jump was not taken.
                if previous_jump_block is not None:
                    previous_jump_block.add_no_jump_edge(current_basic_block)
                    previous_jump_block = None
            elif program_point in jump_destinations:
                temp_block = current_basic_block
                basic_blocks[current_basic_block.key] = current_basic_block
                current_basic_block = BasicBlock(program_point)
                current_basic_block.add_instruction(instruction)
                temp_block.add_no_jump_edge(current_basic_block)
            elif program_point in branch_points:
                current_basic_block.add_instruction(instruction)
                current_basic_block.add_jump_edge(jump_table[program_point])
                basic_blocks[current_basic_block.key] = current_basic_block
                previous_jump_block = current_basic_block
                current_basic_block = None
            else:
                current_basic_block.add_instruction(instruction)
        else:
            print(f'unsupported line: {line}')
            exit(1)

    # Add the last basic block from end of the function.
    basic_blocks[current_basic_block.key] = current_basic_block
    return [function_name, basic_blocks]


def draw_cfg(function_name, basic_blocks):
    dot = Digraph(name=function_name, comment=function_name, engine='dot')
    dot.attr('graph', label=function_name)
    for key, basic_block in basic_blocks.items():
        dot.node(key, shape='record', label=basic_block.get_label())
    for basic_block in basic_blocks.values():
        if basic_block.jump_edge:
            dot.edge(f'{basic_block.key}:s0', basic_block.no_jump_edge)
            dot.edge(f'{basic_block.key}:s1', basic_block.jump_edge)
        elif basic_block.no_jump_edge:
            dot.edge(basic_block.key, basic_block.no_jump_edge)
    dot.render(filename=function_name, cleanup=True, format='pdf')


def main():
    parser = argparse.ArgumentParser(
        description='Program to draw dot control-flow graph from GDB disassembly for a function'
    )
    parser.add_argument('assembly_file',
                        help='File to contain one function assembly dump')
    args = parser.parse_args()
    lines = read_lines(args.assembly_file)
    [function_name, basic_blocks] = parse_lines(lines)
    draw_cfg(function_name, basic_blocks)


if __name__ == '__main__':
    main()
