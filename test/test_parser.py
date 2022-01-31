"""
Unittests of asm2cfg's assembly parser
"""

import unittest

from src.asm2cfg import asm2cfg


def _get_the_source_block(blocks):
    sources = [block for _, block in blocks.items() if block.jump_edge is not None]
    return sources[0] if len(sources) == 1 else None


class ParseLineTestCase(unittest.TestCase):
    """
    Tests of parse_line function
    """

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

    @unittest.expectedFailure
    def test_jumptables(self):
        lines = '''\
Dump of assembler code for function bar:
   0x0000000000001070 <+0>:	endbr64
   0x0000000000001074 <+4>:	cmp    $0x9,%edi
   0x0000000000001077 <+7>:	ja     0x1120 <bar+176>
   0x000000000000107d <+13>:	lea    0xf80(%rip),%rdx        # 0x2004
   0x0000000000001084 <+20>:	mov    %edi,%edi
   0x0000000000001086 <+22>:	sub    $0x8,%rsp
   0x000000000000108a <+26>:	movslq (%rdx,%rdi,4),%rax
   0x000000000000108e <+30>:	add    %rdx,%rax
   0x0000000000001091 <+33>:	notrack jmpq *%rax
   0x0000000000001094 <+36>:	nopl   0x0(%rax)
   0x0000000000001098 <+40>:	xor    %eax,%eax
   0x000000000000109a <+42>:	callq  0x1040 <foo@plt>
   0x000000000000109f <+47>:	mov    $0xc,%eax
   0x00000000000010a4 <+52>:	add    $0x8,%rsp
   0x00000000000010a8 <+56>:	retq
   0x00000000000010a9 <+57>:	nopl   0x0(%rax)
   0x00000000000010b0 <+64>:	lea    0xf49(%rip),%rdi        # 0x2000
   0x00000000000010b7 <+71>:	xor    %eax,%eax
   0x00000000000010b9 <+73>:	callq  0x1030 <baz@plt>
   0x00000000000010be <+78>:	mov    $0xffffffe7,%eax
   0x00000000000010c3 <+83>:	add    $0x8,%rsp
   0x00000000000010c7 <+87>:	retq
   0x00000000000010c8 <+88>:	nopl   0x0(%rax,%rax,1)
   0x00000000000010d0 <+96>:	mov    $0xffffffe5,%eax
   0x00000000000010d5 <+101>:	add    $0x8,%rsp
   0x00000000000010d9 <+105>:	retq
   0x00000000000010da <+106>:	nopw   0x0(%rax,%rax,1)
   0x00000000000010e0 <+112>:	mov    $0x21,%eax
   0x00000000000010e5 <+117>:	add    $0x8,%rsp
   0x00000000000010e9 <+121>:	retq
   0x00000000000010ea <+122>:	nopw   0x0(%rax,%rax,1)
   0x00000000000010f0 <+128>:	mov    $0x23,%eax
   0x00000000000010f5 <+133>:	add    $0x8,%rsp
   0x00000000000010f9 <+137>:	retq
   0x00000000000010fa <+138>:	nopw   0x0(%rax,%rax,1)
   0x0000000000001100 <+144>:	mov    $0x63,%eax
   0x0000000000001105 <+149>:	add    $0x8,%rsp
   0x0000000000001109 <+153>:	retq
   0x000000000000110a <+154>:	nopw   0x0(%rax,%rax,1)
   0x0000000000001110 <+160>:	mov    $0xa,%eax
   0x0000000000001115 <+165>:	add    $0x8,%rsp
   0x0000000000001119 <+169>:	retq
   0x000000000000111a <+170>:	nopw   0x0(%rax,%rax,1)
   0x0000000000001120 <+176>:	retq
'''.split('\n')
        _, blocks = asm2cfg.parse_lines(lines, False)

        # TODO: special block for indirect jumps
        self.assertEqual(len(blocks), 4)

    # TODO:
    # - functions (with and w/o calls)
    # - skip calls
