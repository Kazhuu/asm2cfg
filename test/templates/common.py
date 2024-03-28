"""
Common code shared by all generators
"""

import subprocess
import sys
import re
import os

_ME = os.path.basename(__file__)


def set_basename(file):
    global _ME  # pylint: disable=global-statement
    _ME = file


def error(msg):
    """
    Print nicely-formatted error message and exit.
    """
    sys.stderr.write(f"{_ME}: error: {msg}\n")
    sys.exit(1)


def _run(cmd, stdin=None, verbose=0):
    """
    Run process and abort on error.
    """
    if verbose:
        print(f"{_ME}: running command: {' '.join(cmd)}")
    with subprocess.Popen(
        cmd, stdin=stdin, stdout=subprocess.PIPE, stderr=subprocess.PIPE
    ) as process:
        out, err = process.communicate()
    out = out.decode()
    err = err.decode()
    if process.returncode != 0:
        cmds = " ".join(cmd)
        error(f"'{cmds}' failed:\n{out}{err}")
    sys.stderr.write(err)
    return out


def gcc(args):
    """
    Run compiler with given arguments.
    """
    return _run(["gcc"] + args)


def disasm(file, objdump_or_gdb, symbol, start, finish):
    """
    Disassemble binary file.
    """
    if objdump_or_gdb:
        out = _run(["objdump", "-d", file])
    elif symbol is not None:
        out = _run(["gdb", "-batch", "-ex", f"disassemble {symbol}", file])
    else:
        out = _run(["gdb", "-batch", "-ex", f"disassemble {start},{finish}", file])
    return out


def strip_binary(file):
    """
    Strip symbol info from binary file.
    """
    _run(["strip", "-s", file])


def grep(text, regex):
    lines = text.split("\n")
    return list(filter(lambda s: re.search(regex, s), lines))


def find_address(file, name):
    out = _run(["readelf", "-sW", file])
    lines = grep(out, rf"{name}$")
    assert len(lines) >= 1, f"failed to locate symbol {name} in\n{out}"
    line = lines[0]
    #   Num:    Value          Size Type    Bind   Vis      Ndx Name
    #    27: 0000000000001030    11 FUNC    GLOBAL DEFAULT    9 foo
    line = line.strip()
    words = re.split(r"\s+", line)
    start = int(words[1], 16)
    size = int(words[2])
    return start, start + size
