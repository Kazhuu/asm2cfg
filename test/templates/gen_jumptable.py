#!/usr/bin/env python3

"""
Generate different flavors of input assembly for testing.
"""

import os.path
import itertools

from common import set_basename, gcc, disasm, grep, strip_binary, find_address

set_basename(os.path.basename(__file__))

for gdb, pic, strip in itertools.product([False, True],
                                         [False, True],  # Do we need to test PIE too?
                                         [False, True]):
    # Print config

    disasm_type = 'GDB' if gdb else 'objdump'
    pic_type = 'position-INdependent' if pic else 'position-dependent'
    stripped = 'stripped' if strip else 'UNstripped'
    print(f'Checking {disasm_type} {pic_type} {stripped}')

    # Generate object code

    flags = ['jumptable.c', '-o', 'a.out',
             '-Wl,--defsym,_start=0', '-nostdlib', '-nostartfiles', '-O2']
    # DLL or executable?
    if pic:
        flags += ['-fPIC', '-shared']

    gcc(flags)

    # Strip

    caller = 'bar'
    start, finish = find_address('a.out', caller)
    if strip:
        strip_binary('a.out')
        caller = None

    # Generate disasm

    out = disasm('a.out', not gdb, caller, start, finish)

    # Print snippets

    jumps = grep(out, r'\bjmp')
    print('''\
  table jumps:
    {}
'''.format('\n    '.join(jumps)))
