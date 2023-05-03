#!/usr/bin/env python3
"""Class to represent a node in CFG with lines of code without jump or calls instructions."""

from typing import List

from .instruction import Instruction


class BasicBlock:
    """Basic Block Class"""

    def __init__(self, key):
        self.key = key
        self.instructions: List[Instruction] = []
        self.jump_edge = None
        self.no_jump_edge = None

    def add_instruction(self, instruction):
        """Add instruction to this block."""
        self.instructions.append(instruction)

    def add_jump_edge(self, basic_block_key) -> None:
        """Add jump target block to this block."""
        if isinstance(basic_block_key, BasicBlock):
            self.jump_edge = basic_block_key.key
        else:
            self.jump_edge = basic_block_key

    def add_no_jump_edge(self, basic_block_key) -> None:
        """Add no jump target block to this block."""
        if isinstance(basic_block_key, BasicBlock):
            self.no_jump_edge = basic_block_key.key
        else:
            self.no_jump_edge = basic_block_key

    def __str__(self) -> str:
        return "\n".join([i.text for i in self.instructions])

    def __repr__(self) -> str:
        return "\n".join([i.text for i in self.instructions])
