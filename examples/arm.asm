00000000 <check_one_fd>:
   0:	e92d40f0 	push	{r4, r5, r6, r7, lr}
   4:	e1a05001 	mov	r5, r1
   8:	e24dd06c 	sub	sp, sp, #108	; 0x6c
   c:	e3a01001 	mov	r1, #1
  10:	e1a04000 	mov	r4, r0
  14:	ebfffffe 	bl	0 <__fcntl64_nocancel>
  18:	e3700001 	cmn	r0, #1
  1c:	0a000001 	beq	28 <check_one_fd+0x28>
  20:	e28dd06c 	add	sp, sp, #108	; 0x6c
  24:	e8bd80f0 	pop	{r4, r5, r6, r7, pc}
  28:	ebfffffe 	bl	0 <__aeabi_read_tp>
  2c:	e59f307c 	ldr	r3, [pc, #124]	; b0 <check_one_fd+0xb0>
  30:	e79f3003 	ldr	r3, [pc, r3]
  34:	e7903003 	ldr	r3, [r0, r3]
  38:	e3530009 	cmp	r3, #9
  3c:	1afffff7 	bne	20 <check_one_fd+0x20>
  40:	e3550902 	cmp	r5, #32768	; 0x8000
  44:	059f0068 	ldreq	r0, [pc, #104]	; b4 <check_one_fd+0xb4>
  48:	159f0068 	ldrne	r0, [pc, #104]	; b8 <check_one_fd+0xb8>
  4c:	e1a01005 	mov	r1, r5
  50:	e3a02000 	mov	r2, #0
  54:	03a07000 	moveq	r7, #0
  58:	13a07000 	movne	r7, #0
  5c:	059f6058 	ldreq	r6, [pc, #88]	; bc <check_one_fd+0xbc>
  60:	159f6058 	ldrne	r6, [pc, #88]	; c0 <check_one_fd+0xc0>
  64:	ebfffffe 	bl	0 <__open_nocancel>
  68:	e1540000 	cmp	r4, r0
  6c:	1a00000e 	bne	ac <check_one_fd+0xac>
  70:	e1a01004 	mov	r1, r4
  74:	e1a0200d 	mov	r2, sp
  78:	e3a00003 	mov	r0, #3
  7c:	ebfffffe 	bl	0 <__fxstat64>
  80:	e3500000 	cmp	r0, #0
  84:	1a000008 	bne	ac <check_one_fd+0xac>
  88:	e59d3010 	ldr	r3, [sp, #16]
  8c:	e2033a0f 	and	r3, r3, #61440	; 0xf000
  90:	e3530a02 	cmp	r3, #8192	; 0x2000
  94:	1a000004 	bne	ac <check_one_fd+0xac>
  98:	e28d3020 	add	r3, sp, #32
  9c:	e893000c 	ldm	r3, {r2, r3}
  a0:	e1530007 	cmp	r3, r7
  a4:	01520006 	cmpeq	r2, r6
  a8:	0affffdc 	beq	20 <check_one_fd+0x20>
  ac:	e7f000f0 	udf	#0
  b0:	00000078 	.word	0x00000078
  b4:	0000000c 	.word	0x0000000c
  b8:	00000000 	.word	0x00000000
  bc:	00000103 	.word	0x00000103
  c0:	00000107 	.word	0x00000107

