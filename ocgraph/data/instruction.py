#!/usr/bin/env python3
"""Represents a single assembly instruction with it operands, location and optional branch target"""
from enum import Enum
from typing import List

from .address import Address


class Coverage(Enum):
    """Enumeration for coverage records"""

    MISS = "missed"
    """Indicates instruction is not executed"""
    LINE_TAKEN = "taken"
    """Indicates instruction is executed"""
    JUMP_PASS = "skipped"
    """Indicates, if branch is just passed without jump"""
    JUMP_TAKEN = "jumped"
    """Indicates, if branch is just jumped without passed"""
    JUMP_BOTH = "both taken"
    """Indicates, if branch is just jumped without passed"""


class Instruction:
    """Instruction Class"""

    body: str = None
    """Disassembled instruction code (without extra information)"""

    text: str = None
    """Complete Disassembled instruction code"""

    lineno: int = None
    """Line number in the file"""

    address: Address = None
    """Computed address of the instruction"""

    opcode: str = None
    """Disassembled opcode"""

    ops: List[str] = []
    """Disassembled operands of the instruction"""

    target: Address = None
    """Optional target of the instruction (branch)"""

    returns: set[int] = set()
    """Stores addresses of sink instructions like return"""

    coverage: Coverage = Coverage.MISS
    """If line is executed on test"""

    branch_taken: bool = None

    def __init__(self, body, text, lineno, address, opcode, ops, target):
        self.body = body
        self.text = text
        self.lineno = lineno
        self.address = address
        self.opcode = opcode
        self.ops = ops
        self.target = target
        self.returns = set()
        self.coverage = Coverage.MISS

    def update_coverage(self, addresses: set[int], is_branch=False) -> None:
        """Update the coverage information of the instruction."""
        if not is_branch:
            # exception for ret (target is None) or call (target.abs is None)
            self.coverage = Coverage.LINE_TAKEN
            self.returns = addresses
        elif len(addresses) == 2 and self.target.abs in addresses:
            self.coverage = Coverage.JUMP_BOTH
        elif len(addresses) == 1 and self.target.abs in addresses:
            self.coverage = Coverage.JUMP_TAKEN
        elif len(addresses) == 1:
            self.coverage = Coverage.JUMP_PASS
        else:
            raise AssertionError(f"Invalid Coverage Information at {self.address}: {addresses}")

    def __str__(self):
        result = f"{self.address}: {self.opcode}"
        if self.ops:
            result += f" {self.ops}"
        if self.target is not None:
            result += " -> " + str(self.target)
        return result

    def __repr__(self) -> str:
        result = f"{self.address}: {self.opcode}"
        if self.ops:
            result += f" {self.ops}"
        if self.target is not None:
            result += " -> " + str(self.target)
        return result
