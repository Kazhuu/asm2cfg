#!/usr/bin/env python3
"""Contains instruction info for PPC-compatible targets."""

import re

from .architecture import Architecture
from ...data.instruction import Instruction


# Common regexes
HEX_PATTERN = r'[0-9a-fA-F]+'
HEX_LONG_PATTERN = r'(?:0x0*)' + HEX_PATTERN

# fmt: off
ppc_call_opcodes = [
    "bl",
]

ppc_sink_opcodes = [
    "blr",
]

ppc_unconditional_branch_opcodes = [
    "b", "ba", "bla",
    "bctr", "bctrl", "blrl",
]

ppc_conditional_branch_opcodes = [
    "bc", "bt", "bf", "bdnz", "bdnzt", "bdnzf", "bdz", "bdzt", "bdzf",
    "bca", "bta", "bfa", "bdnza", "bdnzta", "bdnzfa", "bdza", "bdzta", "bdzfa",
    "bcl", "btl", "bfl", "bdnzl", "bdnztl", "bdnzfl", "bdzl", "bdztl", "bdzfl",
    "bcla", "bdtla", "bdfla", "bdnzla", "bdnztla", "bdnzfla", "bdzla", "bdztla", "bdzfla",
    "bclr", "btlr", "bflr", "bdnzlr", "bdnztlr", "bdnzflr", "bdzlr", "bdztlr", "bdzflr",
    "bclrl", "btlrl", "bflrl", "bdnzlrl", "bdnztlrl", "bdnzflrl", "bdzlrl", "bdztlrl", "bdzflrl",
    "bcctr", "btctr", "bfctr",
    "bcctrl", "btctrl", "bfctrl",
]
# fmt: on


class PpcArchitecture(Architecture):
    """PpcArchitecture Class"""

    def comment(self):
        return "#"

    def is_call(self, instruction: Instruction):
        return instruction.opcode in ppc_call_opcodes

    def is_branch(self, instruction: Instruction):
        return instruction.opcode in (ppc_conditional_branch_opcodes + ppc_unconditional_branch_opcodes) and not self.is_call(instruction)

    def is_unconditional_branch(self, instruction: Instruction):
        return instruction.opcode in ppc_unconditional_branch_opcodes

    def is_sink(self, instruction: Instruction):
        return instruction.opcode in ppc_sink_opcodes

    def is_direct_branch(self, instruction: Instruction):
        return self.is_branch(instruction) and (re.search(rf"{HEX_LONG_PATTERN}", '|'.join(instruction.ops)))
