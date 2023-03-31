Dump of assembler code for function main:
   0x000000000002ebd0 <+0>:	endbr64
   0x000000000002ebd4 <+4>:	push   %r15
   0x000000000002ebd6 <+6>:	push   %r14
   0x000000000002ebd8 <+8>:	push   %r13
   0x000000000002ebda <+10>:	push   %r12
   0x000000000002ebdc <+12>:	push   %rbp
   0x000000000002ebdd <+13>:	push   %rbx
   0x000000000002ebde <+14>:	sub    $0x138,%rsp
   0x000000000002ebe5 <+21>:	mov    %edi,0x4(%rsp)
   0x000000000002ebe9 <+25>:	lea    0xfc070(%rip),%rdi        # 0x12ac60 <top_level>
   0x000000000002ebf0 <+32>:	mov    %rsi,0x8(%rsp)
   0x000000000002ebf5 <+37>:	xor    %esi,%esi
   0x000000000002ebf7 <+39>:	mov    %rdx,0x18(%rsp)
   0x000000000002ebfc <+44>:	mov    %fs:0x28,%rax
   0x000000000002ec05 <+53>:	mov    %rax,0x128(%rsp)
   0x000000000002ec0d <+61>:	xor    %eax,%eax
   0x000000000002ec0f <+63>:	callq  0x2eab0 <__sigsetjmp@plt>
   0x000000000002ec14 <+68>:	endbr64
   0x000000000002ec18 <+72>:	test   %eax,%eax
   0x000000000002ec1a <+74>:	jne    0x2ec7c <main+172>
   0x000000000002ec1c <+76>:	callq  0x42360 <xtrace_init>
   0x000000000002ec21 <+81>:	callq  0x3efa0 <check_dev_tty>
   0x000000000002ec26 <+86>:	cmpl   $0x0,0xf2a93(%rip)        # 0x1216c0 <debugging_login_shell>
   0x000000000002ec2d <+93>:	je     0x2ec86 <main+182>
   0x000000000002ec2f <+95>:	mov    $0x3,%edi
   0x000000000002ec34 <+100>:	callq  0x2eac0 <sleep@plt>
   0x000000000002ec39 <+105>:	jmp    0x2ec26 <main+86>
   0x000000000002ec3b <+107>:	cmpl   $0x0,0x28(%rsp)
   0x000000000002ec40 <+112>:	mov    %r13d,%r15d
   0x000000000002ec43 <+115>:	mov    0x20(%rsp),%r13
   0x000000000002ec48 <+120>:	je     0x2f14e <main+1406>
   0x000000000002ec4e <+126>:	mov    $0x5,%edx
   0x000000000002ec53 <+131>:	lea    0xaf486(%rip),%rsi        # 0xde0e0
   0x000000000002ec5a <+138>:	xor    %edi,%edi
   0x000000000002ec5c <+140>:	callq  0x2e130 <dcgettext@plt>
   0x000000000002ec61 <+145>:	mov    %r13,%rsi
   0x000000000002ec64 <+148>:	mov    %rax,%rdi
   0x000000000002ec67 <+151>:	xor    %eax,%eax
   0x000000000002ec69 <+153>:	callq  0x54c40 <report_error>
   0x000000000002ec6e <+158>:	mov    0xf2a0b(%rip),%rdi        # 0x121680 <stderr>
   0x000000000002ec75 <+165>:	xor    %esi,%esi
   0x000000000002ec77 <+167>:	callq  0x30580
   0x000000000002ec7c <+172>:	mov    $0x2,%edi
   0x000000000002ec81 <+177>:	callq  0x2e9c0 <exit@plt>
   0x000000000002ec86 <+182>:	callq  0x89970 <set_default_locale>
   0x000000000002ec8b <+187>:	callq  0x2e1b0 <getuid@plt>
   0x000000000002ec90 <+192>:	cmp    0xea3aa(%rip),%eax        # 0x119040 <current_user>
   0x000000000002ec96 <+198>:	mov    %eax,%ebx
   0x000000000002ec98 <+200>:	je     0x2ecee <main+286>
   0x000000000002ec9a <+202>:	mov    0xea3af(%rip),%rdi        # 0x119050 <current_user+16>
   0x000000000002eca1 <+209>:	test   %rdi,%rdi
   0x000000000002eca4 <+212>:	je     0x2ecab <main+219>
   0x000000000002eca6 <+214>:	callq  0x2de50 <free@plt>
   0x000000000002ecab <+219>:	mov    0xea3a6(%rip),%rdi        # 0x119058 <current_user+24>
   0x000000000002ecb2 <+226>:	test   %rdi,%rdi
   0x000000000002ecb5 <+229>:	je     0x2ecbc <main+236>
   0x000000000002ecb7 <+231>:	callq  0x2de50 <free@plt>
   0x000000000002ecbc <+236>:	mov    0xea39d(%rip),%rdi        # 0x119060 <current_user+32>
   0x000000000002ecc3 <+243>:	test   %rdi,%rdi
   0x000000000002ecc6 <+246>:	je     0x2eccd <main+253>
   0x000000000002ecc8 <+248>:	callq  0x2de50 <free@plt>
   0x000000000002eccd <+253>:	movq   $0x0,0xea388(%rip)        # 0x119060 <current_user+32>
   0x000000000002ecd8 <+264>:	movq   $0x0,0xea375(%rip)        # 0x119058 <current_user+24>
   0x000000000002ece3 <+275>:	movq   $0x0,0xea362(%rip)        # 0x119050 <current_user+16>
   0x000000000002ecee <+286>:	mov    %ebx,0xea34c(%rip)        # 0x119040 <current_user>
   0x000000000002ecf4 <+292>:	callq  0x2e4f0 <getgid@plt>
   0x000000000002ecf9 <+297>:	mov    %eax,0xea349(%rip)        # 0x119048 <current_user+8>
   0x000000000002ecff <+303>:	callq  0x2e2c0 <geteuid@plt>
   0x000000000002ed04 <+308>:	mov    %eax,0xea33a(%rip)        # 0x119044 <current_user+4>
   0x000000000002ed0a <+314>:	callq  0x2e630 <getegid@plt>
   0x000000000002ed0f <+319>:	mov    0xea32f(%rip),%ecx        # 0x119044 <current_user+4>
   0x000000000002ed15 <+325>:	mov    $0x1,%edx
   0x000000000002ed1a <+330>:	cmp    %ecx,0xea320(%rip)        # 0x119040 <current_user>
   0x000000000002ed20 <+336>:	mov    %eax,0xea326(%rip)        # 0x11904c <current_user+12>
   0x000000000002ed26 <+342>:	jne    0x2ed33 <main+355>
   0x000000000002ed28 <+344>:	xor    %edx,%edx
   0x000000000002ed2a <+346>:	cmp    %eax,0xea318(%rip)        # 0x119048 <current_user+8>
   0x000000000002ed30 <+352>:	setne  %dl
   0x000000000002ed33 <+355>:	lea    0xaf371(%rip),%rdi        # 0xde0ab
   0x000000000002ed3a <+362>:	mov    %edx,0xf29f4(%rip)        # 0x121734
   0x000000000002ed40 <+368>:	callq  0xaf9e0 <getenv>
   0x000000000002ed45 <+373>:	test   %rax,%rax
   0x000000000002ed48 <+376>:	je     0x2faae <main+3806>
   0x000000000002ed4e <+382>:	movl   $0x1,0xf293c(%rip)        # 0x121694 <posixly_correct>
   0x000000000002ed58 <+392>:	mov    $0x1,%esi
   0x000000000002ed5d <+397>:	lea    0xf735c(%rip),%rdi        # 0x1260c0 <subshell_top_level>
   0x000000000002ed64 <+404>:	callq  0x2eab0 <__sigsetjmp@plt>
   0x000000000002ed69 <+409>:	endbr64
   0x000000000002ed6d <+413>:	test   %eax,%eax
   0x000000000002ed6f <+415>:	je     0x2ed9d <main+461>
   0x000000000002ed71 <+417>:	movl   $0x0,0xf29bd(%rip)        # 0x121738
   0x000000000002ed7b <+427>:	mov    0xf7457(%rip),%eax        # 0x1261d8 <subshell_argc>
   0x000000000002ed81 <+433>:	mov    %eax,0x4(%rsp)
   0x000000000002ed85 <+437>:	mov    0xf73fc(%rip),%rax        # 0x126188 <subshell_argv>
   0x000000000002ed8c <+444>:	mov    %rax,0x8(%rsp)
   0x000000000002ed91 <+449>:	mov    0xf7308(%rip),%rax        # 0x1260a0 <subshell_envp>
   0x000000000002ed98 <+456>:	mov    %rax,0x18(%rsp)
   0x000000000002ed9d <+461>:	movl   $0x1,0x38(%rsp)
   0x000000000002eda5 <+469>:	mov    0x4(%rsp),%ecx
   0x000000000002eda9 <+473>:	movl   $0x0,0xf2965(%rip)        # 0x121718
   0x000000000002edb3 <+483>:	mov    0x38(%rsp),%eax
   0x000000000002edb7 <+487>:	cmp    %ecx,%eax
   0x000000000002edb9 <+489>:	jle    0x2edbf <main+495>
   0x000000000002edbb <+491>:	mov    %ecx,0x38(%rsp)
   0x000000000002edbf <+495>:	mov    0xf286a(%rip),%rax        # 0x121630 <stdin>
   0x000000000002edc6 <+502>:	cmpl   $0x0,0xf292f(%rip)        # 0x1216fc <shell_initialized>
   0x000000000002edcd <+509>:	movq   $0x0,0xf73f8(%rip)        # 0x1261d0 <shell_script_filename>
   0x000000000002edd8 <+520>:	movq   $0x0,0xf73d5(%rip)        # 0x1261b8 <command_execution_string>
   0x000000000002ede3 <+531>:	mov    %rax,0xf2926(%rip)        # 0x121710
   0x000000000002edea <+538>:	mov    0xf28bf(%rip),%rax        # 0x1216b0 <shell_name>
   0x000000000002edf1 <+545>:	movl   $0x0,0xf73c5(%rip)        # 0x1261c0 <read_from_stdin>
   0x000000000002edfb <+555>:	movl   $0x0,0x34(%rsp)
   0x000000000002ee03 <+563>:	movl   $0x0,0xf7383(%rip)        # 0x126190 <want_pending_command>
   0x000000000002ee0d <+573>:	movl   $0xffffffff,0xea209(%rip)        # 0x119020 <default_buffered_input>
   0x000000000002ee17 <+583>:	movl   $0x0,0xf28ff(%rip)        # 0x121720
   0x000000000002ee21 <+593>:	movl   $0x0,0xf28b5(%rip)        # 0x1216e0 <login_shell>
   0x000000000002ee2b <+603>:	jne    0x2ee36 <main+614>
   0x000000000002ee2d <+605>:	test   %rax,%rax
   0x000000000002ee30 <+608>:	je     0x2ef67 <main+919>
   0x000000000002ee36 <+614>:	cmpb   $0x2d,(%rax)
   0x000000000002ee39 <+617>:	jne    0x2ee46 <main+630>
   0x000000000002ee3b <+619>:	add    $0x1,%rax
   0x000000000002ee3f <+623>:	mov    %rax,0xf286a(%rip)        # 0x1216b0 <shell_name>
   0x000000000002ee46 <+630>:	lea    0xaf27d(%rip),%rax        # 0xde0ca
   0x000000000002ee4d <+637>:	xor    %edi,%edi
   0x000000000002ee4f <+639>:	movl   $0x1,0xea1cf(%rip)        # 0x119028 <current_command_number>
   0x000000000002ee59 <+649>:	mov    %rax,0xea598(%rip)        # 0x1193f8 <primary_prompt>
   0x000000000002ee60 <+656>:	lea    0xaf26c(%rip),%rax        # 0xde0d3
   0x000000000002ee67 <+663>:	mov    %rax,0xea582(%rip)        # 0x1193f0 <secondary_prompt>
   0x000000000002ee6e <+670>:	movl   $0x1,0xf28b0(%rip)        # 0x121728
   0x000000000002ee78 <+680>:	movl   $0x1,0xf28aa(%rip)        # 0x12172c
   0x000000000002ee82 <+690>:	movl   $0x0,0xf2830(%rip)        # 0x1216bc <executing>
   0x000000000002ee8c <+700>:	movl   $0x0,0xf2846(%rip)        # 0x1216dc <interactive>
   0x000000000002ee96 <+710>:	movl   $0x0,0xf7588(%rip)        # 0x126428 <last_command_exit_value>
   0x000000000002eea0 <+720>:	movl   $0x0,0xf28ea(%rip)        # 0x121794 <line_number>
   0x000000000002eeaa <+730>:	movl   $0x0,0xf2870(%rip)        # 0x121724
   0x000000000002eeb4 <+740>:	movl   $0x0,0xf2872(%rip)        # 0x121730
   0x000000000002eebe <+750>:	movl   $0x0,0xf2810(%rip)        # 0x1216d8 <interactive_shell>
   0x000000000002eec8 <+760>:	movl   $0x0,0xf3ffa(%rip)        # 0x122ecc <forced_interactive>
   0x000000000002eed2 <+770>:	movl   $0x0,0xf4050(%rip)        # 0x122f2c <running_in_background>
   0x000000000002eedc <+780>:	movl   $0x0,0xf7532(%rip)        # 0x126418 <subshell_environment>
   0x000000000002eee6 <+790>:	movl   $0x0,0xf28c4(%rip)        # 0x1217b4 <expand_aliases>
   0x000000000002eef0 <+800>:	movl   $0x0,0xf27fe(%rip)        # 0x1216f8 <bash_argv_initialized>
   0x000000000002eefa <+810>:	movl   $0x0,0xf5600(%rip)        # 0x124504 <enable_history_list>
   0x000000000002ef04 <+820>:	callq  0x81240 <bash_history_reinit>
   0x000000000002ef09 <+825>:	mov    0xf3dd8(%rip),%rdi        # 0x122ce8 <shell_variables>
   0x000000000002ef10 <+832>:	lea    0xaf1bf(%rip),%rax        # 0xde0d6
   0x000000000002ef17 <+839>:	movl   $0x0,0xf3f9b(%rip)        # 0x122ebc <restricted>
   0x000000000002ef21 <+849>:	mov    %rax,0xea140(%rip)        # 0x119068
   0x000000000002ef28 <+856>:	callq  0x51d60 <delete_all_contexts>
   0x000000000002ef2d <+861>:	mov    0xf3dac(%rip),%rdi        # 0x122ce0 <shell_functions>
   0x000000000002ef34 <+868>:	callq  0x4f710 <delete_all_variables>
   0x000000000002ef39 <+873>:	callq  0x53f20 <reinit_special_variables>
   0x000000000002ef3e <+878>:	callq  0x87b50 <bashline_reinitialize>
   0x000000000002ef43 <+883>:	xor    %esi,%esi
   0x000000000002ef45 <+885>:	lea    0xfbd14(%rip),%rdi        # 0x12ac60 <top_level>
   0x000000000002ef4c <+892>:	movl   $0x1,0xf27c2(%rip)        # 0x121718
   0x000000000002ef56 <+902>:	callq  0x2eab0 <__sigsetjmp@plt>
   0x000000000002ef5b <+907>:	endbr64
   0x000000000002ef5f <+911>:	test   %eax,%eax
   0x000000000002ef61 <+913>:	jne    0x2ec7c <main+172>
   0x000000000002ef67 <+919>:	mov    0x18(%rsp),%rax
   0x000000000002ef6c <+924>:	mov    %rax,0xf7255(%rip)        # 0x1261c8 <shell_environment>
   0x000000000002ef73 <+931>:	mov    0x8(%rsp),%rax
   0x000000000002ef78 <+936>:	mov    (%rax),%rbx
   0x000000000002ef7b <+939>:	test   %rbx,%rbx
   0x000000000002ef7e <+942>:	je     0x2f1cd <main+1533>
   0x000000000002ef84 <+948>:	mov    %rbx,%rdi
   0x000000000002ef87 <+951>:	callq  0x3f4b0 <base_pathname>
   0x000000000002ef8c <+956>:	mov    %rax,0xf271d(%rip)        # 0x1216b0 <shell_name>
   0x000000000002ef93 <+963>:	cmpb   $0x2d,(%rbx)
   0x000000000002ef96 <+966>:	je     0x2f713 <main+2883>
   0x000000000002ef9c <+972>:	mov    0xf270d(%rip),%rax        # 0x1216b0 <shell_name>
   0x000000000002efa3 <+979>:	cmpb   $0x73,(%rax)
   0x000000000002efa6 <+982>:	jne    0x2efc7 <main+1015>
   0x000000000002efa8 <+984>:	movzbl 0x1(%rax),%edx
   0x000000000002efac <+988>:	cmp    $0x68,%dl
   0x000000000002efaf <+991>:	je     0x2f732 <main+2914>
   0x000000000002efb5 <+997>:	cmp    $0x75,%dl
   0x000000000002efb8 <+1000>:	jne    0x2efc7 <main+1015>
   0x000000000002efba <+1002>:	cmpb   $0x0,0x2(%rax)
   0x000000000002efbe <+1006>:	jne    0x2efc7 <main+1015>
   0x000000000002efc0 <+1008>:	addl   $0x1,0xf2775(%rip)        # 0x12173c
   0x000000000002efc7 <+1015>:	mov    0xf7492(%rip),%rdi        # 0x126460 <dollar_vars>
   0x000000000002efce <+1022>:	mov    %rbx,0xf26db(%rip)        # 0x1216b0 <shell_name>
   0x000000000002efd5 <+1029>:	test   %rdi,%rdi
   0x000000000002efd8 <+1032>:	je     0x2efdf <main+1039>
   0x000000000002efda <+1034>:	callq  0x2de50 <free@plt>
   0x000000000002efdf <+1039>:	mov    0xf26ca(%rip),%rbp        # 0x1216b0 <shell_name>
   0x000000000002efe6 <+1046>:	xor    %eax,%eax
   0x000000000002efe8 <+1048>:	or     $0xffffffffffffffff,%rcx
   0x000000000002efec <+1052>:	mov    %rbp,%rdi
   0x000000000002efef <+1055>:	repnz scas %es:(%rdi),%al
   0x000000000002eff1 <+1057>:	not    %rcx
   0x000000000002eff4 <+1060>:	mov    %rcx,%rdi
   0x000000000002eff7 <+1063>:	callq  0x90510 <xmalloc>
   0x000000000002effc <+1068>:	mov    %rbp,%rsi
   0x000000000002efff <+1071>:	mov    %rax,%rdi
   0x000000000002f002 <+1074>:	callq  0x2df30 <strcpy@plt>
   0x000000000002f007 <+1079>:	mov    %rax,0xf7452(%rip)        # 0x126460 <dollar_vars>
   0x000000000002f00e <+1086>:	mov    0xf269b(%rip),%rax        # 0x1216b0 <shell_name>
   0x000000000002f015 <+1093>:	test   %rax,%rax
   0x000000000002f018 <+1096>:	je     0x2f1ba <main+1514>
   0x000000000002f01e <+1102>:	movzbl (%rax),%edx
   0x000000000002f021 <+1105>:	test   %dl,%dl
   0x000000000002f023 <+1107>:	je     0x2f1ba <main+1514>
   0x000000000002f029 <+1113>:	cmp    $0x2d,%dl
   0x000000000002f02c <+1116>:	je     0x2f1b0 <main+1504>
   0x000000000002f032 <+1122>:	xor    %edi,%edi
   0x000000000002f034 <+1124>:	callq  0x2e4d0 <time@plt>
   0x000000000002f039 <+1129>:	mov    0x38(%rsp),%r15d
   0x000000000002f03e <+1134>:	mov    %rax,0xf7163(%rip)        # 0x1261a8 <shell_start_time>
   0x000000000002f045 <+1141>:	cmp    %r15d,0x4(%rsp)
   0x000000000002f04a <+1146>:	je     0x2f14e <main+1406>
   0x000000000002f050 <+1152>:	mov    %r15d,%r12d
   0x000000000002f053 <+1155>:	nopl   0x0(%rax,%rax,1)
   0x000000000002f058 <+1160>:	movslq %r12d,%rax
   0x000000000002f05b <+1163>:	lea    0x0(,%rax,8),%rcx
   0x000000000002f063 <+1171>:	mov    %rcx,0x10(%rsp)
   0x000000000002f068 <+1176>:	mov    0x8(%rsp),%rcx
   0x000000000002f06d <+1181>:	mov    (%rcx,%rax,8),%r13
   0x000000000002f071 <+1185>:	test   %r13,%r13
   0x000000000002f074 <+1188>:	je     0x2f14b <main+1403>
   0x000000000002f07a <+1194>:	cmpb   $0x2d,0x0(%r13)
   0x000000000002f07f <+1199>:	jne    0x2f14b <main+1403>
   0x000000000002f085 <+1205>:	movzbl 0x1(%r13),%r9d
   0x000000000002f08a <+1210>:	movl   $0x0,0x28(%rsp)
   0x000000000002f092 <+1218>:	mov    %r13,%rax
   0x000000000002f095 <+1221>:	cmp    $0x2d,%r9b
   0x000000000002f099 <+1225>:	je     0x2f17a <main+1450>
   0x000000000002f09f <+1231>:	lea    0x1(%rax),%r15
   0x000000000002f0a3 <+1235>:	mov    %r13,0x20(%rsp)
   0x000000000002f0a8 <+1240>:	mov    $0x64,%esi
   0x000000000002f0ad <+1245>:	xor    %ebx,%ebx
   0x000000000002f0af <+1247>:	mov    %r12d,%r13d
   0x000000000002f0b2 <+1250>:	lea    0xe7d87(%rip),%r14        # 0x116e40
   0x000000000002f0b9 <+1257>:	mov    %r15,%r12
   0x000000000002f0bc <+1260>:	mov    %r9d,%r15d
   0x000000000002f0bf <+1263>:	lea    0xc5730(%rip),%rbp        # 0xf47f6
   0x000000000002f0c6 <+1270>:	jmp    0x2f0e7 <main+1303>
   0x000000000002f0c8 <+1272>:	nopl   0x0(%rax,%rax,1)
   0x000000000002f0d0 <+1280>:	mov    (%r14),%rbp
   0x000000000002f0d3 <+1283>:	add    $0x20,%r14
   0x000000000002f0d7 <+1287>:	add    $0x1,%ebx
   0x000000000002f0da <+1290>:	test   %rbp,%rbp
   0x000000000002f0dd <+1293>:	je     0x2ec3b <main+107>
   0x000000000002f0e3 <+1299>:	movzbl 0x0(%rbp),%esi
   0x000000000002f0e7 <+1303>:	cmp    %r15b,%sil
   0x000000000002f0ea <+1306>:	jne    0x2f0d0 <main+1280>
   0x000000000002f0ec <+1308>:	mov    %rbp,%rsi
   0x000000000002f0ef <+1311>:	mov    %r12,%rdi
   0x000000000002f0f2 <+1314>:	callq  0x2e3d0 <strcmp@plt>
   0x000000000002f0f7 <+1319>:	test   %eax,%eax
   0x000000000002f0f9 <+1321>:	jne    0x2f0d0 <main+1280>
   0x000000000002f0fb <+1323>:	movslq %ebx,%rbx
   0x000000000002f0fe <+1326>:	lea    0xe7d1b(%rip),%rax        # 0x116e20
   0x000000000002f105 <+1333>:	mov    %r13d,%r12d
   0x000000000002f108 <+1336>:	shl    $0x5,%rbx
   0x000000000002f10c <+1340>:	add    %rax,%rbx
   0x000000000002f10f <+1343>:	cmpl   $0x1,0x8(%rbx)
   0x000000000002f113 <+1347>:	je     0x2f1a4 <main+1492>
   0x000000000002f119 <+1353>:	mov    0x8(%rsp),%rax
   0x000000000002f11e <+1358>:	mov    0x10(%rsp),%rcx
   0x000000000002f123 <+1363>:	add    $0x1,%r12d
   0x000000000002f127 <+1367>:	mov    0x8(%rax,%rcx,1),%rax
   0x000000000002f12c <+1372>:	test   %rax,%rax
   0x000000000002f12f <+1375>:	je     0x30116 <main+5446>
   0x000000000002f135 <+1381>:	mov    0x18(%rbx),%rdx
   0x000000000002f139 <+1385>:	mov    %rax,(%rdx)
   0x000000000002f13c <+1388>:	add    $0x1,%r12d
   0x000000000002f140 <+1392>:	cmp    %r12d,0x4(%rsp)
   0x000000000002f145 <+1397>:	jne    0x2f058 <main+1160>
   0x000000000002f14b <+1403>:	mov    %r12d,%r15d
   0x000000000002f14e <+1406>:	cmpl   $0x0,0xf25c7(%rip)        # 0x12171c
   0x000000000002f155 <+1413>:	mov    %r15d,0x38(%rsp)
   0x000000000002f15a <+1418>:	jne    0x2f6df <main+2831>
   0x000000000002f160 <+1424>:	cmpl   $0x0,0xf25bd(%rip)        # 0x121724
   0x000000000002f167 <+1431>:	je     0x2f1d9 <main+1545>
   0x000000000002f169 <+1433>:	mov    $0x1,%edi
   0x000000000002f16e <+1438>:	callq  0x7a5f0 <show_shell_version>
   0x000000000002f173 <+1443>:	xor    %edi,%edi
   0x000000000002f175 <+1445>:	callq  0x2e9c0 <exit@plt>
   0x000000000002f17a <+1450>:	movzbl 0x2(%r13),%edx
   0x000000000002f17f <+1455>:	test   %dl,%dl
   0x000000000002f181 <+1457>:	je     0x2f197 <main+1479>
   0x000000000002f183 <+1459>:	movl   $0x1,0x28(%rsp)
   0x000000000002f18b <+1467>:	lea    0x1(%r13),%rax
   0x000000000002f18f <+1471>:	mov    %edx,%r9d
   0x000000000002f192 <+1474>:	jmpq   0x2f09f <main+1231>
   0x000000000002f197 <+1479>:	movl   $0x0,0x28(%rsp)
   0x000000000002f19f <+1487>:	jmpq   0x2f09f <main+1231>
   0x000000000002f1a4 <+1492>:	mov    0x10(%rbx),%rax
   0x000000000002f1a8 <+1496>:	movl   $0x1,(%rax)
   0x000000000002f1ae <+1502>:	jmp    0x2f13c <main+1388>
   0x000000000002f1b0 <+1504>:	cmpb   $0x0,0x1(%rax)
   0x000000000002f1b4 <+1508>:	jne    0x2f032 <main+1122>
   0x000000000002f1ba <+1514>:	lea    0xaeec3(%rip),%rax        # 0xde084
   0x000000000002f1c1 <+1521>:	mov    %rax,0xf24e8(%rip)        # 0x1216b0 <shell_name>
   0x000000000002f1c8 <+1528>:	jmpq   0x2f032 <main+1122>
   0x000000000002f1cd <+1533>:	lea    0xaeeb0(%rip),%rbx        # 0xde084
   0x000000000002f1d4 <+1540>:	jmpq   0x2efc7 <main+1015>
   0x000000000002f1d9 <+1545>:	mov    0x38(%rsp),%ebx
   0x000000000002f1dd <+1549>:	mov    0xf3cf5(%rip),%eax        # 0x122ed8 <verbose_flag>
   0x000000000002f1e3 <+1555>:	lea    0xaf332(%rip),%r13        # 0xde51c
   0x000000000002f1ea <+1562>:	mov    0x8(%rsp),%r15
   0x000000000002f1ef <+1567>:	mov    %eax,0xf3ce7(%rip)        # 0x122edc <echo_input_at_read>
   0x000000000002f1f5 <+1573>:	mov    0xf24b4(%rip),%rax        # 0x1216b0 <shell_name>
   0x000000000002f1fc <+1580>:	mov    %rax,0xf721d(%rip)        # 0x126420 <this_command_name>
   0x000000000002f203 <+1587>:	cmp    %ebx,0x4(%rsp)
   0x000000000002f207 <+1591>:	je     0x2f3c5 <main+2037>
   0x000000000002f20d <+1597>:	movslq %ebx,%rax
   0x000000000002f210 <+1600>:	mov    (%r15,%rax,8),%r12
   0x000000000002f214 <+1604>:	test   %r12,%r12
   0x000000000002f217 <+1607>:	je     0x2f3c5 <main+2037>
   0x000000000002f21d <+1613>:	movsbl (%r12),%ebp
   0x000000000002f222 <+1618>:	lea    -0x2b(%rbp),%eax
   0x000000000002f225 <+1621>:	test   $0xfd,%al
   0x000000000002f227 <+1623>:	jne    0x2f3c5 <main+2037>
   0x000000000002f22d <+1629>:	movzbl 0x1(%r12),%eax
   0x000000000002f233 <+1635>:	add    $0x1,%ebx
   0x000000000002f236 <+1638>:	cmp    $0x2d,%bpl
   0x000000000002f23a <+1642>:	je     0x2f3a1 <main+2001>
   0x000000000002f240 <+1648>:	movsbl %al,%r14d
   0x000000000002f244 <+1652>:	test   %r14d,%r14d
   0x000000000002f247 <+1655>:	je     0x2f203 <main+1587>
   0x000000000002f249 <+1657>:	add    $0x2,%r12
   0x000000000002f24d <+1661>:	nopl   (%rax)
   0x000000000002f250 <+1664>:	sub    $0x44,%eax
   0x000000000002f253 <+1667>:	cmp    $0x2f,%al
   0x000000000002f255 <+1669>:	ja     0x2f268 <main+1688>
   0x000000000002f257 <+1671>:	movzbl %al,%eax
   0x000000000002f25a <+1674>:	movslq 0x0(%r13,%rax,4),%rax
   0x000000000002f25f <+1679>:	add    %r13,%rax
   0x000000000002f262 <+1682>:	notrack jmpq *%rax
   0x000000000002f265 <+1685>:	nopl   (%rax)
   0x000000000002f268 <+1688>:	mov    %ebp,%esi
   0x000000000002f26a <+1690>:	mov    %r14d,%edi
   0x000000000002f26d <+1693>:	callq  0x578c0 <change_flag>
   0x000000000002f272 <+1698>:	cmp    $0xffffffff,%eax
   0x000000000002f275 <+1701>:	je     0x2fac8 <main+3832>
   0x000000000002f27b <+1707>:	nopl   0x0(%rax,%rax,1)
   0x000000000002f280 <+1712>:	movsbl (%r12),%r14d
   0x000000000002f285 <+1717>:	add    $0x1,%r12
   0x000000000002f289 <+1721>:	mov    %r14d,%eax
   0x000000000002f28c <+1724>:	test   %r14d,%r14d
   0x000000000002f28f <+1727>:	jne    0x2f250 <main+1664>
   0x000000000002f291 <+1729>:	jmpq   0x2f203 <main+1587>
   0x000000000002f296 <+1734>:	nopw   %cs:0x0(%rax,%rax,1)
   0x000000000002f2a0 <+1744>:	movl   $0x1,0xf6f16(%rip)        # 0x1261c0 <read_from_stdin>
   0x000000000002f2aa <+1754>:	jmp    0x2f280 <main+1712>
   0x000000000002f2ac <+1756>:	nopl   0x0(%rax)
   0x000000000002f2b0 <+1760>:	movl   $0x1,0xf2466(%rip)        # 0x121720
   0x000000000002f2ba <+1770>:	jmp    0x2f280 <main+1712>
   0x000000000002f2bc <+1772>:	nopl   0x0(%rax)
   0x000000000002f2c0 <+1776>:	movl   $0x1,0xf6ec6(%rip)        # 0x126190 <want_pending_command>
   0x000000000002f2ca <+1786>:	jmp    0x2f280 <main+1712>
   0x000000000002f2cc <+1788>:	nopl   0x0(%rax)
   0x000000000002f2d0 <+1792>:	movslq %ebx,%rax
   0x000000000002f2d3 <+1795>:	mov    (%r15,%rax,8),%r14
   0x000000000002f2d7 <+1799>:	test   %r14,%r14
   0x000000000002f2da <+1802>:	je     0x2f34c <main+1916>
   0x000000000002f2dc <+1804>:	mov    0xf2422(%rip),%edx        # 0x121704
   0x000000000002f2e2 <+1810>:	mov    0xf2418(%rip),%esi        # 0x121700
   0x000000000002f2e8 <+1816>:	mov    0xf2419(%rip),%rdi        # 0x121708
   0x000000000002f2ef <+1823>:	cmp    %esi,%edx
   0x000000000002f2f1 <+1825>:	jge    0x2f377 <main+1959>
   0x000000000002f2f7 <+1831>:	movslq %edx,%rax
   0x000000000002f2fa <+1834>:	add    $0x1,%edx
   0x000000000002f2fd <+1837>:	shl    $0x4,%rax
   0x000000000002f301 <+1841>:	mov    %edx,0xf23fd(%rip)        # 0x121704
   0x000000000002f307 <+1847>:	add    %rax,%rdi
   0x000000000002f30a <+1850>:	mov    %r14,(%rdi)
   0x000000000002f30d <+1853>:	mov    %ebp,0x8(%rdi)
   0x000000000002f310 <+1856>:	add    $0x1,%ebx
   0x000000000002f313 <+1859>:	jmpq   0x2f280 <main+1712>
   0x000000000002f318 <+1864>:	nopl   0x0(%rax,%rax,1)
   0x000000000002f320 <+1872>:	movl   $0x1,0xf6e86(%rip)        # 0x1261b0 <dump_translatable_strings>
   0x000000000002f32a <+1882>:	jmpq   0x2f280 <main+1712>
   0x000000000002f32f <+1887>:	nop
   0x000000000002f330 <+1888>:	movslq %ebx,%rax
   0x000000000002f333 <+1891>:	mov    (%r15,%rax,8),%rsi
   0x000000000002f337 <+1895>:	test   %rsi,%rsi
   0x000000000002f33a <+1898>:	je     0x2f361 <main+1937>
   0x000000000002f33c <+1900>:	mov    %ebp,%edi
   0x000000000002f33e <+1902>:	callq  0x9f460 <set_minus_o_option>
   0x000000000002f343 <+1907>:	test   %eax,%eax
   0x000000000002f345 <+1909>:	je     0x2f310 <main+1856>
   0x000000000002f347 <+1911>:	jmpq   0x2ec7c <main+172>
   0x000000000002f34c <+1916>:	xor    %esi,%esi
   0x000000000002f34e <+1918>:	cmp    $0x2d,%ebp
   0x000000000002f351 <+1921>:	setne  %sil
   0x000000000002f355 <+1925>:	xor    %edi,%edi
   0x000000000002f357 <+1927>:	callq  0xa42b0 <shopt_listopt>
   0x000000000002f35c <+1932>:	jmpq   0x2f280 <main+1712>
   0x000000000002f361 <+1937>:	xor    %esi,%esi
   0x000000000002f363 <+1939>:	cmp    $0x2d,%ebp
   0x000000000002f366 <+1942>:	setne  %sil
   0x000000000002f36a <+1946>:	or     $0xffffffff,%edi
   0x000000000002f36d <+1949>:	callq  0x9f160 <list_minus_o_opts>
   0x000000000002f372 <+1954>:	jmpq   0x2f280 <main+1712>
   0x000000000002f377 <+1959>:	add    $0x8,%esi
   0x000000000002f37a <+1962>:	mov    %esi,0xf2380(%rip)        # 0x121700
   0x000000000002f380 <+1968>:	movslq %esi,%rsi
   0x000000000002f383 <+1971>:	shl    $0x4,%rsi
   0x000000000002f387 <+1975>:	callq  0x90570 <xrealloc>
   0x000000000002f38c <+1980>:	mov    0xf2372(%rip),%edx        # 0x121704
   0x000000000002f392 <+1986>:	mov    %rax,0xf236f(%rip)        # 0x121708
   0x000000000002f399 <+1993>:	mov    %rax,%rdi
   0x000000000002f39c <+1996>:	jmpq   0x2f2f7 <main+1831>
   0x000000000002f3a1 <+2001>:	test   %al,%al
   0x000000000002f3a3 <+2003>:	je     0x2f3c5 <main+2037>
   0x000000000002f3a5 <+2005>:	cmp    $0x2d,%al
   0x000000000002f3a7 <+2007>:	jne    0x2f240 <main+1648>
   0x000000000002f3ad <+2013>:	cmpb   $0x0,0x2(%r12)
   0x000000000002f3b3 <+2019>:	je     0x2f3c5 <main+2037>
   0x000000000002f3b5 <+2021>:	mov    $0x2d,%r14d
   0x000000000002f3bb <+2027>:	mov    $0x2d,%ebp
   0x000000000002f3c0 <+2032>:	jmpq   0x2f249 <main+1657>
   0x000000000002f3c5 <+2037>:	cmpl   $0x0,0xf2354(%rip)        # 0x121720
   0x000000000002f3cc <+2044>:	mov    %ebx,0x38(%rsp)
   0x000000000002f3d0 <+2048>:	je     0x2f3d8 <main+2056>
   0x000000000002f3d2 <+2050>:	notl   0xf2308(%rip)        # 0x1216e0 <login_shell>
   0x000000000002f3d8 <+2056>:	xor    %esi,%esi
   0x000000000002f3da <+2058>:	cmpl   $0x0,0xf22ff(%rip)        # 0x1216e0 <login_shell>
   0x000000000002f3e1 <+2065>:	lea    0xaed20(%rip),%rdi        # 0xde108
   0x000000000002f3e8 <+2072>:	setne  %sil
   0x000000000002f3ec <+2076>:	callq  0xa3b80 <set_login_shell>
   0x000000000002f3f1 <+2081>:	cmpl   $0x0,0xf6da8(%rip)        # 0x1261a0 <dump_po_strings>
   0x000000000002f3f8 <+2088>:	je     0x2f748 <main+2936>
   0x000000000002f3fe <+2094>:	movl   $0x1,0xf6da8(%rip)        # 0x1261b0 <dump_translatable_strings>
   0x000000000002f408 <+2104>:	movl   $0x1,0xf3ada(%rip)        # 0x122eec <read_but_dont_execute>
   0x000000000002f412 <+2114>:	cmpl   $0x0,0xf231b(%rip)        # 0x121734
   0x000000000002f419 <+2121>:	je     0x2f428 <main+2136>
   0x000000000002f41b <+2123>:	cmpl   $0x0,0xf3a92(%rip)        # 0x122eb4 <privileged_mode>
   0x000000000002f422 <+2130>:	je     0x2f88e <main+3262>
   0x000000000002f428 <+2136>:	cmpl   $0x0,0xf6d61(%rip)        # 0x126190 <want_pending_command>
   0x000000000002f42f <+2143>:	je     0x2f45a <main+2186>
   0x000000000002f431 <+2145>:	movslq 0x38(%rsp),%rax
   0x000000000002f436 <+2150>:	mov    0x8(%rsp),%rcx
   0x000000000002f43b <+2155>:	mov    (%rcx,%rax,8),%rax
   0x000000000002f43f <+2159>:	mov    %rax,0xf6d72(%rip)        # 0x1261b8 <command_execution_string>
   0x000000000002f446 <+2166>:	test   %rax,%rax
   0x000000000002f449 <+2169>:	je     0x2f941 <main+3441>
   0x000000000002f44f <+2175>:	mov    0x38(%rsp),%eax
   0x000000000002f453 <+2179>:	add    $0x1,%eax
   0x000000000002f456 <+2182>:	mov    %eax,0x38(%rsp)
   0x000000000002f45a <+2186>:	cmpl   $0x0,0xf3a6b(%rip)        # 0x122ecc <forced_interactive>
   0x000000000002f461 <+2193>:	movq   $0x0,0xf6fb4(%rip)        # 0x126420 <this_command_name>
   0x000000000002f46c <+2204>:	je     0x2f75a <main+2954>
   0x000000000002f472 <+2210>:	mov    0xea28c(%rip),%eax        # 0x119704 <history_expansion>
   0x000000000002f478 <+2216>:	cmpl   $0x0,0xf2261(%rip)        # 0x1216e0 <login_shell>
   0x000000000002f47f <+2223>:	movl   $0x1,0xf223f(%rip)        # 0x1216c8 <startup_state>
   0x000000000002f489 <+2233>:	movl   $0x1,0xf2245(%rip)        # 0x1216d8 <interactive_shell>
   0x000000000002f493 <+2243>:	movl   $0x1,0xf2317(%rip)        # 0x1217b4 <expand_aliases>
   0x000000000002f49d <+2253>:	movl   $0x1,0xf2235(%rip)        # 0x1216dc <interactive>
   0x000000000002f4a7 <+2263>:	movl   $0x1,0xf5053(%rip)        # 0x124504 <enable_history_list>
   0x000000000002f4b1 <+2273>:	movl   $0x1,0xf504d(%rip)        # 0x124508 <remember_on_history>
   0x000000000002f4bb <+2283>:	mov    %eax,0xf39ff(%rip)        # 0x122ec0 <histexp_flag>
   0x000000000002f4c1 <+2289>:	jne    0x2f787 <main+2999>
   0x000000000002f4c7 <+2295>:	cmpl   $0x0,0xf21c6(%rip)        # 0x121694 <posixly_correct>
   0x000000000002f4ce <+2302>:	jne    0x2f868 <main+3224>
   0x000000000002f4d4 <+2308>:	xor    %ebx,%ebx
   0x000000000002f4d6 <+2310>:	cmpq   $0x0,0xf222a(%rip)        # 0x121708
   0x000000000002f4de <+2318>:	jne    0x2f50a <main+2362>
   0x000000000002f4e0 <+2320>:	jmp    0x2f540 <main+2416>
   0x000000000002f4e2 <+2322>:	mov    %rbx,%rdx
   0x000000000002f4e5 <+2325>:	xor    %esi,%esi
   0x000000000002f4e7 <+2327>:	shl    $0x4,%rdx
   0x000000000002f4eb <+2331>:	add    %rdx,%rax
   0x000000000002f4ee <+2334>:	cmpl   $0x2d,0x8(%rax)
   0x000000000002f4f2 <+2338>:	mov    (%rax),%rdi
   0x000000000002f4f5 <+2341>:	sete   %sil
   0x000000000002f4f9 <+2345>:	add    $0x1,%rbx
   0x000000000002f4fd <+2349>:	callq  0xa4930 <shopt_setopt>
   0x000000000002f502 <+2354>:	test   %eax,%eax
   0x000000000002f504 <+2356>:	jne    0x2ec7c <main+172>
   0x000000000002f50a <+2362>:	cmp    %ebx,0xf21f4(%rip)        # 0x121704
   0x000000000002f510 <+2368>:	mov    0xf21f1(%rip),%rax        # 0x121708
   0x000000000002f517 <+2375>:	jg     0x2f4e2 <main+2322>
   0x000000000002f519 <+2377>:	mov    %rax,%rdi
   0x000000000002f51c <+2380>:	callq  0x2de50 <free@plt>
   0x000000000002f521 <+2385>:	movq   $0x0,0xf21dc(%rip)        # 0x121708
   0x000000000002f52c <+2396>:	movl   $0x0,0xf21ca(%rip)        # 0x121700
   0x000000000002f536 <+2406>:	movl   $0x0,0xf21c4(%rip)        # 0x121704
   0x000000000002f540 <+2416>:	callq  0x30d40
   0x000000000002f545 <+2421>:	callq  0x8a310 <set_default_lang>
   0x000000000002f54a <+2426>:	callq  0x899f0 <set_default_locale_vars>
   0x000000000002f54f <+2431>:	cmpl   $0x0,0xf2182(%rip)        # 0x1216d8 <interactive_shell>
   0x000000000002f556 <+2438>:	jne    0x2ffdb <main+5131>
   0x000000000002f55c <+2444>:	mov    0x38(%rsp),%eax
   0x000000000002f560 <+2448>:	mov    $0x1,%esi
   0x000000000002f565 <+2453>:	lea    0xfb6f4(%rip),%rdi        # 0x12ac60 <top_level>
   0x000000000002f56c <+2460>:	mov    %eax,0x3c(%rsp)
   0x000000000002f570 <+2464>:	mov    0xf3982(%rip),%eax        # 0x122ef8 <exit_immediately_on_error>
   0x000000000002f576 <+2470>:	mov    %eax,0x2c(%rsp)
   0x000000000002f57a <+2474>:	callq  0x2eab0 <__sigsetjmp@plt>
   0x000000000002f57f <+2479>:	endbr64
   0x000000000002f583 <+2483>:	test   %eax,%eax
   0x000000000002f585 <+2485>:	je     0x2f5b3 <main+2531>
   0x000000000002f587 <+2487>:	sub    $0x3,%eax
   0x000000000002f58a <+2490>:	cmp    $0x1,%eax
   0x000000000002f58d <+2493>:	jbe    0x2f6d4 <main+2820>
   0x000000000002f593 <+2499>:	mov    0xf213f(%rip),%edi        # 0x1216d8 <interactive_shell>
   0x000000000002f599 <+2505>:	callq  0x5eec0 <set_job_control>
   0x000000000002f59e <+2510>:	mov    0x2c(%rsp),%eax
   0x000000000002f5a2 <+2514>:	add    %eax,0xf3950(%rip)        # 0x122ef8 <exit_immediately_on_error>
   0x000000000002f5a8 <+2520>:	mov    0x34(%rsp),%eax
   0x000000000002f5ac <+2524>:	add    $0x1,%eax
   0x000000000002f5af <+2527>:	mov    %eax,0x34(%rsp)
   0x000000000002f5b3 <+2531>:	mov    0x3c(%rsp),%eax
   0x000000000002f5b7 <+2535>:	cmpl   $0x0,0xf211a(%rip)        # 0x1216d8 <interactive_shell>
   0x000000000002f5be <+2542>:	mov    %eax,0x38(%rsp)
   0x000000000002f5c2 <+2546>:	jne    0x2f6f5 <main+2853>
   0x000000000002f5c8 <+2552>:	lea    0xaeb72(%rip),%rdi        # 0xde141
   0x000000000002f5cf <+2559>:	callq  0x529a0 <unbind_variable>
   0x000000000002f5d4 <+2564>:	lea    0xaeb6a(%rip),%rdi        # 0xde145
   0x000000000002f5db <+2571>:	callq  0x529a0 <unbind_variable>
   0x000000000002f5e0 <+2576>:	movl   $0x0,0xf20f2(%rip)        # 0x1216dc <interactive>
   0x000000000002f5ea <+2586>:	cmpl   $0x0,0xf38cb(%rip)        # 0x122ebc <restricted>
   0x000000000002f5f1 <+2593>:	mov    0xf20b8(%rip),%rdi        # 0x1216b0 <shell_name>
   0x000000000002f5f8 <+2600>:	mov    $0x1,%eax
   0x000000000002f5fd <+2605>:	jne    0x2f604 <main+2612>
   0x000000000002f5ff <+2607>:	callq  0x30b90
   0x000000000002f604 <+2612>:	cmpl   $0x0,0xf2095(%rip)        # 0x1216a0 <wordexp_only>
   0x000000000002f60b <+2619>:	mov    0xf38ab(%rip),%ebx        # 0x122ebc <restricted>
   0x000000000002f611 <+2625>:	mov    %eax,0xf38a1(%rip)        # 0x122eb8 <restricted_shell>
   0x000000000002f617 <+2631>:	movl   $0x0,0xf389b(%rip)        # 0x122ebc <restricted>
   0x000000000002f621 <+2641>:	jne    0x2f649 <main+2681>
   0x000000000002f623 <+2643>:	cmpq   $0x0,0xf6b8d(%rip)        # 0x1261b8 <command_execution_string>
   0x000000000002f62b <+2651>:	je     0x2f7d2 <main+3074>
   0x000000000002f631 <+2657>:	mov    0x38(%rsp),%esi
   0x000000000002f635 <+2661>:	mov    0x4(%rsp),%edx
   0x000000000002f639 <+2665>:	xor    %ecx,%ecx
   0x000000000002f63b <+2667>:	mov    0x8(%rsp),%rdi
   0x000000000002f640 <+2672>:	callq  0x30870
   0x000000000002f645 <+2677>:	mov    %eax,0x38(%rsp)
   0x000000000002f649 <+2681>:	mov    0x34(%rsp),%eax
   0x000000000002f64d <+2685>:	or     0xf20e1(%rip),%eax        # 0x121734
   0x000000000002f653 <+2691>:	je     0x2f898 <main+3272>
   0x000000000002f659 <+2697>:	cmpl   $0x0,0xf20e0(%rip)        # 0x121740
   0x000000000002f660 <+2704>:	jne    0x2f7ac <main+3036>
   0x000000000002f666 <+2710>:	xor    %eax,%eax
   0x000000000002f668 <+2712>:	or     0xf384e(%rip),%ebx        # 0x122ebc <restricted>
   0x000000000002f66e <+2718>:	setne  %al
   0x000000000002f671 <+2721>:	cmpl   $0x0,0xf20a0(%rip)        # 0x121718
   0x000000000002f678 <+2728>:	mov    %eax,0xf383e(%rip)        # 0x122ebc <restricted>
   0x000000000002f67e <+2734>:	jne    0x2f68c <main+2748>
   0x000000000002f680 <+2736>:	mov    0xf2029(%rip),%rdi        # 0x1216b0 <shell_name>
   0x000000000002f687 <+2743>:	callq  0x31010 <maybe_make_restricted>
   0x000000000002f68c <+2748>:	callq  0x3ffe0 <cmd_init>
   0x000000000002f691 <+2753>:	callq  0x772b0 <uwp_init>
   0x000000000002f696 <+2758>:	mov    0xf6b1b(%rip),%rbx        # 0x1261b8 <command_execution_string>
   0x000000000002f69d <+2765>:	test   %rbx,%rbx
   0x000000000002f6a0 <+2768>:	je     0x2fb5c <main+3980>
   0x000000000002f6a6 <+2774>:	cmpl   $0x0,0xf1ffb(%rip)        # 0x1216a8 <debugging_mode>
   0x000000000002f6ad <+2781>:	movl   $0x2,0xf2011(%rip)        # 0x1216c8 <startup_state>
   0x000000000002f6b7 <+2791>:	je     0x2f6be <main+2798>
   0x000000000002f6b9 <+2793>:	callq  0x30ad0
   0x000000000002f6be <+2798>:	mov    0xf6af3(%rip),%rdi        # 0x1261b8 <command_execution_string>
   0x000000000002f6c5 <+2805>:	movl   $0x1,0xf1fed(%rip)        # 0x1216bc <executing>
   0x000000000002f6cf <+2815>:	callq  0x30a00
   0x000000000002f6d4 <+2820>:	mov    0xf6d4e(%rip),%edi        # 0x126428 <last_command_exit_value>
   0x000000000002f6da <+2826>:	callq  0x30ef0 <exit_shell>
   0x000000000002f6df <+2831>:	mov    0xf1f3a(%rip),%rdi        # 0x121620 <stdout>
   0x000000000002f6e6 <+2838>:	mov    $0x1,%esi
   0x000000000002f6eb <+2843>:	callq  0x30580
   0x000000000002f6f0 <+2848>:	jmpq   0x2f173 <main+1443>
   0x000000000002f6f5 <+2853>:	mov    $0x2d,%esi
   0x000000000002f6fa <+2858>:	mov    $0x69,%edi
   0x000000000002f6ff <+2863>:	callq  0x578c0 <change_flag>
   0x000000000002f704 <+2868>:	movl   $0x1,0xf1fce(%rip)        # 0x1216dc <interactive>
   0x000000000002f70e <+2878>:	jmpq   0x2f5ea <main+2586>
   0x000000000002f713 <+2883>:	cmpb   $0x2d,(%rax)
   0x000000000002f716 <+2886>:	jne    0x2f723 <main+2899>
   0x000000000002f718 <+2888>:	add    $0x1,%rax
   0x000000000002f71c <+2892>:	mov    %rax,0xf1f8d(%rip)        # 0x1216b0 <shell_name>
   0x000000000002f723 <+2899>:	movl   $0x1,0xf1fb3(%rip)        # 0x1216e0 <login_shell>
   0x000000000002f72d <+2909>:	jmpq   0x2ef9c <main+972>
   0x000000000002f732 <+2914>:	cmpb   $0x0,0x2(%rax)
   0x000000000002f736 <+2918>:	jne    0x2efc7 <main+1015>
   0x000000000002f73c <+2924>:	addl   $0x1,0xf1ffd(%rip)        # 0x121740
   0x000000000002f743 <+2931>:	jmpq   0x2efc7 <main+1015>
   0x000000000002f748 <+2936>:	cmpl   $0x0,0xf6a61(%rip)        # 0x1261b0 <dump_translatable_strings>
   0x000000000002f74f <+2943>:	je     0x2f412 <main+2114>
   0x000000000002f755 <+2949>:	jmpq   0x2f408 <main+2104>
   0x000000000002f75a <+2954>:	cmpq   $0x0,0xf6a56(%rip)        # 0x1261b8 <command_execution_string>
   0x000000000002f762 <+2962>:	je     0x2f809 <main+3129>
   0x000000000002f768 <+2968>:	callq  0x30520
   0x000000000002f76d <+2973>:	cmpl   $0x0,0xf1f6c(%rip)        # 0x1216e0 <login_shell>
   0x000000000002f774 <+2980>:	je     0x2f4c7 <main+2295>
   0x000000000002f77a <+2986>:	cmpl   $0x0,0xf1f57(%rip)        # 0x1216d8 <interactive_shell>
   0x000000000002f781 <+2993>:	je     0x2f4c7 <main+2295>
   0x000000000002f787 <+2999>:	mov    $0x3,%ebx
   0x000000000002f78c <+3004>:	mov    %ebx,%edi
   0x000000000002f78e <+3006>:	mov    $0x1,%edx
   0x000000000002f793 <+3011>:	mov    $0x2,%esi
   0x000000000002f798 <+3016>:	xor    %eax,%eax
   0x000000000002f79a <+3018>:	callq  0x2e030 <fcntl@plt>
   0x000000000002f79f <+3023>:	add    $0x1,%ebx
   0x000000000002f7a2 <+3026>:	cmp    $0x14,%ebx
   0x000000000002f7a5 <+3029>:	jne    0x2f78c <main+3004>
   0x000000000002f7a7 <+3031>:	jmpq   0x2f4c7 <main+2295>
   0x000000000002f7ac <+3036>:	xor    %edx,%edx
   0x000000000002f7ae <+3038>:	lea    0xc46c2(%rip),%rsi        # 0xf3e77
   0x000000000002f7b5 <+3045>:	lea    0xae8ef(%rip),%rdi        # 0xde0ab
   0x000000000002f7bc <+3052>:	callq  0x50f10 <bind_variable>
   0x000000000002f7c1 <+3057>:	lea    0xae8e3(%rip),%rdi        # 0xde0ab
   0x000000000002f7c8 <+3064>:	callq  0x4e200 <sv_strict_posix>
   0x000000000002f7cd <+3069>:	jmpq   0x2f666 <main+2710>
   0x000000000002f7d2 <+3074>:	mov    0x38(%rsp),%eax
   0x000000000002f7d6 <+3078>:	cmp    0x4(%rsp),%eax
   0x000000000002f7da <+3082>:	je     0x2f7e9 <main+3097>
   0x000000000002f7dc <+3084>:	cmpl   $0x0,0xf69dd(%rip)        # 0x1261c0 <read_from_stdin>
   0x000000000002f7e3 <+3091>:	je     0x2fa77 <main+3751>
   0x000000000002f7e9 <+3097>:	mov    0x38(%rsp),%esi
   0x000000000002f7ed <+3101>:	mov    0x4(%rsp),%edx
   0x000000000002f7f1 <+3105>:	mov    $0x1,%ecx
   0x000000000002f7f6 <+3110>:	mov    0x8(%rsp),%rdi
   0x000000000002f7fb <+3115>:	callq  0x30870
   0x000000000002f800 <+3120>:	mov    %eax,0x38(%rsp)
   0x000000000002f804 <+3124>:	jmpq   0x2f649 <main+2681>
   0x000000000002f809 <+3129>:	cmpl   $0x0,0xf1e90(%rip)        # 0x1216a0 <wordexp_only>
   0x000000000002f810 <+3136>:	jne    0x2f768 <main+2968>
   0x000000000002f816 <+3142>:	mov    0x38(%rsp),%eax
   0x000000000002f81a <+3146>:	cmp    0x4(%rsp),%eax
   0x000000000002f81e <+3150>:	je     0x2f82d <main+3165>
   0x000000000002f820 <+3152>:	cmpl   $0x0,0xf6999(%rip)        # 0x1261c0 <read_from_stdin>
   0x000000000002f827 <+3159>:	je     0x2f768 <main+2968>
   0x000000000002f82d <+3165>:	mov    0xf1dfc(%rip),%rdi        # 0x121630 <stdin>
   0x000000000002f834 <+3172>:	callq  0x2e4e0 <fileno@plt>
   0x000000000002f839 <+3177>:	mov    %eax,%edi
   0x000000000002f83b <+3179>:	callq  0x2df90 <isatty@plt>
   0x000000000002f840 <+3184>:	test   %eax,%eax
   0x000000000002f842 <+3186>:	je     0x2f768 <main+2968>
   0x000000000002f848 <+3192>:	mov    0xf1e31(%rip),%rdi        # 0x121680 <stderr>
   0x000000000002f84f <+3199>:	callq  0x2e4e0 <fileno@plt>
   0x000000000002f854 <+3204>:	mov    %eax,%edi
   0x000000000002f856 <+3206>:	callq  0x2df90 <isatty@plt>
   0x000000000002f85b <+3211>:	test   %eax,%eax
   0x000000000002f85d <+3213>:	jne    0x2f472 <main+2210>
   0x000000000002f863 <+3219>:	jmpq   0x2f768 <main+2968>
   0x000000000002f868 <+3224>:	xor    %edx,%edx
   0x000000000002f86a <+3226>:	lea    0xc4606(%rip),%rsi        # 0xf3e77
   0x000000000002f871 <+3233>:	lea    0xae833(%rip),%rdi        # 0xde0ab
   0x000000000002f878 <+3240>:	callq  0x50f10 <bind_variable>
   0x000000000002f87d <+3245>:	lea    0xae827(%rip),%rdi        # 0xde0ab
   0x000000000002f884 <+3252>:	callq  0x4e200 <sv_strict_posix>
   0x000000000002f889 <+3257>:	jmpq   0x2f4d4 <main+2308>
   0x000000000002f88e <+3262>:	callq  0x310a0 <disable_priv_mode>
   0x000000000002f893 <+3267>:	jmpq   0x2f428 <main+2136>
   0x000000000002f898 <+3272>:	mov    0xf365a(%rip),%eax        # 0x122ef8 <exit_immediately_on_error>
   0x000000000002f89e <+3278>:	mov    0xf1e34(%rip),%ebp        # 0x1216d8 <interactive_shell>
   0x000000000002f8a4 <+3284>:	movl   $0x0,0xf364a(%rip)        # 0x122ef8 <exit_immediately_on_error>
   0x000000000002f8ae <+3294>:	mov    %eax,0x2c(%rsp)
   0x000000000002f8b2 <+3298>:	test   %ebp,%ebp
   0x000000000002f8b4 <+3300>:	je     0x2f9c3 <main+3571>
   0x000000000002f8ba <+3306>:	xor    %edi,%edi
   0x000000000002f8bc <+3308>:	callq  0x5eec0 <set_job_control>
   0x000000000002f8c1 <+3313>:	mov    0xf1e18(%rip),%r12d        # 0x1216e0 <login_shell>
   0x000000000002f8c8 <+3320>:	mov    %eax,%ebp
   0x000000000002f8ca <+3322>:	test   %r12d,%r12d
   0x000000000002f8cd <+3325>:	jne    0x2f96a <main+3482>
   0x000000000002f8d3 <+3331>:	cmpl   $0x0,0xf1dfe(%rip)        # 0x1216d8 <interactive_shell>
   0x000000000002f8da <+3338>:	mov    0xf1db4(%rip),%eax        # 0x121694 <posixly_correct>
   0x000000000002f8e0 <+3344>:	je     0x2f99e <main+3534>
   0x000000000002f8e6 <+3350>:	test   %eax,%eax
   0x000000000002f8e8 <+3352>:	jne    0x2fb0d <main+3901>
   0x000000000002f8ee <+3358>:	cmpl   $0x0,0xf1deb(%rip)        # 0x1216e0 <login_shell>
   0x000000000002f8f5 <+3365>:	je     0x2f911 <main+3393>
   0x000000000002f8f7 <+3367>:	and    $0x1,%r12b
   0x000000000002f8fb <+3371>:	jne    0x2f911 <main+3393>
   0x000000000002f8fd <+3373>:	addl   $0x1,0xf1e28(%rip)        # 0x12172c
   0x000000000002f904 <+3380>:	cmpl   $0x0,0xf1e1d(%rip)        # 0x121728
   0x000000000002f90b <+3387>:	je     0x3008d <main+5309>
   0x000000000002f911 <+3393>:	cmpl   $0x0,0xf1e28(%rip)        # 0x121740
   0x000000000002f918 <+3400>:	jne    0x2fb0d <main+3901>
   0x000000000002f91e <+3406>:	cmpl   $0x0,0xf1e07(%rip)        # 0x12172c
   0x000000000002f925 <+3413>:	je     0x300ef <main+5407>
   0x000000000002f92b <+3419>:	mov    %ebp,%edi
   0x000000000002f92d <+3421>:	callq  0x5eec0 <set_job_control>
   0x000000000002f932 <+3426>:	mov    0x2c(%rsp),%eax
   0x000000000002f936 <+3430>:	add    %eax,0xf35bc(%rip)        # 0x122ef8 <exit_immediately_on_error>
   0x000000000002f93c <+3436>:	jmpq   0x2f659 <main+2697>
   0x000000000002f941 <+3441>:	xor    %edi,%edi
   0x000000000002f943 <+3443>:	mov    $0x5,%edx
   0x000000000002f948 <+3448>:	lea    0xaeb59(%rip),%rsi        # 0xde4a8
   0x000000000002f94f <+3455>:	callq  0x2e130 <dcgettext@plt>
   0x000000000002f954 <+3460>:	lea    0xae725(%rip),%rsi        # 0xde080
   0x000000000002f95b <+3467>:	mov    %rax,%rdi
   0x000000000002f95e <+3470>:	xor    %eax,%eax
   0x000000000002f960 <+3472>:	callq  0x54c40 <report_error>
   0x000000000002f965 <+3477>:	jmpq   0x2ec7c <main+172>
   0x000000000002f96a <+3482>:	cmpl   $0x0,0xf1d23(%rip)        # 0x121694 <posixly_correct>
   0x000000000002f971 <+3489>:	jne    0x2fafd <main+3885>
   0x000000000002f977 <+3495>:	addl   $0x1,0xf1dae(%rip)        # 0x12172c
   0x000000000002f97e <+3502>:	cmpl   $0x0,0xf1da3(%rip)        # 0x121728
   0x000000000002f985 <+3509>:	je     0x2fe97 <main+4807>
   0x000000000002f98b <+3515>:	cmpl   $0x0,0xf1d46(%rip)        # 0x1216d8 <interactive_shell>
   0x000000000002f992 <+3522>:	jne    0x2f911 <main+3393>
   0x000000000002f998 <+3528>:	mov    $0x1,%r12d
   0x000000000002f99e <+3534>:	cmpl   $0x0,0xf1d97(%rip)        # 0x12173c
   0x000000000002f9a5 <+3541>:	mov    0xf1ce9(%rip),%eax        # 0x121694 <posixly_correct>
   0x000000000002f9ab <+3547>:	je     0x2fa23 <main+3667>
   0x000000000002f9ad <+3549>:	cmpl   $0x0,0xf1d2c(%rip)        # 0x1216e0 <login_shell>
   0x000000000002f9b4 <+3556>:	je     0x2fa23 <main+3667>
   0x000000000002f9b6 <+3558>:	test   %eax,%eax
   0x000000000002f9b8 <+3560>:	jne    0x2f92b <main+3419>
   0x000000000002f9be <+3566>:	jmpq   0x2f8ee <main+3358>
   0x000000000002f9c3 <+3571>:	mov    0xf1d63(%rip),%eax        # 0x12172c
   0x000000000002f9c9 <+3577>:	or     0xf1d11(%rip),%eax        # 0x1216e0 <login_shell>
   0x000000000002f9cf <+3583>:	or     0xf1d6b(%rip),%eax        # 0x121740
   0x000000000002f9d5 <+3589>:	jne    0x2fa10 <main+3648>
   0x000000000002f9d7 <+3591>:	cmpq   $0x0,0xf67d9(%rip)        # 0x1261b8 <command_execution_string>
   0x000000000002f9df <+3599>:	je     0x2fa1d <main+3661>
   0x000000000002f9e1 <+3601>:	lea    0xae761(%rip),%rdi        # 0xde149
   0x000000000002f9e8 <+3608>:	callq  0x4dfa0 <find_variable>
   0x000000000002f9ed <+3613>:	test   %rax,%rax
   0x000000000002f9f0 <+3616>:	je     0x302d2 <main+5890>
   0x000000000002f9f6 <+3622>:	cmpl   $0x1,0xf32ab(%rip)        # 0x122ca8 <shell_level>
   0x000000000002f9fd <+3629>:	jle    0x302ab <main+5851>
   0x000000000002fa03 <+3635>:	cmpl   $0x0,0xf1cce(%rip)        # 0x1216d8 <interactive_shell>
   0x000000000002fa0a <+3642>:	jne    0x2f8ba <main+3306>
   0x000000000002fa10 <+3648>:	cmpl   $0x0,0xf1cc9(%rip)        # 0x1216e0 <login_shell>
   0x000000000002fa17 <+3655>:	jne    0x2f96a <main+3482>
   0x000000000002fa1d <+3661>:	mov    0xf1c71(%rip),%eax        # 0x121694 <posixly_correct>
   0x000000000002fa23 <+3667>:	or     0xf1d17(%rip),%eax        # 0x121740
   0x000000000002fa29 <+3673>:	or     0xf3485(%rip),%eax        # 0x122eb4 <privileged_mode>
   0x000000000002fa2f <+3679>:	jne    0x2f932 <main+3426>
   0x000000000002fa35 <+3685>:	mov    0xf1cfd(%rip),%eax        # 0x121738
   0x000000000002fa3b <+3691>:	lea    0x1(%rax),%edx
   0x000000000002fa3e <+3694>:	mov    %edx,0xf1cf4(%rip)        # 0x121738
   0x000000000002fa44 <+3700>:	test   %eax,%eax
   0x000000000002fa46 <+3702>:	jne    0x2f932 <main+3426>
   0x000000000002fa4c <+3708>:	lea    0xae64f(%rip),%rdi        # 0xde0a2
   0x000000000002fa53 <+3715>:	callq  0x4e8c0 <get_string_value>
   0x000000000002fa58 <+3720>:	mov    %rax,%rdi
   0x000000000002fa5b <+3723>:	test   %rax,%rax
   0x000000000002fa5e <+3726>:	je     0x2f932 <main+3426>
   0x000000000002fa64 <+3732>:	cmpb   $0x0,(%rax)
   0x000000000002fa67 <+3735>:	je     0x2f932 <main+3426>
   0x000000000002fa6d <+3741>:	callq  0x30b50
   0x000000000002fa72 <+3746>:	jmpq   0x2f932 <main+3426>
   0x000000000002fa77 <+3751>:	movslq 0x38(%rsp),%rax
   0x000000000002fa7c <+3756>:	mov    0x8(%rsp),%rdi
   0x000000000002fa81 <+3761>:	mov    $0x1,%ecx
   0x000000000002fa86 <+3766>:	lea    0x1(%rax),%edx
   0x000000000002fa89 <+3769>:	mov    (%rdi,%rax,8),%rax
   0x000000000002fa8d <+3773>:	mov    %edx,0x38(%rsp)
   0x000000000002fa91 <+3777>:	mov    0x4(%rsp),%edx
   0x000000000002fa95 <+3781>:	mov    0x38(%rsp),%esi
   0x000000000002fa99 <+3785>:	mov    %rax,0xf6730(%rip)        # 0x1261d0 <shell_script_filename>
   0x000000000002faa0 <+3792>:	callq  0x30870
   0x000000000002faa5 <+3797>:	mov    %eax,0x38(%rsp)
   0x000000000002faa9 <+3801>:	jmpq   0x2f649 <main+2681>
   0x000000000002faae <+3806>:	lea    0xae606(%rip),%rdi        # 0xde0bb
   0x000000000002fab5 <+3813>:	callq  0xaf9e0 <getenv>
   0x000000000002faba <+3818>:	test   %rax,%rax
   0x000000000002fabd <+3821>:	jne    0x2ed4e <main+382>
   0x000000000002fac3 <+3827>:	jmpq   0x2ed58 <main+392>
   0x000000000002fac8 <+3832>:	xor    %edi,%edi
   0x000000000002faca <+3834>:	mov    $0x5,%edx
   0x000000000002facf <+3839>:	lea    0xae61d(%rip),%rsi        # 0xde0f3
   0x000000000002fad6 <+3846>:	callq  0x2e130 <dcgettext@plt>
   0x000000000002fadb <+3851>:	mov    %ebp,%esi
   0x000000000002fadd <+3853>:	mov    %r14d,%edx
   0x000000000002fae0 <+3856>:	mov    %rax,%rdi
   0x000000000002fae3 <+3859>:	xor    %eax,%eax
   0x000000000002fae5 <+3861>:	callq  0x54c40 <report_error>
   0x000000000002faea <+3866>:	mov    0xf1b8f(%rip),%rdi        # 0x121680 <stderr>
   0x000000000002faf1 <+3873>:	xor    %esi,%esi
   0x000000000002faf3 <+3875>:	callq  0x30580
   0x000000000002faf8 <+3880>:	jmpq   0x2ec7c <main+172>
   0x000000000002fafd <+3885>:	mov    0xf1bd4(%rip),%r12d        # 0x1216d8 <interactive_shell>
   0x000000000002fb04 <+3892>:	test   %r12d,%r12d
   0x000000000002fb07 <+3895>:	je     0x2f99e <main+3534>
   0x000000000002fb0d <+3901>:	cmpl   $0x0,0xf33a0(%rip)        # 0x122eb4 <privileged_mode>
   0x000000000002fb14 <+3908>:	jne    0x2f92b <main+3419>
   0x000000000002fb1a <+3914>:	mov    0xf1c18(%rip),%eax        # 0x121738
   0x000000000002fb20 <+3920>:	lea    0x1(%rax),%edx
   0x000000000002fb23 <+3923>:	mov    %edx,0xf1c0f(%rip)        # 0x121738
   0x000000000002fb29 <+3929>:	test   %eax,%eax
   0x000000000002fb2b <+3931>:	jne    0x2f92b <main+3419>
   0x000000000002fb31 <+3937>:	lea    0xae56f(%rip),%rdi        # 0xde0a7
   0x000000000002fb38 <+3944>:	callq  0x4e8c0 <get_string_value>
   0x000000000002fb3d <+3949>:	mov    %rax,%rdi
   0x000000000002fb40 <+3952>:	test   %rax,%rax
   0x000000000002fb43 <+3955>:	je     0x2f92b <main+3419>
   0x000000000002fb49 <+3961>:	cmpb   $0x0,(%rax)
   0x000000000002fb4c <+3964>:	je     0x2f92b <main+3419>
   0x000000000002fb52 <+3970>:	callq  0x30b50
   0x000000000002fb57 <+3975>:	jmpq   0x2f92b <main+3419>
   0x000000000002fb5c <+3980>:	mov    0xf666d(%rip),%r13        # 0x1261d0 <shell_script_filename>
   0x000000000002fb63 <+3987>:	test   %r13,%r13
   0x000000000002fb66 <+3990>:	je     0x2fe57 <main+4743>
   0x000000000002fb6c <+3996>:	xor    %eax,%eax
   0x000000000002fb6e <+3998>:	mov    %r13,%rdi
   0x000000000002fb71 <+4001>:	or     $0xffffffffffffffff,%rcx
   0x000000000002fb75 <+4005>:	repnz scas %es:(%rdi),%al
   0x000000000002fb77 <+4007>:	not    %rcx
   0x000000000002fb7a <+4010>:	mov    %rcx,%rdi
   0x000000000002fb7d <+4013>:	callq  0x90510 <xmalloc>
   0x000000000002fb82 <+4018>:	mov    %r13,%rsi
   0x000000000002fb85 <+4021>:	mov    %rax,%rdi
   0x000000000002fb88 <+4024>:	callq  0x2df30 <strcpy@plt>
   0x000000000002fb8d <+4029>:	xor    %esi,%esi
   0x000000000002fb8f <+4031>:	mov    %rax,%rdi
   0x000000000002fb92 <+4034>:	mov    %rax,%rbp
   0x000000000002fb95 <+4037>:	xor    %eax,%eax
   0x000000000002fb97 <+4039>:	callq  0x2e870 <open@plt>
   0x000000000002fb9c <+4044>:	mov    %eax,%r12d
   0x000000000002fb9f <+4047>:	test   %eax,%eax
   0x000000000002fba1 <+4049>:	js     0x3017d <main+5549>
   0x000000000002fba7 <+4055>:	mov    0xf68b2(%rip),%rdi        # 0x126460 <dollar_vars>
   0x000000000002fbae <+4062>:	callq  0x2de50 <free@plt>
   0x000000000002fbb3 <+4067>:	mov    0xf65de(%rip),%r14        # 0x126198 <exec_argv0>
   0x000000000002fbba <+4074>:	or     $0xffffffffffffffff,%rcx
   0x000000000002fbbe <+4078>:	xor    %eax,%eax
   0x000000000002fbc0 <+4080>:	test   %r14,%r14
   0x000000000002fbc3 <+4083>:	je     0x3015d <main+5517>
   0x000000000002fbc9 <+4089>:	mov    %r14,%rdi
   0x000000000002fbcc <+4092>:	repnz scas %es:(%rdi),%al
   0x000000000002fbce <+4094>:	not    %rcx
   0x000000000002fbd1 <+4097>:	mov    %rcx,%rdi
   0x000000000002fbd4 <+4100>:	callq  0x90510 <xmalloc>
   0x000000000002fbd9 <+4105>:	mov    %r14,%rsi
   0x000000000002fbdc <+4108>:	mov    %rax,%rdi
   0x000000000002fbdf <+4111>:	callq  0x2df30 <strcpy@plt>
   0x000000000002fbe4 <+4116>:	mov    0xf65ad(%rip),%rdi        # 0x126198 <exec_argv0>
   0x000000000002fbeb <+4123>:	mov    %rax,0xf686e(%rip)        # 0x126460 <dollar_vars>
   0x000000000002fbf2 <+4130>:	test   %rdi,%rdi
   0x000000000002fbf5 <+4133>:	je     0x2fc07 <main+4151>
   0x000000000002fbf7 <+4135>:	callq  0x2de50 <free@plt>
   0x000000000002fbfc <+4140>:	movq   $0x0,0xf6591(%rip)        # 0x126198 <exec_argv0>
   0x000000000002fc07 <+4151>:	mov    %rbp,%rdi
   0x000000000002fc0a <+4154>:	callq  0x3f2f0 <file_isdir>
   0x000000000002fc0f <+4159>:	test   %eax,%eax
   0x000000000002fc11 <+4161>:	jne    0x3032c <main+5980>
   0x000000000002fc17 <+4167>:	lea    0xae589(%rip),%rdi        # 0xde1a7
   0x000000000002fc1e <+4174>:	callq  0x4dfa0 <find_variable>
   0x000000000002fc23 <+4179>:	mov    %rax,%r14
   0x000000000002fc26 <+4182>:	test   %rax,%rax
   0x000000000002fc29 <+4185>:	je     0x2fc39 <main+4201>
   0x000000000002fc2b <+4187>:	testb  $0x4,0x28(%rax)
   0x000000000002fc2f <+4191>:	je     0x30155 <main+5509>
   0x000000000002fc35 <+4197>:	mov    0x8(%rax),%r14
   0x000000000002fc39 <+4201>:	lea    0xae570(%rip),%rdi        # 0xde1b0
   0x000000000002fc40 <+4208>:	callq  0x4dfa0 <find_variable>
   0x000000000002fc45 <+4213>:	mov    %rax,%r15
   0x000000000002fc48 <+4216>:	test   %rax,%rax
   0x000000000002fc4b <+4219>:	je     0x2fc5b <main+4235>
   0x000000000002fc4d <+4221>:	testb  $0x4,0x28(%rax)
   0x000000000002fc51 <+4225>:	je     0x2ffc9 <main+5113>
   0x000000000002fc57 <+4231>:	mov    0x8(%rax),%r15
   0x000000000002fc5b <+4235>:	lea    0xae55a(%rip),%rdi        # 0xde1bc
   0x000000000002fc62 <+4242>:	callq  0x4dfa0 <find_variable>
   0x000000000002fc67 <+4247>:	mov    %rax,%r13
   0x000000000002fc6a <+4250>:	test   %rax,%rax
   0x000000000002fc6d <+4253>:	je     0x2fc7d <main+4269>
   0x000000000002fc6f <+4255>:	testb  $0x4,0x28(%rax)
   0x000000000002fc73 <+4259>:	je     0x301af <main+5599>
   0x000000000002fc79 <+4265>:	mov    0x8(%rax),%r13
   0x000000000002fc7d <+4269>:	mov    %rbp,%rdx
   0x000000000002fc80 <+4272>:	mov    $0x1,%esi
   0x000000000002fc85 <+4277>:	mov    %r15,%rdi
   0x000000000002fc88 <+4280>:	callq  0x7b740 <array_rshift>
   0x000000000002fc8d <+4285>:	test   %r13,%r13
   0x000000000002fc90 <+4288>:	je     0x2fcba <main+4330>
   0x000000000002fc92 <+4290>:	callq  0x45240 <executing_line_number>
   0x000000000002fc97 <+4295>:	movslq %eax,%rdi
   0x000000000002fc9a <+4298>:	callq  0xafd60 <itos>
   0x000000000002fc9f <+4303>:	mov    %r13,%rdi
   0x000000000002fca2 <+4306>:	mov    $0x1,%esi
   0x000000000002fca7 <+4311>:	mov    %rax,%r15
   0x000000000002fcaa <+4314>:	mov    %rax,%rdx
   0x000000000002fcad <+4317>:	callq  0x7b740 <array_rshift>
   0x000000000002fcb2 <+4322>:	mov    %r15,%rdi
   0x000000000002fcb5 <+4325>:	callq  0x2de50 <free@plt>
   0x000000000002fcba <+4330>:	lea    0xae507(%rip),%rdx        # 0xde1c8
   0x000000000002fcc1 <+4337>:	mov    $0x1,%esi
   0x000000000002fcc6 <+4342>:	mov    %r14,%rdi
   0x000000000002fcc9 <+4345>:	callq  0x7b740 <array_rshift>
   0x000000000002fcce <+4350>:	mov    %r12d,%edi
   0x000000000002fcd1 <+4353>:	callq  0x2df90 <isatty@plt>
   0x000000000002fcd6 <+4358>:	mov    %eax,%ebx
   0x000000000002fcd8 <+4360>:	test   %eax,%eax
   0x000000000002fcda <+4362>:	jne    0x2fd32 <main+4450>
   0x000000000002fcdc <+4364>:	xor    %esi,%esi
   0x000000000002fcde <+4366>:	mov    $0x1,%edx
   0x000000000002fce3 <+4371>:	mov    %r12d,%edi
   0x000000000002fce6 <+4374>:	callq  0x2e260 <lseek@plt>
   0x000000000002fceb <+4379>:	add    $0x1,%rax
   0x000000000002fcef <+4383>:	je     0x2fd32 <main+4450>
   0x000000000002fcf1 <+4385>:	lea    0xd0(%rsp),%r13
   0x000000000002fcf9 <+4393>:	mov    $0x50,%edx
   0x000000000002fcfe <+4398>:	mov    %r12d,%edi
   0x000000000002fd01 <+4401>:	mov    %r13,%rsi
   0x000000000002fd04 <+4404>:	callq  0x2e370 <read@plt>
   0x000000000002fd09 <+4409>:	mov    %rax,%rsi
   0x000000000002fd0c <+4412>:	test   %eax,%eax
   0x000000000002fd0e <+4414>:	js     0x3034e <main+6014>
   0x000000000002fd14 <+4420>:	je     0x2fd26 <main+4438>
   0x000000000002fd16 <+4422>:	mov    %r13,%rdi
   0x000000000002fd19 <+4425>:	callq  0x3f1e0 <check_binary_file>
   0x000000000002fd1e <+4430>:	test   %eax,%eax
   0x000000000002fd20 <+4432>:	jne    0x303e4 <main+6164>
   0x000000000002fd26 <+4438>:	xor    %edx,%edx
   0x000000000002fd28 <+4440>:	xor    %esi,%esi
   0x000000000002fd2a <+4442>:	mov    %r12d,%edi
   0x000000000002fd2d <+4445>:	callq  0x2e260 <lseek@plt>
   0x000000000002fd32 <+4450>:	or     $0xffffffff,%edx
   0x000000000002fd35 <+4453>:	mov    %r12d,%edi
   0x000000000002fd38 <+4456>:	mov    $0x1,%esi
   0x000000000002fd3d <+4461>:	callq  0x3f0c0 <move_to_high_fd>
   0x000000000002fd42 <+4466>:	mov    $0x1,%edx
   0x000000000002fd47 <+4471>:	mov    $0x2,%esi
   0x000000000002fd4c <+4476>:	mov    %eax,0xe92ce(%rip)        # 0x119020 <default_buffered_input>
   0x000000000002fd52 <+4482>:	mov    %eax,%edi
   0x000000000002fd54 <+4484>:	mov    %eax,%r12d
   0x000000000002fd57 <+4487>:	xor    %eax,%eax
   0x000000000002fd59 <+4489>:	callq  0x2e030 <fcntl@plt>
   0x000000000002fd5e <+4494>:	cmpl   $0x0,0xf1973(%rip)        # 0x1216d8 <interactive_shell>
   0x000000000002fd65 <+4501>:	je     0x2ff4d <main+4989>
   0x000000000002fd6b <+4507>:	test   %ebx,%ebx
   0x000000000002fd6d <+4509>:	jne    0x3028a <main+5818>
   0x000000000002fd73 <+4515>:	cmpl   $0x0,0xf3152(%rip)        # 0x122ecc <forced_interactive>
   0x000000000002fd7a <+4522>:	jne    0x2ff62 <main+5010>
   0x000000000002fd80 <+4528>:	mov    %rbp,%rdi
   0x000000000002fd83 <+4531>:	callq  0x2de50 <free@plt>
   0x000000000002fd88 <+4536>:	movl   $0x1,0xf1932(%rip)        # 0x1216c4 <reading_shell_script>
   0x000000000002fd92 <+4546>:	cmpl   $0x0,0xf1943(%rip)        # 0x1216dc <interactive>
   0x000000000002fd99 <+4553>:	jne    0x2fe7f <main+4783>
   0x000000000002fd9f <+4559>:	mov    0xe927b(%rip),%edi        # 0x119020 <default_buffered_input>
   0x000000000002fda5 <+4565>:	callq  0x3eec0 <sh_unset_nodelay_mode>
   0x000000000002fdaa <+4570>:	cmpl   $0x0,0xf192b(%rip)        # 0x1216dc <interactive>
   0x000000000002fdb1 <+4577>:	jne    0x2fe32 <main+4706>
   0x000000000002fdb3 <+4579>:	mov    0xf66a6(%rip),%rsi        # 0x126460 <dollar_vars>
   0x000000000002fdba <+4586>:	mov    0xe9260(%rip),%edi        # 0x119020 <default_buffered_input>
   0x000000000002fdc0 <+4592>:	callq  0x76f70 <with_input_from_buffered_stream>
   0x000000000002fdc5 <+4597>:	cmpl   $0x0,0xf18dc(%rip)        # 0x1216a8 <debugging_mode>
   0x000000000002fdcc <+4604>:	je     0x2fdf5 <main+4645>
   0x000000000002fdce <+4606>:	mov    0x34(%rsp),%eax
   0x000000000002fdd2 <+4610>:	or     0xf195c(%rip),%eax        # 0x121734
   0x000000000002fdd8 <+4616>:	jne    0x2fdf5 <main+4645>
   0x000000000002fdda <+4618>:	cmpl   $0x0,0xf18e3(%rip)        # 0x1216c4 <reading_shell_script>
   0x000000000002fde1 <+4625>:	jne    0x2fdf0 <main+4640>
   0x000000000002fde3 <+4627>:	cmpl   $0x0,0xf18ee(%rip)        # 0x1216d8 <interactive_shell>
   0x000000000002fdea <+4634>:	jne    0x2ff9e <main+5070>
   0x000000000002fdf0 <+4640>:	callq  0x30ad0
   0x000000000002fdf5 <+4645>:	cmpl   $0x0,0xf18dc(%rip)        # 0x1216d8 <interactive_shell>
   0x000000000002fdfc <+4652>:	jne    0x2ff9e <main+5070>
   0x000000000002fe02 <+4658>:	cmpl   $0x0,0xf188f(%rip)        # 0x121698 <pretty_print_mode>
   0x000000000002fe09 <+4665>:	movl   $0x1,0xf18e9(%rip)        # 0x1216fc <shell_initialized>
   0x000000000002fe13 <+4675>:	je     0x2fef4 <main+4900>
   0x000000000002fe19 <+4681>:	cmpl   $0x0,0xf18b8(%rip)        # 0x1216d8 <interactive_shell>
   0x000000000002fe20 <+4688>:	jne    0x2fecd <main+4861>
   0x000000000002fe26 <+4694>:	callq  0x317f0 <pretty_print_loop>
   0x000000000002fe2b <+4699>:	mov    %eax,%edi
   0x000000000002fe2d <+4701>:	callq  0x30ef0 <exit_shell>
   0x000000000002fe32 <+4706>:	cmpl   $0x0,0xf186b(%rip)        # 0x1216a4 <no_line_editing>
   0x000000000002fe39 <+4713>:	je     0x2ffd1 <main+5121>
   0x000000000002fe3f <+4719>:	mov    0xf661a(%rip),%rsi        # 0x126460 <dollar_vars>
   0x000000000002fe46 <+4726>:	mov    0xf18c3(%rip),%rdi        # 0x121710
   0x000000000002fe4d <+4733>:	callq  0x32710 <with_input_from_stream>
   0x000000000002fe52 <+4738>:	jmpq   0x2fdc5 <main+4597>
   0x000000000002fe57 <+4743>:	cmpl   $0x0,0xf187e(%rip)        # 0x1216dc <interactive>
   0x000000000002fe5e <+4750>:	mov    0xf17cb(%rip),%rdi        # 0x121630 <stdin>
   0x000000000002fe65 <+4757>:	je     0x3013b <main+5483>
   0x000000000002fe6b <+4763>:	mov    0x3c(%rsp),%eax
   0x000000000002fe6f <+4767>:	cmp    0x4(%rsp),%eax
   0x000000000002fe73 <+4771>:	jne    0x2fe7f <main+4783>
   0x000000000002fe75 <+4773>:	movl   $0x1,0xf6341(%rip)        # 0x1261c0 <read_from_stdin>
   0x000000000002fe7f <+4783>:	mov    0xf17aa(%rip),%rdi        # 0x121630 <stdin>
   0x000000000002fe86 <+4790>:	callq  0x2e4e0 <fileno@plt>
   0x000000000002fe8b <+4795>:	mov    %eax,%edi
   0x000000000002fe8d <+4797>:	callq  0x3eec0 <sh_unset_nodelay_mode>
   0x000000000002fe92 <+4802>:	jmpq   0x2fdaa <main+4570>
   0x000000000002fe97 <+4807>:	mov    $0x1,%esi
   0x000000000002fe9c <+4812>:	lea    0xae2ce(%rip),%rdi        # 0xde171
   0x000000000002fea3 <+4819>:	callq  0x96690 <maybe_execute_file>
   0x000000000002fea8 <+4824>:	cmpl   $0x0,0xf1891(%rip)        # 0x121740
   0x000000000002feaf <+4831>:	mov    $0x1,%esi
   0x000000000002feb4 <+4836>:	je     0x2ff04 <main+4916>
   0x000000000002feb6 <+4838>:	lea    0xae2c1(%rip),%rdi        # 0xde17e
   0x000000000002febd <+4845>:	mov    $0x1,%r12d
   0x000000000002fec3 <+4851>:	callq  0x96690 <maybe_execute_file>
   0x000000000002fec8 <+4856>:	jmpq   0x2f8d3 <main+3331>
   0x000000000002fecd <+4861>:	mov    $0x5,%edx
   0x000000000002fed2 <+4866>:	lea    0xae60f(%rip),%rsi        # 0xde4e8
   0x000000000002fed9 <+4873>:	xor    %edi,%edi
   0x000000000002fedb <+4875>:	callq  0x2e130 <dcgettext@plt>
   0x000000000002fee0 <+4880>:	mov    %rax,%rdi
   0x000000000002fee3 <+4883>:	xor    %eax,%eax
   0x000000000002fee5 <+4885>:	callq  0x54f60 <internal_warning>
   0x000000000002feea <+4890>:	movl   $0x0,0xf17a4(%rip)        # 0x121698 <pretty_print_mode>
   0x000000000002fef4 <+4900>:	callq  0x31490 <reader_loop>
   0x000000000002fef9 <+4905>:	mov    0xf6529(%rip),%edi        # 0x126428 <last_command_exit_value>
   0x000000000002feff <+4911>:	callq  0x30ef0 <exit_shell>
   0x000000000002ff04 <+4916>:	lea    0xae27e(%rip),%rdi        # 0xde189
   0x000000000002ff0b <+4923>:	mov    $0x1,%r12d
   0x000000000002ff11 <+4929>:	callq  0x96690 <maybe_execute_file>
   0x000000000002ff16 <+4934>:	test   %eax,%eax
   0x000000000002ff18 <+4936>:	jne    0x2f8d3 <main+3331>
   0x000000000002ff1e <+4942>:	mov    $0x1,%esi
   0x000000000002ff23 <+4947>:	lea    0xae26f(%rip),%rdi        # 0xde199
   0x000000000002ff2a <+4954>:	callq  0x96690 <maybe_execute_file>
   0x000000000002ff2f <+4959>:	test   %eax,%eax
   0x000000000002ff31 <+4961>:	jne    0x2f8d3 <main+3331>
   0x000000000002ff37 <+4967>:	mov    $0x1,%esi
   0x000000000002ff3c <+4972>:	lea    0xae23b(%rip),%rdi        # 0xde17e
   0x000000000002ff43 <+4979>:	callq  0x96690 <maybe_execute_file>
   0x000000000002ff48 <+4984>:	jmpq   0x2f8d3 <main+3331>
   0x000000000002ff4d <+4989>:	cmpl   $0x0,0xf2f78(%rip)        # 0x122ecc <forced_interactive>
   0x000000000002ff54 <+4996>:	je     0x2fd80 <main+4528>
   0x000000000002ff5a <+5002>:	test   %ebx,%ebx
   0x000000000002ff5c <+5004>:	jne    0x2fd80 <main+4528>
   0x000000000002ff62 <+5010>:	callq  0x30520
   0x000000000002ff67 <+5015>:	movl   $0x1,0xf1757(%rip)        # 0x1216c8 <startup_state>
   0x000000000002ff71 <+5025>:	movl   $0x1,0xf175d(%rip)        # 0x1216d8 <interactive_shell>
   0x000000000002ff7b <+5035>:	movl   $0x1,0xf182f(%rip)        # 0x1217b4 <expand_aliases>
   0x000000000002ff85 <+5045>:	movl   $0x1,0xf4575(%rip)        # 0x124504 <enable_history_list>
   0x000000000002ff8f <+5055>:	movl   $0x1,0xf456f(%rip)        # 0x124508 <remember_on_history>
   0x000000000002ff99 <+5065>:	jmpq   0x2fd80 <main+4528>
   0x000000000002ff9e <+5070>:	callq  0x74100 <reset_mail_timer>
   0x000000000002ffa3 <+5075>:	callq  0x74330 <init_mail_dates>
   0x000000000002ffa8 <+5080>:	callq  0x81200 <bash_initialize_history>
   0x000000000002ffad <+5085>:	mov    0xf1749(%rip),%eax        # 0x1216fc <shell_initialized>
   0x000000000002ffb3 <+5091>:	or     0xfad73(%rip),%eax        # 0x12ad2c <history_lines_this_session>
   0x000000000002ffb9 <+5097>:	je     0x30390 <main+6080>
   0x000000000002ffbf <+5103>:	callq  0x5a910 <get_tty_state>
   0x000000000002ffc4 <+5108>:	jmpq   0x2fe02 <main+4658>
   0x000000000002ffc9 <+5113>:	mov    %rbx,%r15
   0x000000000002ffcc <+5116>:	jmpq   0x2fc5b <main+4235>
   0x000000000002ffd1 <+5121>:	callq  0x32680 <with_input_from_stdin>
   0x000000000002ffd6 <+5126>:	jmpq   0x2fdc5 <main+4597>
   0x000000000002ffdb <+5131>:	lea    0xb2722(%rip),%rdi        # 0xe2704
   0x000000000002ffe2 <+5138>:	callq  0x4e8c0 <get_string_value>
   0x000000000002ffe7 <+5143>:	lea    0xae12d(%rip),%rdi        # 0xde11b
   0x000000000002ffee <+5150>:	mov    %rax,%rbp
   0x000000000002fff1 <+5153>:	callq  0x4e8c0 <get_string_value>
   0x000000000002fff6 <+5158>:	lea    0xae117(%rip),%rdi        # 0xde114
   0x000000000002fffd <+5165>:	mov    %rax,%r13
   0x0000000000030000 <+5168>:	callq  0x4e8c0 <get_string_value>
   0x0000000000030005 <+5173>:	mov    %rax,%rdi
   0x0000000000030008 <+5176>:	test   %rax,%rax
   0x000000000003000b <+5179>:	je     0x301db <main+5643>
   0x0000000000030011 <+5185>:	lea    0xae109(%rip),%rsi        # 0xde121
   0x0000000000030018 <+5192>:	xor    %r12d,%r12d
   0x000000000003001b <+5195>:	callq  0x2eb00 <strstr@plt>
   0x0000000000030020 <+5200>:	test   %rax,%rax
   0x0000000000030023 <+5203>:	setne  %r12b
   0x0000000000030027 <+5207>:	cmpb   $0x65,0x0(%rbp)
   0x000000000003002b <+5211>:	mov    0xf1673(%rip),%ebx        # 0x1216a4 <no_line_editing>
   0x0000000000030031 <+5217>:	je     0x301b7 <main+5607>
   0x0000000000030037 <+5223>:	cmpb   $0x64,0x0(%rbp)
   0x000000000003003b <+5227>:	je     0x30307 <main+5943>
   0x0000000000030041 <+5233>:	mov    %ebx,0xf165d(%rip)        # 0x1216a4 <no_line_editing>
   0x0000000000030047 <+5239>:	movl   $0x1,0xf618b(%rip)        # 0x1261dc <running_under_emacs>
   0x0000000000030051 <+5249>:	test   %r12d,%r12d
   0x0000000000030054 <+5252>:	je     0x3007e <main+5294>
   0x0000000000030056 <+5254>:	cmpb   $0x65,0x0(%rbp)
   0x000000000003005a <+5258>:	jne    0x3007e <main+5294>
   0x000000000003005c <+5260>:	mov    $0x5,%edx
   0x0000000000030061 <+5265>:	lea    0xae0d3(%rip),%rsi        # 0xde13b
   0x0000000000030068 <+5272>:	mov    %rbp,%rdi
   0x000000000003006b <+5275>:	callq  0x2df10 <strncmp@plt>
   0x0000000000030070 <+5280>:	test   %eax,%eax
   0x0000000000030072 <+5282>:	jne    0x3007e <main+5294>
   0x0000000000030074 <+5284>:	movl   $0x2,0xf615e(%rip)        # 0x1261dc <running_under_emacs>
   0x000000000003007e <+5294>:	movl   $0x1,0xf2cf0(%rip)        # 0x122d78 <gnu_error_format>
   0x0000000000030088 <+5304>:	jmpq   0x2f55c <main+2444>
   0x000000000003008d <+5309>:	mov    $0x1,%esi
   0x0000000000030092 <+5314>:	lea    0xae0d8(%rip),%rdi        # 0xde171
   0x0000000000030099 <+5321>:	callq  0x96690 <maybe_execute_file>
   0x000000000003009e <+5326>:	cmpl   $0x0,0xf169b(%rip)        # 0x121740
   0x00000000000300a5 <+5333>:	jne    0x300d9 <main+5385>
   0x00000000000300a7 <+5335>:	mov    $0x1,%esi
   0x00000000000300ac <+5340>:	lea    0xae0d6(%rip),%rdi        # 0xde189
   0x00000000000300b3 <+5347>:	callq  0x96690 <maybe_execute_file>
   0x00000000000300b8 <+5352>:	test   %eax,%eax
   0x00000000000300ba <+5354>:	jne    0x2f911 <main+3393>
   0x00000000000300c0 <+5360>:	mov    $0x1,%esi
   0x00000000000300c5 <+5365>:	lea    0xae0cd(%rip),%rdi        # 0xde199
   0x00000000000300cc <+5372>:	callq  0x96690 <maybe_execute_file>
   0x00000000000300d1 <+5377>:	test   %eax,%eax
   0x00000000000300d3 <+5379>:	jne    0x2f911 <main+3393>
   0x00000000000300d9 <+5385>:	mov    $0x1,%esi
   0x00000000000300de <+5390>:	lea    0xae099(%rip),%rdi        # 0xde17e
   0x00000000000300e5 <+5397>:	callq  0x96690 <maybe_execute_file>
   0x00000000000300ea <+5402>:	jmpq   0x2f911 <main+3393>
   0x00000000000300ef <+5407>:	mov    $0x1,%esi
   0x00000000000300f4 <+5412>:	lea    0xae065(%rip),%rdi        # 0xde160
   0x00000000000300fb <+5419>:	callq  0x96690 <maybe_execute_file>
   0x0000000000030100 <+5424>:	mov    0xe8f61(%rip),%rdi        # 0x119068
   0x0000000000030107 <+5431>:	mov    $0x1,%esi
   0x000000000003010c <+5436>:	callq  0x96690 <maybe_execute_file>
   0x0000000000030111 <+5441>:	jmpq   0x2f92b <main+3419>
   0x0000000000030116 <+5446>:	xor    %edi,%edi
   0x0000000000030118 <+5448>:	mov    $0x5,%edx
   0x000000000003011d <+5453>:	lea    0xae384(%rip),%rsi        # 0xde4a8
   0x0000000000030124 <+5460>:	callq  0x2e130 <dcgettext@plt>
   0x0000000000030129 <+5465>:	mov    %rbp,%rsi
   0x000000000003012c <+5468>:	mov    %rax,%rdi
   0x000000000003012f <+5471>:	xor    %eax,%eax
   0x0000000000030131 <+5473>:	callq  0x54c40 <report_error>
   0x0000000000030136 <+5478>:	jmpq   0x2ec7c <main+172>
   0x000000000003013b <+5483>:	callq  0x2e4e0 <fileno@plt>
   0x0000000000030140 <+5488>:	movl   $0x1,0xf6076(%rip)        # 0x1261c0 <read_from_stdin>
   0x000000000003014a <+5498>:	mov    %eax,0xe8ed0(%rip)        # 0x119020 <default_buffered_input>
   0x0000000000030150 <+5504>:	jmpq   0x2fd92 <main+4546>
   0x0000000000030155 <+5509>:	mov    %rbx,%r14
   0x0000000000030158 <+5512>:	jmpq   0x2fc39 <main+4201>
   0x000000000003015d <+5517>:	mov    %r13,%rdi
   0x0000000000030160 <+5520>:	repnz scas %es:(%rdi),%al
   0x0000000000030162 <+5522>:	not    %rcx
   0x0000000000030165 <+5525>:	mov    %rcx,%rdi
   0x0000000000030168 <+5528>:	callq  0x90510 <xmalloc>
   0x000000000003016d <+5533>:	mov    %r13,%rsi
   0x0000000000030170 <+5536>:	mov    %rax,%rdi
   0x0000000000030173 <+5539>:	callq  0x2df30 <strcpy@plt>
   0x0000000000030178 <+5544>:	jmpq   0x2fbe4 <main+4116>
   0x000000000003017d <+5549>:	callq  0x2def0 <__errno_location@plt>
   0x0000000000030182 <+5554>:	cmpl   $0x2,(%rax)
   0x0000000000030185 <+5557>:	mov    %rax,%r14
   0x0000000000030188 <+5560>:	je     0x3039a <main+6090>
   0x000000000003018e <+5566>:	mov    (%r14),%ebx
   0x0000000000030191 <+5569>:	mov    %rbp,%rdi
   0x0000000000030194 <+5572>:	callq  0x54d60 <file_error>
   0x0000000000030199 <+5577>:	callq  0x5ef70 <end_job_control>
   0x000000000003019e <+5582>:	xor    %edi,%edi
   0x00000000000301a0 <+5584>:	cmp    $0x2,%ebx
   0x00000000000301a3 <+5587>:	sete   %dil
   0x00000000000301a7 <+5591>:	add    $0x7e,%edi
   0x00000000000301aa <+5594>:	callq  0x2e9c0 <exit@plt>
   0x00000000000301af <+5599>:	mov    %rbx,%r13
   0x00000000000301b2 <+5602>:	jmpq   0x2fc7d <main+4269>
   0x00000000000301b7 <+5607>:	lea    0xadf77(%rip),%rsi        # 0xde135
   0x00000000000301be <+5614>:	mov    %rbp,%rdi
   0x00000000000301c1 <+5617>:	callq  0x2e3d0 <strcmp@plt>
   0x00000000000301c6 <+5622>:	test   %eax,%eax
   0x00000000000301c8 <+5624>:	sete   %al
   0x00000000000301cb <+5627>:	movzbl %al,%eax
   0x00000000000301ce <+5630>:	or     %eax,%ebx
   0x00000000000301d0 <+5632>:	mov    %ebx,0xf14ce(%rip)        # 0x1216a4 <no_line_editing>
   0x00000000000301d6 <+5638>:	jmpq   0x30037 <main+5223>
   0x00000000000301db <+5643>:	test   %r13,%r13
   0x00000000000301de <+5646>:	je     0x30205 <main+5685>
   0x00000000000301e0 <+5648>:	lea    0xadf41(%rip),%rsi        # 0xde128
   0x00000000000301e7 <+5655>:	mov    %r13,%rdi
   0x00000000000301ea <+5658>:	mov    $0x1,%r12d
   0x00000000000301f0 <+5664>:	callq  0x2eb00 <strstr@plt>
   0x00000000000301f5 <+5669>:	test   %rax,%rax
   0x00000000000301f8 <+5672>:	jne    0x30027 <main+5207>
   0x00000000000301fe <+5678>:	cmpb   $0x74,0x0(%r13)
   0x0000000000030203 <+5683>:	je     0x3022c <main+5724>
   0x0000000000030205 <+5685>:	cmpb   $0x65,0x0(%rbp)
   0x0000000000030209 <+5689>:	mov    0xf1495(%rip),%ebx        # 0x1216a4 <no_line_editing>
   0x000000000003020f <+5695>:	je     0x3026f <main+5791>
   0x0000000000030211 <+5697>:	mov    %ebx,0xf148d(%rip)        # 0x1216a4 <no_line_editing>
   0x0000000000030217 <+5703>:	cmpb   $0x65,0x0(%rbp)
   0x000000000003021b <+5707>:	je     0x30248 <main+5752>
   0x000000000003021d <+5709>:	movl   $0x0,0xf5fb5(%rip)        # 0x1261dc <running_under_emacs>
   0x0000000000030227 <+5719>:	jmpq   0x2f55c <main+2444>
   0x000000000003022c <+5724>:	lea    0xc3738(%rip),%rsi        # 0xf396b
   0x0000000000030233 <+5731>:	mov    %r13,%rdi
   0x0000000000030236 <+5734>:	callq  0x2e3d0 <strcmp@plt>
   0x000000000003023b <+5739>:	mov    %eax,%r12d
   0x000000000003023e <+5742>:	test   %eax,%eax
   0x0000000000030240 <+5744>:	je     0x30027 <main+5207>
   0x0000000000030246 <+5750>:	jmp    0x30205 <main+5685>
   0x0000000000030248 <+5752>:	mov    $0x5,%edx
   0x000000000003024d <+5757>:	lea    0xadee1(%rip),%rsi        # 0xde135
   0x0000000000030254 <+5764>:	mov    %rbp,%rdi
   0x0000000000030257 <+5767>:	callq  0x2df10 <strncmp@plt>
   0x000000000003025c <+5772>:	test   %eax,%eax
   0x000000000003025e <+5774>:	jne    0x3021d <main+5709>
   0x0000000000030260 <+5776>:	movl   $0x1,0xf5f72(%rip)        # 0x1261dc <running_under_emacs>
   0x000000000003026a <+5786>:	jmpq   0x3007e <main+5294>
   0x000000000003026f <+5791>:	lea    0xadebf(%rip),%rsi        # 0xde135
   0x0000000000030276 <+5798>:	mov    %rbp,%rdi
   0x0000000000030279 <+5801>:	callq  0x2e3d0 <strcmp@plt>
   0x000000000003027e <+5806>:	test   %eax,%eax
   0x0000000000030280 <+5808>:	sete   %al
   0x0000000000030283 <+5811>:	movzbl %al,%eax
   0x0000000000030286 <+5814>:	or     %eax,%ebx
   0x0000000000030288 <+5816>:	jmp    0x30211 <main+5697>
   0x000000000003028a <+5818>:	xor    %esi,%esi
   0x000000000003028c <+5820>:	mov    %r12d,%edi
   0x000000000003028f <+5823>:	callq  0x2e1d0 <dup2@plt>
   0x0000000000030294 <+5828>:	mov    %r12d,%edi
   0x0000000000030297 <+5831>:	callq  0x2dde0 <close@plt>
   0x000000000003029c <+5836>:	movl   $0x0,0xe8d7a(%rip)        # 0x119020 <default_buffered_input>
   0x00000000000302a6 <+5846>:	jmpq   0x2fd80 <main+4528>
   0x00000000000302ab <+5851>:	mov    $0x1,%esi
   0x00000000000302b0 <+5856>:	lea    0xadea9(%rip),%rdi        # 0xde160
   0x00000000000302b7 <+5863>:	callq  0x96690 <maybe_execute_file>
   0x00000000000302bc <+5868>:	mov    0xe8da5(%rip),%rdi        # 0x119068
   0x00000000000302c3 <+5875>:	mov    $0x1,%esi
   0x00000000000302c8 <+5880>:	callq  0x96690 <maybe_execute_file>
   0x00000000000302cd <+5885>:	jmpq   0x2f932 <main+3426>
   0x00000000000302d2 <+5890>:	lea    0xade7b(%rip),%rdi        # 0xde154
   0x00000000000302d9 <+5897>:	callq  0x4dfa0 <find_variable>
   0x00000000000302de <+5902>:	test   %rax,%rax
   0x00000000000302e1 <+5905>:	jne    0x2f9f6 <main+3622>
   0x00000000000302e7 <+5911>:	mov    0xf1342(%rip),%rdi        # 0x121630 <stdin>
   0x00000000000302ee <+5918>:	callq  0x2e4e0 <fileno@plt>
   0x00000000000302f3 <+5923>:	mov    %eax,%edi
   0x00000000000302f5 <+5925>:	callq  0xb0c30 <isnetconn>
   0x00000000000302fa <+5930>:	test   %eax,%eax
   0x00000000000302fc <+5932>:	jne    0x2f9f6 <main+3622>
   0x0000000000030302 <+5938>:	jmpq   0x2fa03 <main+3635>
   0x0000000000030307 <+5943>:	lea    0xade22(%rip),%rsi        # 0xde130
   0x000000000003030e <+5950>:	mov    %rbp,%rdi
   0x0000000000030311 <+5953>:	callq  0x2e3d0 <strcmp@plt>
   0x0000000000030316 <+5958>:	test   %eax,%eax
   0x0000000000030318 <+5960>:	jne    0x30041 <main+5233>
   0x000000000003031e <+5966>:	or     $0x1,%ebx
   0x0000000000030321 <+5969>:	mov    %ebx,0xf137d(%rip)        # 0x1216a4 <no_line_editing>
   0x0000000000030327 <+5975>:	jmpq   0x30047 <main+5239>
   0x000000000003032c <+5980>:	callq  0x2def0 <__errno_location@plt>
   0x0000000000030331 <+5985>:	mov    %rbp,%rdi
   0x0000000000030334 <+5988>:	movl   $0x15,(%rax)
   0x000000000003033a <+5994>:	callq  0x54d60 <file_error>
   0x000000000003033f <+5999>:	callq  0x5ef70 <end_job_control>
   0x0000000000030344 <+6004>:	mov    $0x7e,%edi
   0x0000000000030349 <+6009>:	callq  0x2e9c0 <exit@plt>
   0x000000000003034e <+6014>:	callq  0x2def0 <__errno_location@plt>
   0x0000000000030353 <+6019>:	lea    0x40(%rsp),%rdx
   0x0000000000030358 <+6024>:	mov    %r12d,%esi
   0x000000000003035b <+6027>:	mov    $0x1,%edi
   0x0000000000030360 <+6032>:	mov    (%rax),%r13d
   0x0000000000030363 <+6035>:	mov    %rax,%rbx
   0x0000000000030366 <+6038>:	callq  0x2e600 <__fxstat@plt>
   0x000000000003036b <+6043>:	test   %eax,%eax
   0x000000000003036d <+6045>:	jne    0x30383 <main+6067>
   0x000000000003036f <+6047>:	mov    0x58(%rsp),%eax
   0x0000000000030373 <+6051>:	and    $0xf000,%eax
   0x0000000000030378 <+6056>:	cmp    $0x4000,%eax
   0x000000000003037d <+6061>:	je     0x3040e <main+6206>
   0x0000000000030383 <+6067>:	mov    %r13d,(%rbx)
   0x0000000000030386 <+6070>:	mov    %rbp,%rdi
   0x0000000000030389 <+6073>:	callq  0x54d60 <file_error>
   0x000000000003038e <+6078>:	jmp    0x3033f <main+5999>
   0x0000000000030390 <+6080>:	callq  0x81300 <load_history>
   0x0000000000030395 <+6085>:	jmpq   0x2ffbf <main+5103>
   0x000000000003039a <+6090>:	mov    %rbp,%rdi
   0x000000000003039d <+6093>:	callq  0x3f450 <absolute_program>
   0x00000000000303a2 <+6098>:	mov    (%r14),%r12d
   0x00000000000303a5 <+6101>:	test   %eax,%eax
   0x00000000000303a7 <+6103>:	jne    0x3018e <main+5566>
   0x00000000000303ad <+6109>:	mov    %r13,%rdi
   0x00000000000303b0 <+6112>:	callq  0x8ae80 <find_path_file>
   0x00000000000303b5 <+6117>:	mov    %rax,%r15
   0x00000000000303b8 <+6120>:	test   %rax,%rax
   0x00000000000303bb <+6123>:	je     0x30421 <main+6225>
   0x00000000000303bd <+6125>:	mov    %rbp,%rdi
   0x00000000000303c0 <+6128>:	mov    %r15,%rbp
   0x00000000000303c3 <+6131>:	callq  0x2de50 <free@plt>
   0x00000000000303c8 <+6136>:	xor    %esi,%esi
   0x00000000000303ca <+6138>:	mov    %r15,%rdi
   0x00000000000303cd <+6141>:	xor    %eax,%eax
   0x00000000000303cf <+6143>:	callq  0x2e870 <open@plt>
   0x00000000000303d4 <+6148>:	mov    %eax,%r12d
   0x00000000000303d7 <+6151>:	test   %eax,%eax
   0x00000000000303d9 <+6153>:	jns    0x2fba7 <main+4055>
   0x00000000000303df <+6159>:	jmpq   0x3018e <main+5566>
   0x00000000000303e4 <+6164>:	mov    $0x5,%edx
   0x00000000000303e9 <+6169>:	xor    %edi,%edi
   0x00000000000303eb <+6171>:	lea    0xae0d6(%rip),%rsi        # 0xde4c8
   0x00000000000303f2 <+6178>:	callq  0x2e130 <dcgettext@plt>
   0x00000000000303f7 <+6183>:	mov    %rbp,%rsi
   0x00000000000303fa <+6186>:	mov    %rax,%rdi
   0x00000000000303fd <+6189>:	xor    %eax,%eax
   0x00000000000303ff <+6191>:	callq  0x54e70 <internal_error>
   0x0000000000030404 <+6196>:	callq  0x5ef70 <end_job_control>
   0x0000000000030409 <+6201>:	jmpq   0x30344 <main+6004>
   0x000000000003040e <+6206>:	movl   $0x15,(%rbx)
   0x0000000000030414 <+6212>:	mov    %rbp,%rdi
   0x0000000000030417 <+6215>:	callq  0x54d60 <file_error>
   0x000000000003041c <+6220>:	jmpq   0x3033f <main+5999>
   0x0000000000030421 <+6225>:	mov    %r12d,(%r14)
   0x0000000000030424 <+6228>:	jmpq   0x3018e <main+5566>
End of assembler dump.
