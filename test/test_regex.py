import unittest

from src.asm2cfg import asm2cfg


class FunctionHeaderTestCase(unittest.TestCase):
    def test_gdb_unstripped(self):
        line = 'Dump of assembler code for function test_function:'
        strip, fun = asm2cfg.get_stripped_and_function_name(line)

        self.assertFalse(strip)
        self.assertEqual(fun, 'test_function')

    def test_gdb_stripped(self):
        line = 'Dump of assembler code from 0x555555555faf to 0x555555557008:'
        strip, fun = asm2cfg.get_stripped_and_function_name(line)

        self.assertTrue(strip)
        self.assertEqual(fun, '0x555555555faf-0x555555557008')

    @unittest.expectedFailure
    def test_objdump(self):
        line = '000000000000100b <bar>:'
        strip, fun = asm2cfg.get_stripped_and_function_name(line)

        self.assertFalse(strip)
        self.assertEqual(fun, 'bar')


class CallPatternTestCase(unittest.TestCase):
    def setUp(self):
        self.strip_regex = asm2cfg.get_call_pattern(True)
        self.unstrip_regex = asm2cfg.get_call_pattern(False)

    def test_stripped_known(self):
        line = '0x000055555557259c:	addr32 call 0x55555558add0 <_Z19exportDebugifyStats>'
        call_match = self.strip_regex.match(line)

        self.assertIsNot(call_match, None)
        self.assertEqual(call_match[1], '55555557259c')
        self.assertEqual(call_match[2], '0x55555558add0 <_Z19exportDebugifyStats>')  # FIXME: keep just symbolic name?

    @unittest.expectedFailure
    def test_unstripped_known(self):
        line = '0x000055555557259c <+11340>:	addr32 call 0x55555558add0 <_Z19exportDebugifyStats>'
        call_match = self.unstrip_regex.match(line)

        self.assertIsNot(call_match, None)  # FIXME
        self.assertEqual(call_match[1], '11340')
        self.assertEqual(call_match[2], '???')

    def test_stripped_pic(self):
        line = '0x000055555556fd8c:	call   *0x26a16(%rip)        # 0x5555555967a8'
        call_match = self.strip_regex.match(line)

        self.assertIsNot(call_match, None)
        self.assertEqual(call_match[1], '55555556fd8c')
        self.assertEqual(call_match[2], '*0x26a16(%rip)        # 0x5555555967a8')  # FIXME: remove trash

    @unittest.expectedFailure
    def test_objdump_plt(self):
        line = '1048:	e8 d3 ff ff ff       	callq  1020 <foo@plt>'
        call_match = self.strip_regex.match(line)

        self.assertIsNot(call_match, None)
        self.assertEqual(call_match[1], '1048')
        self.assertEqual(call_match[2], '1020 <foo@plt>')

    @unittest.expectedFailure
    def test_gdb_plt(self):
        line = '0x0000000000001048 <bar+13>:	callq  0x1020 <foo@plt>'
        call_match = self.strip_regex.match(line)

        self.assertIsNot(call_match, None)
        self.assertEqual(call_match[1], '1048')
        self.assertEqual(call_match[2], 'callq  0x1020 <foo@plt>')

    def test_stripped_nonpic(self):
        line = '0x0000555555556188:	call   0x555555555542'
        call_match = self.strip_regex.match(line)

        self.assertIsNot(call_match, None)
        self.assertEqual(call_match[1], '555555556188')
        self.assertEqual(call_match[2], '0x555555555542')


class JumpPatternTestCase(unittest.TestCase):
    def test_stripped_jump(self):
        line = '0x000055555555600f:        jmp  0x55555555603d'
        pattern = asm2cfg.get_jump_pattern(True, 'does_not_matter')
        jump_match = pattern.search(line)

        self.assertIsNot(jump_match, None)
        self.assertEqual(jump_match[1], '55555555600f')
        self.assertEqual(jump_match[2], '55555555603d')

    @unittest.expectedFailure
    def test_objdump(self):
        line = '1017:	eb 06                	jmp    101f <bar+0x1f>'
        pattern = asm2cfg.get_jump_pattern(False, 'does_not_matter')
        jump_match = pattern.search(line)

        self.assertIsNot(jump_match, None)
        self.assertEqual(jump_match[1], '1017')
        self.assertEqual(jump_match[2], '101f <bar+0x1f>')

    def test_non_stripped_jump(self):
        line = '0x00007ffff7fbf124 <+68>:  jmp  0x7ffff7fbf7c2 <test_function+1762>'
        pattern = asm2cfg.get_jump_pattern(False, 'test_function')
        jump_match = pattern.search(line)

        self.assertIsNot(jump_match, None)
        self.assertEqual(jump_match[1], '68')
        self.assertEqual(jump_match[2], '1762')
