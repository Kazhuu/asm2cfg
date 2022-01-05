#!/usr/bin/env python3

"""
Generate different flavors of input assembly for testing.
"""

import os.path

from common import set_basename, run, gcc, disasm, find_address, grep

set_basename(os.path.basename(__file__))

for gdb in [False, True]:
    for pic in [False, True]:  # Do we need to test PIE too?
        for strip in [False, True]:
            # Print config

            disasm_type = 'GDB' if gdb else 'objdump'
            pic_type = 'position-INdependent' if pic else 'position-dependent'
            stripped = 'stripped' if strip else 'UNstripped'
            print(f"Checking {disasm_type} {pic_type} {stripped}")

            # Generate object code

            flags = ['jump.c', '-o', 'a.out',
                     '-Wl,--defsym,_start=0', '-nostdlib', '-nostartfiles']
            # Shlib or executable?
            if pic:
                flags += ['-fPIC', '-shared']
            # Include debuginfo?
            if not strip:
                flags.append('-g')

            out = gcc(flags)

            # Generate disasm

            if gdb:
                # This is tricky as we can not use symbol name
                start, finish = find_address('a.out', 'bar')
                out = run(['gdb', '-batch', '-ex', f'disassemble {start},{finish}', 'a.out'])
            else:
                out = disasm('a.out')

            # Print snippets

            jumps = grep(out, r'ju?mp')
            print('\n    '.join(['  jumps:'] + jumps))
