#!/usr/bin/env python3
"""Contains all necessary functions for a TargetInfo class."""

from abc import ABC, abstractmethod

from ...data.instruction import Instruction


class Architecture(ABC):
    """TargetInfo Class"""

    def __init__(self):
        pass

    @abstractmethod
    def comment(self) -> str:
        """Return how comments starts in the disassembly"""
        raise NotImplementedError()

    @abstractmethod
    def is_call(self, instruction: Instruction) -> bool:
        """Return if disassembled instruction is a call"""
        raise NotImplementedError()

    @abstractmethod
    def is_jump(self, instruction: Instruction) -> bool:
        """Return if disassembled instruction is a jump"""
        raise NotImplementedError()

    def get_jump_delay(self, instruction: Instruction) -> int | None:
        """Return the jump delay of an instruction or None if not a jump"""
        return 1 if self.is_jump(instruction) else None

    @abstractmethod
    def is_direct_jump(self, instruction: Instruction) -> bool:
        """Return if disassembled instruction is a direct jump"""
        raise NotImplementedError()

    @abstractmethod
    def is_branch(self, instruction: Instruction) -> bool:
        """Return if disassembled instruction is a conditional jump"""
        raise NotImplementedError()

    @abstractmethod
    def is_sink(self, instruction: Instruction) -> bool:
        """Return if disassembled instruction serves as sink (e.g. ret)"""
        raise NotImplementedError()
