#!/usr/bin/env python3
"""Represents location in program which may be absolute or relative"""


class Address:
    """Address Class"""

    def __init__(self, abs_addr: int, base: int = None, offset: int = None):
        self.abs = abs_addr
        self.base = base
        self.offset = offset

    def is_absolute(self):
        """Return if address is absolute"""
        return self.base is None

    def is_relative(self):
        """Return if address is relative"""
        return not self.is_absolute()

    def __str__(self):
        if self.offset is not None:
            return f"0x{self.abs:x} ({self.base}+0x{self.offset:x})"
        if isinstance(self.abs, int):
            return f"0x{self.abs:x}"
        return str(self.abs)
