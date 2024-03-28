0000000000016bb0 <_obstack_allocated_p@@Base>:
   16bb0:	f3 0f 1e fa          	endbr64
   16bb4:	48 8b 47 08          	mov    0x8(%rdi),%rax
   16bb8:	48 85 c0             	test   %rax,%rax
   16bbb:	74 29                	je     16be6 <_obstack_allocated_p@@Base+0x36>
   16bbd:	0f 1f 00             	nopl   (%rax)
   16bc0:	48 39 c6             	cmp    %rax,%rsi
   16bc3:	76 05                	jbe    16bca <_obstack_allocated_p@@Base+0x1a>
   16bc5:	48 39 30             	cmp    %rsi,(%rax)
   16bc8:	73 16                	jae    16be0 <_obstack_allocated_p@@Base+0x30>
   16bca:	48 8b 40 08          	mov    0x8(%rax),%rax
   16bce:	48 85 c0             	test   %rax,%rax
   16bd1:	75 ed                	jne    16bc0 <_obstack_allocated_p@@Base+0x10>
   16bd3:	31 c0                	xor    %eax,%eax
   16bd5:	c3                   	retq
   16bd6:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
   16bdd:	00 00 00
   16be0:	b8 01 00 00 00       	mov    $0x1,%eax
   16be5:	c3                   	retq
   16be6:	c3                   	retq
   16be7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
   16bee:	00 00
