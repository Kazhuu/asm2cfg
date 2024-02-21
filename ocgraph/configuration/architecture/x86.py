#!/usr/bin/env python
# SPDX-License-Identifier: GTDGmbH
"""Contains instruction info for X86-compatible targets."""

import re

from .architecture import Architecture
from ...data.instruction import Instruction

# Common regexes
HEX_PATTERN = r"[0-9a-fA-F]+"
HEX_LONG_PATTERN = r"(?:0x0*)?" + HEX_PATTERN


class X86Architecture(Architecture):
    """X86Architecture Class"""

    def comment(self):
        return "#"

    def is_call(self, instruction: Instruction):
        # Various flavors of call:
        #   call   *0x26a16(%rip)
        #   call   0x555555555542
        #   addr32 call 0x55555558add0
        return "call" in instruction.opcode

    def is_branch(self, instruction: Instruction):
        return instruction.opcode[0] == "j"

    def is_direct_branch(self, instruction: Instruction):
        return self.is_branch(instruction) and re.match(rf"{HEX_LONG_PATTERN}", instruction.ops[0])

    def is_unconditional_branch(self, instruction: Instruction):
        return instruction.opcode.startswith("jmp")

    def is_sink(self, instruction: Instruction):
        return instruction.opcode.startswith("ret")
