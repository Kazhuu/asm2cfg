import argparse
import re

from graphviz import Digraph


class BasicBlock:

    def __init__(self, key):
        self.key = key
        self.instructions = []
        self.jump_edge = None
        self.no_jump_edge = None

    def add_instruction(self, instruction):
        self.instructions.append(self._escape(instruction))

    def add_jump_edge(self, basic_block_key):
        if isinstance(basic_block_key, BasicBlock):
            self.jump_edge = basic_block_key.key
        else:
            self.jump_edge = basic_block_key

    def add_no_jump_edge(self, basic_block_key):
        if isinstance(basic_block_key, BasicBlock):
            self.no_jump_edge = basic_block_key.key
        else:
            self.no_jump_edge = basic_block_key

    def get_label(self):
        label = r'\l'.join(self.instructions)
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


def read_lines(file_path):
    lines = []
    with open(file_path, 'r') as asm_file:
        lines = asm_file.readlines()
    return lines


def get_function_name(line):
    function_start_pattern = re.compile(r'(\w+):$')
    function_name = function_start_pattern.search(line)
    if function_name is None:
        print('First line of the file does not contain a function name')
        exit(1)
    return function_name[1]


def parse_lines(lines):
    function_name = get_function_name(lines[0])
    branch_points = set()
    jump_table = {}
    jump_destinations = set()
    jump_pattern = re.compile(fr'<\+(\d+)>:.+<{function_name}\+(\d+)>')
    for line in lines[1:-1]:
        match = jump_pattern.search(line)
        if match is not None:
            branch_point = match[1]
            jump_point = match[2]
            branch_points.add(branch_point)
            branch_points.add(jump_point)
            jump_table[branch_point] = jump_point
            jump_destinations.add(jump_point)

    line_pattern = re.compile(r'<\+(\d+)>:[\t\s]+(\b.+)')
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
    print(dot.source)
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
