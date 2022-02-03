import unittest
import subprocess
import os
import re


class GdbTestCase(unittest.TestCase):

    def test_savecfg_help(self):
        result = self.gdb_execute_command("help savecfg")
        assert "Save an assembly control-flow graph (CFG)" in result.stdout

    def test_viewcfg_help(self):
        result = self.gdb_execute_command("help viewcfg")
        assert "Draw an assembly control-flow graph (CFG)" in result.stdout

    def test_help_set(self):
        result = self.gdb_execute_command("help set")
        assert 'set skipcalls -- Set whether savecfg and viewcfg commands will skip function' in result.stdout

    def test_help_set_skipcalls(self):
        result = self.gdb_execute_command("help set skipcalls")
        assert 'Set whether savecfg and viewcfg commands will skip function' in result.stdout

    def test_help_show_skipcalls(self):
        result = self.gdb_execute_command("help show skipcalls")
        assert 'Set whether savecfg and viewcfg commands will skip function' in result.stdout

    def test_show_skipcalls(self):
        result = self.gdb_execute_command("show skipcalls")
        assert "Commands savecfg and viewcfg will" in result.stdout

    def test_skipcalls_inital_value(self):
        result = self.gdb_execute_command("show skipcalls")
        assert self.parse_option_value(result.stdout) == 'off'

    def test_change_skipcalls_value(self):
        result = self.gdb_execute_command("set skipcalls")
        assert self.parse_option_value(result.stdout) == 'on'

    def gdb_execute_command(self, command):
        project_root_path = os.getcwd()
        os.environ["PYTHONPATH"] = "{0}/src/".format(project_root_path)
        gdb_script_path = "{0}/src/gdb_asm2cfg.py".format(project_root_path)
        result = subprocess.run(
            ["gdb", "-ex", "source {0}".format(gdb_script_path), "-ex", command, "-ex", "q"],
            stdout=subprocess.PIPE, stdin=None, timeout=1, check=True, text=True,
        )
        return result

    def parse_option_value(self, gdb_output):
        output_pattern = re.compile(r'blocks: (on|off)')
        result = output_pattern.search(gdb_output)
        if result:
            return result.group(1)
        else:
            return result
