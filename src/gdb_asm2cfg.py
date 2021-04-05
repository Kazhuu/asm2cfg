# This file includes the GDB extension for asm2cfg. Commands and settings are
# exposed to GDB by extending the certain classes.
# For further information see
# https://sourceware.org/gdb/current/onlinedocs/gdb/Python.html#Python.


import gdb
import traceback

from asm2cfg import asm2cfg


class SkipCalls(gdb.Parameter):
    """
    Set \'on\' to prevent function calls from splitting assembly to further
    blocks. This will provide speedup when rendering CFG if function is
    big. Current value:"""

    def __init__(self):
        super(SkipCalls, self).__init__('skipcalls', gdb.COMMAND_DATA, gdb.PARAM_BOOLEAN)
        self.value = False
        self.set_doc = SkipCalls.__doc__
        self.show_doc = SkipCalls.__doc__


class ViewCfg(gdb.Command):
    """
    Draw an assembly control-flow graph (CFG) of the currently executed
    function. If function is big and CFG rendering takes too long, try to
    skip function calls from splitting the code with 'set skipcalls on'. Or
    save the graph with 'savecfg' command and view it with other program.'
    """

    def __init__(self):
        super(ViewCfg, self).__init__('viewcfg', gdb.COMMAND_USER)

    def invoke(self, arg, from_tty):
        try:
            assembly_lines = gdb.execute('disassemble', from_tty=False, to_string=True).split('\n')
            [function_name, basic_blocks] = asm2cfg.parse_lines(assembly_lines, gdb.parameter('skipcalls'))
            asm2cfg.draw_cfg(function_name, basic_blocks, view=True)
        # Catch error coming from GDB side before other errors.
        except gdb.error as e:
            raise gdb.GdbError(e)
        except Exception as e:
            traceback.print_exc()
            raise gdb.GdbError(e)


class SaveCfg(gdb.Command):
    """
    Save an assembly control-flow graph (CFG) of the currently executed
    function. If function is big and CFG rendering takes too long, try to
    skip function calls from splitting the code with 'set skipcalls on'.
    """

    def __init__(self):
        super(SaveCfg, self).__init__('savecfg', gdb.COMMAND_USER)

    def invoke(self, arg, from_tty):
        try:
            assembly_lines = gdb.execute('disassemble', from_tty=False, to_string=True).split('\n')
            [function_name, basic_blocks] = asm2cfg.parse_lines(assembly_lines, gdb.parameter('skipcalls'))
            asm2cfg.draw_cfg(function_name, basic_blocks, view=False)
        # Catch error coming from GDB side before other errors.
        except gdb.error as e:
            raise gdb.GdbError(e)
        except Exception as e:
            traceback.print_exc()
            raise gdb.GdbError(e)


# Instantiate the settings and commands.
SkipCalls()
ViewCfg()
SaveCfg()
