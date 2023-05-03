#!/usr/bin/env python3
"""Holds info about branch sources and destinations in asm function."""

from typing import List, Dict, Set

from .address import Address
from .instruction import Instruction
from ..configuration.configuration import OcGraphConfiguration


class JumpTable:
    """JumpTable Class"""

    def __init__(self, instructions: List[Instruction], configuration: OcGraphConfiguration):
        self.config: OcGraphConfiguration = configuration

        # Address where the jump begins and value which address
        # to jump to. This also includes calls.
        self.abs_sources: Dict[int, Address] = {}
        self.rel_sources: Dict[int, Address] = {}

        # Addresses where jumps end inside the current function.
        self.abs_destinations: Set[int] = set()
        self.rel_destinations: Set[int] = set()

        # Iterate over the lines and collect jump targets and branching points.
        for instr in instructions:
            if instr is None or not self.config.architecture.is_direct_jump(instr):
                continue

            self.abs_sources[instr.address.abs] = instr.target
            self.abs_destinations.add(instr.target.abs)

            self.rel_sources[instr.address.offset] = instr.target
            self.rel_destinations.add(instr.target.offset)

    def is_jump_target(self, addr: Address) -> bool:
        """Return if address is a destination"""
        if addr.abs is not None:
            return addr.abs in self.abs_destinations
        if addr.offset is not None:
            return addr.offset in self.rel_destinations
        return False

    def get_target(self, addr: Address):
        """Return the target of a branch"""
        if addr.abs is not None:
            return self.abs_sources.get(addr.abs)
        if addr.offset is not None:
            return self.rel_sources.get(addr.offset)
        return None
