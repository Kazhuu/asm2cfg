#!/usr/bin/env python
# SPDX-License-Identifier: GTDGmbH
"""
Let this module be executed from the command line with python -m ocgraph
from root of the project
"""
import argparse

from .interface.analyzer import Analyzer
from .interface.drawer import Drawer
from .interface.coverage_reader import CoverageReader

from .configuration.configuration import OcGraphConfiguration


def print_assembly(basic_blocks):
    """Debug function to print the assembly."""
    for basic_block in basic_blocks.values():
        print(basic_block)


def read_lines(file_path) -> list[str]:
    """Read lines from the file and return then as a list."""
    with open(file_path, "r", encoding="utf8") as asm_file:
        lines = asm_file.readlines()
    return lines


def main():
    """Command-line entry point to the program."""
    parser = argparse.ArgumentParser(description="Assembly to Control-Flow-Graph rendering.")

    parser.add_argument(
        "-f",
        "--file",
        help="Disassembled object file",
        required=True,
    )
    parser.add_argument(
        "-d",
        "--diss",
        help="Disassembler option",
        required=True,
        choices=OcGraphConfiguration.disassemblers(),
    )
    parser.add_argument(
        "-a",
        "--arch",
        help="Architecture option",
        required=True,
        choices=OcGraphConfiguration.architectures(),
    )

    parser.add_argument("-c", "--coverage", help="Coverage file for printing coverage")
    parser.add_argument("-v", "--view", action="store_true", help="View as a dot graph")
    parser.add_argument("-o", "--output", help="Target output filename")
    parser.add_argument(
        "-l",
        "--logger",
        choices=OcGraphConfiguration.loggers(),
        default="default",
        help="Logging mechanism preset",
    )
    args = parser.parse_args()

    # Create configuration
    config = OcGraphConfiguration(
        disassembler=args.diss, arch=args.arch, logging_preset=args.logger
    )

    lines = read_lines(args.file)

    analyser = Analyzer(config=config)
    analyser.parse_lines(lines=lines)

    if args.coverage:
        cov_reader = CoverageReader(instructions=analyser.instructions, config=config)
        cov_reader.update_by_csv(args.coverage)

    drawer = Drawer(analyser.configuration)
    drawer.draw_cfg(
        name=analyser.function_name, basic_blocks=analyser.basic_blocks, output=args.output
    )


if __name__ == "__main__":
    main()
