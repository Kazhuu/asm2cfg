import subprocess
import sys
import re
import os

_me = os.path.basename(__file__)
verbose = 0


def set_basename(file):
    global _me
    _me = file


def error(msg):
    """
    Print nicely-formatted error message and exit.
    """
    sys.stderr.write(f'{_me}: error: {msg}\n')
    sys.exit(1)


def _run(cmd, stdin=None):
    if verbose:
        print(f"{_me}: running command: {' '.join(cmd)}")
    with subprocess.Popen(cmd, stdin=stdin, stdout=subprocess.PIPE,
                          stderr=subprocess.PIPE) as process:
        out, err = process.communicate()
    out = out.decode()
    err = err.decode()
    if process.returncode != 0:
        cmds = ' '.join(cmd)
        error(f"'{cmds}' failed:\n{out}{err}")
    sys.stderr.write(err)
    return out


def gcc(args):
    return _run(['gcc'] + args)


def disasm(file, objdump_or_gdb, strip=None, symbol=None):
    if objdump_or_gdb:
        out = _run(['objdump', '-d', file])
    elif strip:
        # This is tricky as we can not use symbol name
        start, finish = _find_address(file, symbol)
        out = _run(['gdb', '-batch', '-ex', f'disassemble {start},{finish}', file])
    else:
        out = _run(['gdb', '-batch', '-ex', f'disassemble {symbol}', file])
    return out


def grep(s, regex):
    lines = s.split('\n')
    return list(filter(lambda s: re.search(regex, s), lines))


def _find_address(file, name):
    out = _run(['readelf', '-sW', file])
    lines = grep(out, fr'{name}$')
    assert len(lines) >= 1, f"failed to locate symbol {name} in\n{out}"
    line = lines[0]
    #   Num:    Value          Size Type    Bind   Vis      Ndx Name
    #    27: 0000000000001030    11 FUNC    GLOBAL DEFAULT    9 foo
    line = line.strip()
    words = re.split(r'\s+', line)
    start = int(words[1], 16)
    size = int(words[2])
    return start, start + size
