import argparse
import re

from graphviz import Digraph


class BasicBlock:

    def __init__(self, key):
        self.key = key
        self.instructions = []
        self.edges = []

    def add_instruction(self, instruction):
        self.instructions.append(self._escape(instruction))

    def add_edge(self, basic_block_key):
        if isinstance(basic_block_key, BasicBlock):
            self.edges.append(basic_block_key.key)
        else:
            self.edges.append(basic_block_key)

    def get_edges(self):
        edges = []
        for index, key in enumerate(self.edges):
            edges.append(f'{key}')
        return edges

    def get_label(self):
        label = r'\l'.join(self.instructions)
        if self.edges:
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
                if previous_jump_block is not None:
                    previous_jump_block.add_edge(current_basic_block)
                    previous_jump_block = None
            elif program_point in jump_destinations:
                temp_block = current_basic_block
                basic_blocks[current_basic_block.key] = current_basic_block
                current_basic_block = BasicBlock(program_point)
                current_basic_block.add_instruction(instruction)
                temp_block.add_edge(current_basic_block)
            elif program_point in branch_points:
                current_basic_block.add_instruction(instruction)
                current_basic_block.add_edge(jump_table[program_point])
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
    dot = Digraph(comment=function_name, engine='dot', format='pdf')
    for key, basic_block in basic_blocks.items():
        dot.node(key, shape='record', label=basic_block.get_label())
    for basic_block in basic_blocks.values():
        for edge_to_key in basic_block.get_edges():
            dot.edge(basic_block.key, edge_to_key)
    # dot.save(function_name)
    print(dot.source)
    dot.view()


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
