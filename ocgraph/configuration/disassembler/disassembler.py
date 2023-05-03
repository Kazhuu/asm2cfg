#!/usr/bin/env python3
# SPDX-License-Identifier: GTDGmbH
# Copyright 2023 by GTD GmbH.
"""Class configuring the used disassembler tool."""

from abc import ABC, abstractmethod

from ..architecture.sparc import SparcArchitecture
from ...data.instruction import Instruction


class DisassemblerError(Exception):
    """Raised when the extract_information method was not successful."""


class Disassembler(ABC):
    """Disassembler Class"""

    def __init__(self):
        self.architecture = SparcArchitecture()

    name: str = ""
    """ Disassembler tool identification like SparcV8Objdump, GDB, ..."""

    @abstractmethod
    def extract_information(self, str_input: str) -> dict[str, str]:
        """Specification of the extracted information. Required attributes are:
        * address = instruction location in the binary
        * location: instruction address location
        * instr_d: instruction in disassembled format
        * instr_h: instruction in hex-notation
        * opcode: instruction opcode
        * printable: a printable line of the collected information
        """
        raise NotImplementedError()

    @abstractmethod
    def parse_function_header(self, line: str) -> str | None:
        """Return function name of memory range from the given string line."""
        raise NotImplementedError()

    @abstractmethod
    def parse_line(self, line: str, lineno, function_name: str) -> Instruction | None:
        """Parses a single line of assembly to create Instruction instance"""
