"""
Test cases to test GDB integration.
"""
import subprocess
import os
import re


def test_savecfg_help():
    result = gdb_execute_command('help savecfg')
    assert 'Save an assembly control-flow graph (CFG)' in result.stdout


def test_viewcfg_help():
    result = gdb_execute_command('help viewcfg')
    assert 'Draw an assembly control-flow graph (CFG)' in result.stdout


def test_help_set():
    result = gdb_execute_command('help set')
    assert 'set skipcalls -- Set whether savecfg and viewcfg commands will skip function' in result.stdout


def test_help_set_skipcalls():
    result = gdb_execute_command('help set skipcalls')
    assert 'Set whether savecfg and viewcfg commands will skip function' in result.stdout


def test_help_show_skipcalls():
    result = gdb_execute_command('help show skipcalls')
    assert 'Set whether savecfg and viewcfg commands will skip function' in result.stdout


def test_show_skipcalls():
    result = gdb_execute_command('show skipcalls')
    assert 'Commands savecfg and viewcfg will' in result.stdout


def test_skipcalls_inital_value():
    result = gdb_execute_command('show skipcalls')
    assert parse_option_value(result.stdout) == 'off'


def test_change_skipcalls_value():
    result = gdb_execute_command('set skipcalls')
    assert parse_option_value(result.stdout) == 'on'


def gdb_execute_command(command):
    project_root_path = os.getcwd()
    os.environ['PYTHONPATH'] = f'{project_root_path}/src/'
    gdb_script_path = f'{project_root_path}/src/gdb_asm2cfg.py'
    result = subprocess.run(
        ['gdb', '-ex', f'source {gdb_script_path}', '-ex', command, '-ex', 'q'],
        stdout=subprocess.PIPE, stdin=None, timeout=1, check=True, universal_newlines=True,
    )
    return result


def parse_option_value(gdb_output):
    output_pattern = re.compile(r'blocks: (on|off)')
    result = output_pattern.search(gdb_output)
    if result:
        return result.group(1)
    return result
