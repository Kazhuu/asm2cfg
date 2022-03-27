"""
This file includes the GDB extension for asm2cfg. Commands and settings are
exposed to GDB by extending the certain classes.
For further information see
https://sourceware.org/gdb/current/onlinedocs/gdb/Python.html#Python.
"""


import traceback

import gdb

from asm2cfg import asm2cfg


class SkipCalls(gdb.Parameter):
    """Manage skipcalls parameter.

    Usage: set skipcalls
           set skipcalls off
    """

    set_doc = 'Set whether savecfg and viewcfg commands will skip function calls from splitting CFG blocks'
    show_doc = 'Set whether savecfg and viewcfg commands will skip function calls from splitting CFG blocks'

    def __init__(self):
        super().__init__('skipcalls', gdb.COMMAND_DATA, gdb.PARAM_BOOLEAN)
        self.value = False

    def get_set_string(self):
        return f'Commands savecfg and viewcfg will skip function calls \
                from splitting CFG blocks: {self.value_to_string()}'

    def get_show_string(self, _):
        return f'Commands savecfg and viewcfg will skip function calls \
                from splitting CFG blocks: {self.value_to_string()}'

    def value_to_string(self):
        if self.value:
            return 'on'
        return 'off'


class ViewCfg(gdb.Command):  # pylint: disable=too-few-public-methods
    """
    Draw an assembly control-flow graph (CFG) of the currently executed
    function. If function is big and CFG rendering takes too long, try to
    skip function calls from splitting the code with 'set skipcalls on'. Or
    save the graph with 'savecfg' command and view it with other program.'
    """

    def __init__(self):
        super().__init__('viewcfg', gdb.COMMAND_USER)

    def invoke(self, _arg, _from_tty):  # pylint: disable=no-self-use
        """ Called by GDB when viewcfg command is invoked """
        try:
            frame = gdb.selected_frame()
            arch = frame.architecture().name()
            if arch.startswith('i386'):
                target_name = 'x86'
            elif arch.startswith('arm'):
                target_name = 'arm'
            else:
                raise RuntimeError(f'unknown platform: {arch}')
            assembly_lines = gdb.execute('disassemble', from_tty=False, to_string=True).split('\n')
            function_name, basic_blocks = asm2cfg.parse_lines(assembly_lines, gdb.parameter('skipcalls'),
                                                              target_name)
            asm2cfg.draw_cfg(function_name, basic_blocks, view=True)
        # Catch error coming from GDB side before other errors.
        except gdb.error as ex:
            raise gdb.GdbError(ex)
        except Exception as ex:
            traceback.print_exc()
            raise gdb.GdbError(ex)


class SaveCfg(gdb.Command):  # pylint: disable=too-few-public-methods
    """
    Save an assembly control-flow graph (CFG) of the currently executed
    function. If function is big and CFG rendering takes too long, try to
    skip function calls from splitting the code with 'set skipcalls on'.
    """

    def __init__(self):
        super().__init__('savecfg', gdb.COMMAND_USER)

    def invoke(self, _arg, _from_tty):  # pylint: disable=no-self-use
        """ Called by GDB when savecfg command is invoked """
        try:
            assembly_lines = gdb.execute('disassemble', from_tty=False, to_string=True).split('\n')
            function_name, basic_blocks = asm2cfg.parse_lines(assembly_lines, gdb.parameter('skipcalls'),
                                                              'x86')
            asm2cfg.draw_cfg(function_name, basic_blocks, view=False)
        # Catch error coming from GDB side before other errors.
        except gdb.error as ex:
            raise gdb.GdbError(ex)
        except Exception as ex:
            traceback.print_exc()
            raise gdb.GdbError(ex)


# Instantiate the settings and commands.
SkipCalls()
ViewCfg()
SaveCfg()
