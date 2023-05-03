#!/usr/bin/env python3
"""
Represents a sequence of bytes used for instruction encoding
e.g. the '31 c0' in
'16bd3:	31 c0                	xor    %eax,%eax'
"""


class Encoding:
    """Encoding Class"""

    def __init__(self, bites):
        self.bites = bites

    def size(self):
        """Return size of the bytes"""
        return len(self.bites)

    def __str__(self):
        return " ".join(map(lambda b: f"{b:#x}", self.bites))
