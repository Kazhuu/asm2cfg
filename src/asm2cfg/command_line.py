"""
Command-line usage support.
"""

import argparse
from . import asm2cfg


def main():
    """ Command-line entry point to the program. """
    parser = argparse.ArgumentParser(
        description='Program to draw dot control-flow graph from GDB disassembly for a function.',
        epilog='If function CFG rendering takes too long, try to skip function calls with -c flag.'
    )
    parser.add_argument('assembly_file',
                        help='File to contain one function assembly dump')
    parser.add_argument('-c', '--skip-calls', action='store_true',
                        help='Skip function calls from dividing code to blocks')
    parser.add_argument('--target', choices=['x86', 'arm'], default='x86',
                        help='Specify target platform for assembly')
    parser.add_argument('-v', '--view', action='store_true',
                        help='View as a dot graph instead of saving to a file')
    args = parser.parse_args()
    print('If function CFG rendering takes too long, try to skip function calls with -c flag')
    lines = asm2cfg.read_lines(args.assembly_file)
    function_name, basic_blocks = asm2cfg.parse_lines(lines, args.skip_calls, args.target)
    asm2cfg.draw_cfg(function_name, basic_blocks, args.view)
