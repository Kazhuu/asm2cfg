import unittest

from src.asm2cfg import asm2cfg


def _get_the_source_block(blocks):
    sources = [block for _, block in blocks.items() if block.jump_edge is not None]
    return sources[0] if len(sources) == 1 else None


class ParseLineTestCase(unittest.TestCase):
    @unittest.expectedFailure
    def test_linear_sequence(self):
        lines = '''\
Dump of assembler code for function main:
   0x000055555556f952 <+2>:	mov    $0x1,%ecx
   0x000055555556f957 <+7>:	push   %r14
   0x000055555556f959 <+9>:	push   %r13
   0x000055555556f95b <+11>:	push   %r12
   0x000055555556f95d <+13>:	push   %rbp
   0x000055555556f95e <+14>:	push   %rbx\
'''.split('\n')
        _, blocks = asm2cfg.parse_lines(lines, False)

        self.assertEqual(len(blocks), 1)
        _, block = blocks.popitem()
        self.assertEqual(len(block.instructions), 6)  # FIXME
        self.assertIs(block.jump_edge, None)
        self.assertIs(block.no_jump_edge, None)

    def test_unconditional(self):
        lines = '''\
Dump of assembler code for function main:
   0x000055555556fffb <+1707>:	jmp    0x555555570058 <main+1800>
   0x0000555555570058 <+1800>:	mov    0xe0(%rsp),%rdi
   0x0000555555570060 <+1808>:	test   %rdi,%rdi
'''.split('\n')
        _, blocks = asm2cfg.parse_lines(lines, False)

        self.assertEqual(len(blocks), 2)

        source_block = _get_the_source_block(blocks)
        self.assertIsNot(source_block.jump_edge, None)
        self.assertIs(source_block.no_jump_edge, None)
        self.assertEqual(len(source_block.instructions), 1)

        dst_block = blocks[source_block.jump_edge]
        self.assertIs(dst_block.jump_edge, None)
        self.assertIs(dst_block.no_jump_edge, None)
        self.assertEqual(len(dst_block.instructions), 2)

    def test_conditional(self):
        lines = '''\
Dump of assembler code for function main:
   0x000055555556fffb <+1707>:	je    0x555555570058 <main+1800>
   0x000055555556fffd <+1709>:	push   %rbx
   0x000055555556fffe <+1710>:	mov    %r15,%r8
   0x000055555556fffe <+1710>:	mov    %r15,%r8
   0x0000555555570058 <+1800>:	mov    0xe0(%rsp),%rdi
   0x0000555555570060 <+1808>:	test   %rdi,%rdi
'''.split('\n')
        _, blocks = asm2cfg.parse_lines(lines, False)

        self.assertEqual(len(blocks), 3)

        source_block = _get_the_source_block(blocks)
        self.assertIsNot(source_block.jump_edge, None)
        self.assertIsNot(source_block.no_jump_edge, None)
        self.assertEqual(len(source_block.instructions), 1)

        fall_block = blocks[source_block.no_jump_edge]
        self.assertIs(fall_block.jump_edge, None)
        self.assertIsNot(fall_block.no_jump_edge, None)
        self.assertEqual(len(fall_block.instructions), 3)

        dst_block = blocks[source_block.jump_edge]
        self.assertIs(dst_block.jump_edge, None)
        self.assertIs(dst_block.no_jump_edge, None)
        self.assertEqual(len(dst_block.instructions), 2)

    # TODO:
    # - functions (with and w/o calls)
    # - jumptables
    # - skip calls
