#!/usr/bin/env python3
"""Contains instruction info for PPC-compatible targets."""

from .architecture import Architecture
from ...data.instruction import Instruction


# fmt: off
sparc_v8_Bicc_opcodes = [
    # conditional icc branch opcodes
    "ba", "bn", "bne", "be", "bg", "ble", "bge", "bl", "bgu", "bleu", "bcc",
    "bcs", "bpos", "bneg", "bvc", "bvs",
]

sparc_v8_FBfcc_opcodes = [
    # conditional fcc branch opcodes
    "fba", "fbn", "fbu", "fbg", "fbug", "fbl", "fbul", "fblg", "fbne", "fbe",
    "fbue", "fbge", "fbuge", "fble", "fbule", "fbo",
]

sparc_v8_CBfcc_opcodes = [
    # conditional coprocessor opcodes
    "cba", "cbn", "cb3", "cb2", "cb23", "cb1", "cb13", "cb12", "cb123", "cb0",
    "cb03", "cb02", "cb023", "cb01", "cb013", "cb012",
]

sparc_v8_Ticc_opcodes = [
    # condictional traps on icc
    "ta", "tn", "tne", "te", "tg", "tle", "tge", "tl", "tgu", "tleu", "tcc",
    "tcs", "tpos", "tneg", "tvc", "tvs",
]

sparc_v8_branch_cond_delay_opcodes = [
    f"{x},a" for x in
    sparc_v8_Bicc_opcodes +
    sparc_v8_FBfcc_opcodes +
    sparc_v8_CBfcc_opcodes
]

sparc_v8_remaining_jump_opcodes = [
    "jmpl", "jmp", "b",  # "call", "ret", retl not regarded currently
]

sparc_v8_delayed_opcodes = sparc_v8_Bicc_opcodes + \
                           sparc_v8_FBfcc_opcodes + \
                           sparc_v8_CBfcc_opcodes + \
                           sparc_v8_branch_cond_delay_opcodes + \
                           sparc_v8_remaining_jump_opcodes

sparc_v8_jump_opcodes = sparc_v8_Bicc_opcodes + \
                          sparc_v8_FBfcc_opcodes + \
                          sparc_v8_CBfcc_opcodes + \
                          sparc_v8_Ticc_opcodes + \
                          sparc_v8_branch_cond_delay_opcodes + \
                          sparc_v8_remaining_jump_opcodes

sparc_v8_branch_opcodes = sparc_v8_Bicc_opcodes + \
                          sparc_v8_FBfcc_opcodes + \
                          sparc_v8_CBfcc_opcodes + \
                          sparc_v8_branch_cond_delay_opcodes
# fmt: on


class PpcArchitecture(Architecture):
    """PpccArchitecture Class"""

    def comment(self):
        return "!"

    def is_call(self, instruction: Instruction):
        return instruction.opcode == "call"

    def is_jump(self, instruction: Instruction):
        return instruction.opcode in sparc_v8_jump_opcodes

    def get_jump_delay(self, instruction: Instruction) -> int | None:
        delay = None
        if instruction.opcode in sparc_v8_delayed_opcodes:
            delay = 2
        elif self.is_sink(instruction):
            delay = 2
        else:
            delay = 1
        return delay

    def is_direct_jump(self, instruction: Instruction):
        # every jump is disassembled with the complete offset
        return self.is_jump(instruction)

    def is_branch(self, instruction: Instruction):
        return instruction.opcode in sparc_v8_branch_opcodes

    def is_sink(self, instruction: Instruction):
        # ret: return from subroutine
        # retl: return from leaf subroutine
        return instruction.opcode in ["ret", "retl"]
