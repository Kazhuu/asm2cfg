#!/usr/bin/env python
# SPDX-License-Identifier: GTDGmbH
""" Contains instruction info for ARM-compatible targets. """

import re

from .architecture import Architecture
from ...data.instruction import Instruction

# Common regexes
HEX_PATTERN = r"[0-9a-fA-F]+"
HEX_LONG_PATTERN = r"(?:0x0*)?" + HEX_PATTERN


class ArmArchitecture(Architecture):
    """ArmArchitecture Class"""

    def comment(self):
        return ";"

    def is_call(self, instruction: Instruction):
        # Various flavors of call:
        #   bl 0x19d90 <_IO_vtable_check>
        # Note that we should be careful to not mix it with conditional
        # branches like 'ble'.
        return instruction.opcode.startswith("bl") and instruction.opcode not in (
            "blt",
            "ble",
            "bls",
        )

    def is_branch(self, instruction: Instruction):
        return instruction.opcode[0] == "b" and not self.is_call(instruction)

    def is_direct_branch(self, instruction: Instruction):
        return self.is_branch(instruction) and re.match(rf"{HEX_LONG_PATTERN}", instruction.ops[0])

    def is_unconditional_branch(self, instruction: Instruction):
        return instruction.opcode == "b"

    def is_sink(self, instruction: Instruction):
        """
        Is this an instruction which terminates function execution e.g. return?
        Detect various flavors of return like
          bx lr
          pop {r2-r6,pc}
        Note that we do not consider conditional branches (e.g. 'bxle') to sink.
        """
        return (
            re.search(r"\bpop\b.*\bpc\b", instruction.body)
            or (instruction.opcode == "bx" and instruction.ops[0] == "lr")
            or instruction.opcode == "udf"
        )
