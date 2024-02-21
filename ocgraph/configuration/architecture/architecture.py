#!/usr/bin/env python
# SPDX-License-Identifier: GTDGmbH
"""Contains all necessary functions for a TargetInfo class."""

from abc import ABC, abstractmethod

from ...data.instruction import Instruction


class Architecture(ABC):
    """TargetInfo Class defining the target specific instruction set characteristics"""

    def __init__(self):
        pass

    @abstractmethod
    def comment(self) -> str:
        """Return how comments starts in the disassembly"""
        raise NotImplementedError()

    @abstractmethod
    def is_call(self, instruction: Instruction) -> bool:
        """Return if disassembled instruction is a subroutine call"""
        raise NotImplementedError()

    @abstractmethod
    def is_unconditional_branch(self, instruction: Instruction) -> bool:
        """Return if disassembled instruction is an unconditional branch"""
        raise NotImplementedError()

    def get_branch_delay(self, instruction: Instruction) -> int | None:
        """Return the branch delay of an instruction or None if not a branch"""
        return 1 if self.is_branch(instruction) else None

    @abstractmethod
    def is_direct_branch(self, instruction: Instruction) -> bool:
        """Return if disassembled instruction is a direct branch"""
        raise NotImplementedError()

    @abstractmethod
    def is_branch(self, instruction: Instruction) -> bool:
        """Return if disassembled instruction is a branch instruction (conditional or unconditional)"""
        raise NotImplementedError()

    @abstractmethod
    def is_sink(self, instruction: Instruction) -> bool:
        """Return if disassembled instruction serves as sink (e.g. ret)"""
        raise NotImplementedError()
