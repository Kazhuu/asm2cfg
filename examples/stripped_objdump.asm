0000000000001000 <.text>:
    1000:	f3 0f 1e fa          	endbr64 
    1004:	55                   	push   %rbp
    1005:	48 89 e5             	mov    %rsp,%rbp
    1008:	89 7d fc             	mov    %edi,-0x4(%rbp)
    100b:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    100f:	7e 08                	jle    0x1019
    1011:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1014:	83 c0 64             	add    $0x64,%eax
    1017:	eb 06                	jmp    0x101f
    1019:	8b 45 fc             	mov    -0x4(%rbp),%eax
    101c:	0f af c0             	imul   %eax,%eax
    101f:	5d                   	pop    %rbp
    1020:	c3                   	retq   
