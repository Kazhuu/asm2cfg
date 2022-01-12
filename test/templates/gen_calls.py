#!/usr/bin/env python3

"""
Generate different flavors of input assembly for testing.
"""

# TODO: find a way to produce other snippets we see in disasm:
#  call   *%rax
#  call   *0x8(%rax)
#  addr32 call 0x5555555733e0
#  call   0x555555576a00

import os.path

from common import set_basename, gcc, disasm, grep

set_basename(os.path.basename(__file__))

for gdb in [False, True]:
    for pic in [False, True]:  # Do we need to test PIE too?
        for plt in [False, True]:
            for direct in [False, True] if pic else [True]:
                for strip in [False, True]:
                    # Print config

                    disasm_type = 'GDB' if gdb else 'objdump'
                    pic_type = 'position-INdependent' if pic else 'position-dependent'
                    call_type = 'Non-PIC-call' if direct else 'PIC-call'
                    strip_type = 'stripped' if strip else 'UNstripped'
                    plt_type = 'PLT' if plt else 'PLT-less'
                    print(f"Checking {disasm_type} {pic_type} {plt_type} {call_type} {strip_type}")

                    # Generate object code

                    flags = ['call.c', '-o', 'a.out',
                             '-Wl,--defsym,_start=0', '-nostdlib', '-nostartfiles']
                    # DLL or executable?
                    if pic:
                        flags += ['-fPIC', '-shared']
                    # Use PLT?
                    if not plt:
                        flags += ['-fno-plt']
                    # Force non-PLT call for PIC code?
                    if direct and pic:
                        flags.append('-DHIDDEN')
                    # Include debuginfo?
                    if not strip:
                        # FIXME: for real stripping of symtab we need to run
                        # `strip a.out` and `strip -s a.out`.
                        # This should be done for other tests too.
                        flags.append('-g')

                    gcc(flags)

                    # Generate disasm

                    caller = 'bar'
                    out = disasm('a.out', not gdb, strip, caller)

                    # Print snippets

                    headers = grep(out, fr'<{caller}>:|Dump of')
                    calls = grep(out, r'call')
                    print('''\
  headers:
    {0}
  calls:
    {1}
'''.format('\n    '.join(headers), '\n    '.join(calls)))
