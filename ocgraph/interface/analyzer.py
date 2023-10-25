#!/usr/bin/env python3
"""Class for read and analyze the input string."""

import sys
import re

from ..data.address import Address
from ..data.basic_block import BasicBlock
from ..data.encoding import Encoding
from ..data.instruction import Instruction
from ..data.jump_table import JumpTable

from ..configuration.configuration import OcGraphConfiguration, Disassembler

# Common regexes
HEX_PATTERN = r"[0-9a-fA-F]+"
HEX_LONG_PATTERN = r"(?:0x0*)" + HEX_PATTERN


class Analyzer:
    """Analyzer Class"""

    def __init__(self, config: OcGraphConfiguration):
        self.configuration = config
        self.logger = self.configuration.logger
        self.parser: Disassembler = self.configuration.disassembler

        self.lines: list[str] = []
        self.function_name = None
        self.instructions: list[Instruction] = []
        self.jump_table = None
        self.basic_blocks: dict[int, BasicBlock] = {}

    def parse_file(self, file_path: str):
        """Parse a assembler file"""
        with open(file_path, "r", encoding="utf8") as asm_file:
            lines = asm_file.readlines()
        self.parse_lines(lines)

    def parse_lines(self, lines):
        """Parse a list of assembly lines"""
        self.lines = lines
        self._parse_instructions()
        self._compute_jump_targets()
        self._create_jump_table()
        self._create_basic_blocks()

    def _parse_instructions(self):
        self.instructions = []
        for num, line in enumerate(self.lines, 1):
            current_function_name = self.parser.parse_function_header(line)
            if current_function_name is not None:
                if self.function_name is not None:
                    raise RuntimeError("we handle only one function for now")
                self.logger.info(f"New function {current_function_name}")
                self.function_name = current_function_name
                continue

            instruction_or_encoding = self.parser.parse_line(line, num, self.function_name)
            if isinstance(instruction_or_encoding, Encoding):
                # Partial encoding for previous instruction, skip it
                continue
            if instruction_or_encoding is not None:
                self.instructions.append(instruction_or_encoding)
                continue

            if line.startswith("End of assembler dump") or not line:
                continue

            if line.strip() == "":
                continue

            self.logger.error(f"Unexpected assembly at line {num}:\n  {line}")
            sys.exit(1)

    def _compute_jump_targets(self):
        # Infer target address for jump instructions
        for instr in self.instructions:
            if (
                instr.target is None or instr.target.abs is None
            ) and self.configuration.architecture.is_direct_branch(instr):
                if instr.target is None:
                    instr.target = Address(0)
                # parse the absolute target out of the operands
                # (first hex address is assumed to be the target address)
                print("direct branch without target: " + str(instr))
                instr.target.abs = int(re.search(rf"{HEX_LONG_PATTERN}", '|'.join(instr.ops))[0], 16)

        # Infer relative addresses (for objdump or stripped gdb)
        start_address = self.instructions[0].address.abs
        end_address = self.instructions[-1].address.abs
        for instr in self.instructions:
            for addr in (instr.address, instr.target):
                if (
                    addr is not None
                    and addr.offset is None
                    and start_address <= addr.abs <= end_address
                ):
                    addr.offset = addr.abs - start_address

        self.logger.debug("Instructions:")
        for instruction in self.instructions:
            if instruction is not None:
                self.logger.debug(f"  {instruction}")

    def _create_jump_table(self):
        self.jump_table = JumpTable(self.instructions, self.configuration)

        self.logger.debug("Absolute destinations:")
        for dst in self.jump_table.abs_destinations:
            self.logger.debug(f"  {dst:#x}")
        self.logger.debug("Relative destinations:")
        for dst in self.jump_table.rel_destinations:
            self.logger.debug(f"  {dst:#x}")
        self.logger.debug("Absolute branches:")
        for key, addr in self.jump_table.abs_sources.items():
            self.logger.debug(f"  {key:#x} -> {addr}")
        self.logger.debug("Relative branches:")
        for key, addr in self.jump_table.rel_sources.items():
            self.logger.debug(f"  {key:#x} -> {addr}")

    def _create_basic_blocks(self) -> None:
        """
        Now iterate over the assembly again and split it to basic blocks using the branching
        information from earlier.
        """
        self.basic_blocks = {}

        curr_basic_block: BasicBlock | None = None
        # Store last block if ending with branch opcode
        prev_branch_block: BasicBlock | None = None

        # block completion flag (introduced for SPARC pipeline)
        block_completion: int = 0

        for instruction in self.instructions:
            # if block completion is in progress
            if block_completion > 0:
                block_completion -= 1
                if block_completion > 0:
                    self.basic_blocks[curr_basic_block.key].add_instruction(instruction)
                    continue
                curr_basic_block = None

            # Current program counter
            pc_addr = instruction.address
            # Get optional jump target
            jump_target = self.jump_table.get_target(pc_addr)
            print("jump target: " + str(jump_target))
            is_unconditional = self.configuration.architecture.is_unconditional_branch(instruction)

            # Start new blocks if last ended
            if curr_basic_block is None:
                # Create new basic block
                self.basic_blocks[pc_addr.abs] = curr_basic_block = BasicBlock(key=pc_addr.abs)

                # if previous basic block ended in branch instruction. Add the basic
                # block what follows if the jump was not taken.
                if prev_branch_block is not None:
                    prev_branch_block.add_no_jump_edge(curr_basic_block)
                    prev_branch_block = None
            # or if current address is a jump target
            elif self.jump_table.is_jump_target(pc_addr):
                closing_block = curr_basic_block
                self.basic_blocks[pc_addr.abs] = curr_basic_block = BasicBlock(key=pc_addr.abs)
                closing_block.add_no_jump_edge(pc_addr.abs)

            curr_basic_block.add_instruction(instruction)

            # End current block if current opcode is a jump/branch/sink
            if jump_target:
                print("has jump target: " + str(instruction))
                curr_basic_block.add_jump_edge(jump_target.abs)
                prev_branch_block = None if is_unconditional else curr_basic_block
                block_completion = self.configuration.architecture.get_branch_delay(instruction)
            elif self.configuration.architecture.is_sink(instruction):
                block_completion = self.configuration.architecture.get_branch_delay(instruction)
                prev_branch_block = None

        if prev_branch_block is not None:
            # If last instruction of the function is jump/call, then add dummy
            # block to designate end of the function.
            end_instruction = Instruction("", "end of function", 0, None, None, [], None)
            end_block = BasicBlock("end_of_function")
            end_block.add_instruction(end_instruction)
            prev_branch_block.add_no_jump_edge(end_block.key)
            self.basic_blocks[end_block.key] = end_block
