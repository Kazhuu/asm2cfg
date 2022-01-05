import subprocess
import sys
import re
import os

_me = os.path.basename(__file__)
v = 0


def set_basename(file):
    global _me
    _me = file


def error(msg):
    """
    Print nicely-formatted error message and exit.
    """
    sys.stderr.write(f'{_me}: error: {msg}\n')
    sys.exit(1)


def run(cmd, stdin=None):
    if v:
        print(f"{_me}: running command: {' '.join(cmd)}")
    with subprocess.Popen(cmd, stdin=stdin, stdout=subprocess.PIPE,
                          stderr=subprocess.PIPE) as p:
        out, err = p.communicate()
    out = out.decode()
    err = err.decode()
    if p.returncode != 0:
        cmds = ' '.join(cmd)
        error(f"'{cmds}' failed:\n{out}{err}")
    sys.stderr.write(err)
    return out


def gcc(args):
    return run(['gcc'] + args)


def disasm(file):
    return run(['objdump', '-d', file])


def grep(s, regex):
    lines = s.split('\n')
    return list(filter(lambda s: re.search(regex, s), lines))


def find_address(file, name):
    out = run(['readelf', '-sW', file])
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
