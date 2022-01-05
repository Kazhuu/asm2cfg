#!/usr/bin/env python3

"""
Generate different flavors of input assembly for testing.
"""

import os.path

from common import set_basename, run, gcc, disasm, find_address, grep

set_basename(os.path.basename(__file__))

for gdb in [False, True]:
    for pic in [False, True]:  # Do we need to test PIE too?
        for direct in [False, True] if pic else [True]:
            for strip in [False, True]:
                # Print config

                disasm_type = 'GDB' if gdb else 'objdump'
                pic_type = 'position-INdependent' if pic else 'position-dependent'
                call_type = 'PIC-call' if direct else 'PLT-call'
                stripped = 'stripped' if strip else 'UNstripped'
                print(f"Checking {disasm_type} {pic_type} {call_type} {stripped}")

                # Generate object code

                flags = ['call.c', '-o', 'a.out',
                         '-Wl,--defsym,_start=0', '-nostdlib', '-nostartfiles']
                # Shlib or executable?
                if pic:
                    flags += ['-fPIC', '-shared']
                # Force non-PLT call for PIC code?
                if direct and pic:
                    flags.append('-DHIDDEN')
                # Include debuginfo?
                if not strip:
                    flags.append('-g')

                out = gcc(flags)

                # Generate disasm

                caller = 'bar'

                if gdb:
                    if strip:
                        # This is tricky as we can not use symbol name
                        start, finish = find_address('a.out', caller)
                        out = run(['gdb', '-batch', '-ex', f'disassemble {start},{finish}', 'a.out'])
                    else:
                        out = run(['gdb', '-batch', '-ex', f'disassemble {caller}', 'a.out'])
                else:
                    out = disasm('a.out')

                # Print snippets

                headers = grep(out, fr'<{caller}>:|Dump of')
                print('\n    '.join(['  headers:'] + headers))
                calls = grep(out, r'call')
                print('\n    '.join(['  calls:'] + calls))
