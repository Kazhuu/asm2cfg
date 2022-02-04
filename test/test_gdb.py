"""
Test cases to test GDB integration.
"""
import subprocess
import os
import re


def test_savecfg_help():
    result = execute_gdb_command('help savecfg')
    assert 'Save an assembly control-flow graph (CFG)' in result.stdout


def test_viewcfg_help():
    result = execute_gdb_command('help viewcfg')
    assert 'Draw an assembly control-flow graph (CFG)' in result.stdout


def test_help_set():
    result = execute_gdb_command('help set')
    assert 'set skipcalls -- Set whether savecfg and viewcfg commands will skip function' in result.stdout


def test_help_set_skipcalls():
    result = execute_gdb_command('help set skipcalls')
    assert 'Set whether savecfg and viewcfg commands will skip function' in result.stdout


def test_help_show_skipcalls():
    result = execute_gdb_command('help show skipcalls')
    assert 'Set whether savecfg and viewcfg commands will skip function' in result.stdout


def test_show_skipcalls():
    result = execute_gdb_command('show skipcalls')
    assert 'Commands savecfg and viewcfg will' in result.stdout


def test_skipcalls_inital_value():
    result = execute_gdb_command('show skipcalls')
    assert parse_option_value(result.stdout) == 'off'


def test_change_skipcalls_value():
    result = execute_gdb_command('set skipcalls')
    assert parse_option_value(result.stdout) == 'on'


def test_savecfg():
    result = execute_gdb_commands(['set confirm off', 'file ls', 'starti', 'savecfg'])
    assert 'Saved CFG to a file _start.pdf' in result.stdout, result.stdout


def execute_gdb_command(command):
    return execute_gdb_commands([command])


def execute_gdb_commands(commands):
    project_root_path = os.getcwd()
    os.environ['PYTHONPATH'] = f'{project_root_path}/src/'
    gdb_script_path = f'{project_root_path}/src/gdb_asm2cfg.py'
    gdb_command = ['gdb', '-ex', f'source {gdb_script_path}']
    for command in commands:
        gdb_command.append('-ex')
        gdb_command.append(command)
    gdb_command.append('-ex')
    gdb_command.append('q')
    result = subprocess.run(
        gdb_command, stdout=subprocess.PIPE, stdin=None,
        stderr=None, timeout=3, check=True, universal_newlines=True,
    )
    return result


def parse_option_value(gdb_output):
    output_pattern = re.compile(r'blocks: (on|off)')
    result = output_pattern.search(gdb_output)
    if result:
        return result.group(1)
    return result
