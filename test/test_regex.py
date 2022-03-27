"""
Unittests of asm2cfg's regexes
"""

import unittest

from src.asm2cfg import asm2cfg


class FunctionHeaderTestCase(unittest.TestCase):
    """
    Tests of function header regex
    """

    def test_gdb_unstripped(self):
        line = 'Dump of assembler code for function test_function:'
        fmt, fun = asm2cfg.parse_function_header(line)

        self.assertEqual(fmt, asm2cfg.InputFormat.GDB)
        self.assertEqual(fun, 'test_function')

    def test_gdb_stripped(self):
        line = 'Dump of assembler code from 0x555555555faf to 0x555555557008:'
        fmt, fun = asm2cfg.parse_function_header(line)

        self.assertEqual(fmt, asm2cfg.InputFormat.GDB)
        self.assertEqual(fun, '0x555555555faf-0x555555557008')

    def test_objdump(self):
        line = '000000000000100b <bar>:'
        fmt, fun = asm2cfg.parse_function_header(line)

        self.assertEqual(fmt, asm2cfg.InputFormat.OBJDUMP)
        self.assertEqual(fun, 'bar')


class ParseAddressTestCase(unittest.TestCase):
    """
    Tests of parse_address function
    """

    def test_absolute(self):
        line = '0x000055555557259c:	XYZ'
        address, rest = asm2cfg.parse_address(line)

        self.assertIsNot(address, None)
        self.assertEqual(address.abs, 0x55555557259c)
        self.assertIs(address.base, None)
        self.assertIs(address.offset, None)
        self.assertEqual(rest, '	XYZ')

    def test_relative(self):
        line = '0x000055555557259c <+11340>:	XYZ'
        address, rest = asm2cfg.parse_address(line)

        self.assertIsNot(address, None)
        self.assertEqual(address.abs, 0x55555557259c)
        self.assertIs(address.base, None)
        self.assertEqual(address.offset, 11340)
        self.assertEqual(rest, '	XYZ')


class ParseBodyTestCase(unittest.TestCase):
    """
    Tests of asm2cfg.parse_body function
    """

    def setUp(self):
        self.target_info = asm2cfg.X86TargetInfo()

    def test_gdb_stripped_known(self):
        line = '	call 0x55555558add0 <_Z19exportDebugifyStats>'
        body, opcode, ops, rest = asm2cfg.parse_body(line, self.target_info)

        self.assertIsNot(body, None)
        self.assertEqual(body, 'call 0x55555558add0')
        self.assertEqual(opcode, 'call')
        self.assertEqual(ops, ['0x55555558add0'])
        self.assertEqual(rest, '<_Z19exportDebugifyStats>')

    def test_gdb_stripped_pic(self):
        line = '    call   *0x26a16(%rip)        # 0x5555555967a8'
        body, opcode, ops, rest = asm2cfg.parse_body(line, self.target_info)

        self.assertIsNot(body, None)
        self.assertEqual(body, 'call   *0x26a16(%rip)')
        self.assertEqual(opcode, 'call')
        self.assertEqual(ops, ['*0x26a16(%rip)'])
        self.assertEqual(rest, '# 0x5555555967a8')

    def test_gdb_plt(self):
        line = '	callq  0x1020 <foo@plt>'
        body, opcode, ops, rest = asm2cfg.parse_body(line, self.target_info)

        self.assertIsNot(body, None)
        self.assertEqual(body, 'callq  0x1020')
        self.assertEqual(opcode, 'callq')
        self.assertEqual(ops, ['0x1020'])
        self.assertEqual(rest, '<foo@plt>')

    def test_gdb_stripped_nonpic(self):
        line = '	call   0x555555555542'
        body, opcode, ops, rest = asm2cfg.parse_body(line, self.target_info)

        self.assertIsNot(body, None)
        self.assertEqual(body, 'call   0x555555555542')
        self.assertEqual(opcode, 'call')
        self.assertEqual(ops, ['0x555555555542'])
        self.assertEqual(rest, '')

    def test_gdb_indirect_call(self):
        line = '	callq  *(%rsi)'
        body, opcode, ops, rest = asm2cfg.parse_body(line, self.target_info)

        self.assertIsNot(body, None)
        self.assertEqual(body, 'callq  *(%rsi)')
        self.assertEqual(opcode, 'callq')
        self.assertEqual(ops, ['*(%rsi)'])
        self.assertEqual(rest, '')


class ParseTargetTestCase(unittest.TestCase):
    """
    Tests of parse_address function
    """

    def test_with_offset(self):
        line = '<_Z19exportDebugifyStats+123>'
        address, rest = asm2cfg.parse_target(line)

        self.assertIsNot(address, None)
        self.assertIs(address.abs, None)
        self.assertEqual(address.base, '_Z19exportDebugifyStats')
        self.assertEqual(address.offset, 123)
        self.assertEqual(rest, '')

    def test_with_neg_offset(self):
        line = '<_Z19exportDebugifyStats-123>'
        address, rest = asm2cfg.parse_target(line)

        self.assertIsNot(address, None)
        self.assertIs(address.abs, None)
        self.assertEqual(address.base, '_Z19exportDebugifyStats')
        self.assertEqual(address.offset, -123)
        self.assertEqual(rest, '')

    def test_without_offset(self):
        line = '<_Z19exportDebugifyStats>'
        address, rest = asm2cfg.parse_target(line)

        self.assertIsNot(address, None)
        self.assertIs(address.abs, None)
        self.assertEqual(address.base, '_Z19exportDebugifyStats')
        self.assertEqual(address.offset, 0)
        self.assertEqual(rest, '')


class ParseCommentTestCase(unittest.TestCase):
    """
    Tests of parse_comment function
    """

    def setUp(self):
        self.target_info = asm2cfg.X86TargetInfo()

    def test_absolute(self):
        line = '# 0x5555555967a8'
        address, rest = asm2cfg.parse_comment(line, self.target_info)

        self.assertIsNot(address, None)
        self.assertEqual(address.abs, 0x5555555967a8)
        self.assertIs(address.base, None)
        self.assertIs(address.offset, None)
        self.assertEqual(rest, '')

    def test_symbolic(self):
        line = '# 0x5555555967a8 <foo>'
        address, rest = asm2cfg.parse_comment(line, self.target_info)

        self.assertIsNot(address, None)
        self.assertEqual(address.abs, 0x5555555967a8)
        self.assertEqual(address.base, 'foo')
        self.assertIs(address.offset, 0)
        self.assertEqual(rest, '')

    def test_complete(self):
        line = '# 3ff8 <foo+0x2ff8>'
        address, rest = asm2cfg.parse_comment(line, self.target_info)

        self.assertIsNot(address, None)
        self.assertEqual(address.abs, 0x3ff8)  # FIXME: support hex offsets
        self.assertEqual(address.base, 'foo')
        self.assertEqual(address.offset, 0x2ff8)
        self.assertEqual(rest, '')
