
00000000000002cc <core_bench_list>:
core_bench_list():
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:160
        - Single remove/reinsert
        * At the end of this function, the list is back to original state
*/
ee_u16
core_bench_list(core_results *res, ee_s16 finder_idx)
{
     2cc:	7131                	c.addi16sp	sp,-192
     2ce:	fd06                	c.sdsp	ra,184(sp)
     2d0:	f922                	c.sdsp	s0,176(sp)
     2d2:	f526                	c.sdsp	s1,168(sp)
     2d4:	f14a                	c.sdsp	s2,160(sp)
     2d6:	ed4e                	c.sdsp	s3,152(sp)
     2d8:	e952                	c.sdsp	s4,144(sp)
     2da:	e556                	c.sdsp	s5,136(sp)
     2dc:	e15a                	c.sdsp	s6,128(sp)
     2de:	fcde                	c.sdsp	s7,120(sp)
     2e0:	f8e2                	c.sdsp	s8,112(sp)
     2e2:	f4e6                	c.sdsp	s9,104(sp)
     2e4:	f0ea                	c.sdsp	s10,96(sp)
     2e6:	ecee                	c.sdsp	s11,88(sp)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:164
    ee_u16     retval = 0;
    ee_u16     found = 0, missed = 0;
    list_head *list     = res->list;
    ee_s16     find_num = res->seed3;
     2e8:	00451883          	lh	a7,4(a0)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:163
    list_head *list     = res->list;
     2ec:	03853c03          	ld	s8,56(a0)
     2f0:	89aa                	c.mv	s3,a0
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:173
    ee_s16     i;

    info.idx = finder_idx;
    /* find <find_num> values in the list, and change the list each time
     * (reverse and cache if value found) */
    for (i = 0; i < find_num; i++)
     2f2:	1d105f63          	blez	a7,4d0 <core_bench_list+0x204>
     2f6:	4281                	c.li	t0,0
     2f8:	4301                	c.li	t1,0
     2fa:	4e81                	c.li	t4,0
     2fc:	4e01                	c.li	t3,0
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:173 (discriminator 2)
     2fe:	fff88813          	addi	a6,a7,-1
     302:	83ae                	c.mv	t2,a1
     304:	0340006f          	j	338 <core_bench_list+0x6c>
     308:	00d00c33          	add	s8,zero,a3
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:181
        this_find   = core_list_find(list, &info);
        list        = core_list_reverse(list);
        if (this_find == NULL)
        {
            missed++;
            retval += (list->next->info->data16 >> 8) & 1;
     30c:	000c3503          	ld	a0,0(s8)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:180
            missed++;
     310:	0e05                	c.addi	t3,1
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:181
            retval += (list->next->info->data16 >> 8) & 1;
     312:	6508                	c.ld	a0,8(a0)
     314:	00154503          	lbu	a0,1(a0)
     318:	00157493          	andi	s1,a0,1
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:197
                this_find->next = finder->next;
                finder->next    = list->next;
                list->next      = finder;
            }
        }
        if (info.idx >= 0)
     31c:	fff3c513          	not	a0,t2
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:173 (discriminator 4)
    for (i = 0; i < find_num; i++)
     320:	00128613          	addi	a2,t0,1
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:197
        if (info.idx >= 0)
     324:	3cf5255b          	bfoz	a0,a0,15,15
     328:	1093035b          	lea.b.ze	t1,t1,s1
     32c:	00a383b3          	add	t2,t2,a0
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:173 (discriminator 4)
    for (i = 0; i < find_num; i++)
     330:	3c0632db          	bfos	t0,a2,15,0
     334:	1912d663          	bge	t0,a7,4c0 <core_bench_list+0x1f4>
core_list_find():
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:173 (discriminator 4)
     338:	001c3793          	seqz	a5,s8
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:437
        Found item, or NULL if not found.
*/
list_head *
core_list_find(list_head *list, list_data *info)
{
    if (info->idx >= 0)
     33c:	3c03b55b          	bfos	a0,t2,15,0
     340:	08054063          	bltz	a0,3c0 <core_bench_list+0xf4>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:439
    {
        while (list && (list->info->idx != info->idx))
     344:	f7e1                	c.bnez	a5,30c <core_bench_list+0x40>
     346:	8762                	c.mv	a4,s8
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:439 (discriminator 2)
     348:	6708                	c.ld	a0,8(a4)
     34a:	3c03a4db          	bfoz	s1,t2,15,0
     34e:	00255503          	lhu	a0,2(a0)
     352:	0e950363          	beq	a0,s1,438 <core_bench_list+0x16c>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:440
            list = list->next;
     356:	6318                	c.ld	a4,0(a4)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:439 (discriminator 4)
        while (list && (list->info->idx != info->idx))
     358:	c365                	c.beqz	a4,438 <core_bench_list+0x16c>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:439 (discriminator 6)
     35a:	6708                	c.ld	a0,8(a4)
     35c:	00255503          	lhu	a0,2(a0)
     360:	0c950c63          	beq	a0,s1,438 <core_bench_list+0x16c>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:440 (discriminator 2)
            list = list->next;
     364:	6318                	c.ld	a4,0(a4)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:439 (discriminator 8)
        while (list && (list->info->idx != info->idx))
     366:	cb69                	c.beqz	a4,438 <core_bench_list+0x16c>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:439 (discriminator 10)
     368:	6708                	c.ld	a0,8(a4)
     36a:	00255503          	lhu	a0,2(a0)
     36e:	0c950563          	beq	a0,s1,438 <core_bench_list+0x16c>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:440 (discriminator 4)
            list = list->next;
     372:	6318                	c.ld	a4,0(a4)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:439 (discriminator 12)
        while (list && (list->info->idx != info->idx))
     374:	c371                	c.beqz	a4,438 <core_bench_list+0x16c>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:439 (discriminator 14)
     376:	6708                	c.ld	a0,8(a4)
     378:	00255503          	lhu	a0,2(a0)
     37c:	0a950e63          	beq	a0,s1,438 <core_bench_list+0x16c>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:440 (discriminator 6)
            list = list->next;
     380:	6318                	c.ld	a4,0(a4)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:439 (discriminator 16)
        while (list && (list->info->idx != info->idx))
     382:	cb5d                	c.beqz	a4,438 <core_bench_list+0x16c>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:439 (discriminator 18)
     384:	6708                	c.ld	a0,8(a4)
     386:	00255503          	lhu	a0,2(a0)
     38a:	0a950763          	beq	a0,s1,438 <core_bench_list+0x16c>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:440 (discriminator 8)
            list = list->next;
     38e:	6318                	c.ld	a4,0(a4)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:439 (discriminator 20)
        while (list && (list->info->idx != info->idx))
     390:	c745                	c.beqz	a4,438 <core_bench_list+0x16c>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:439 (discriminator 22)
     392:	6708                	c.ld	a0,8(a4)
     394:	00255503          	lhu	a0,2(a0)
     398:	0a950063          	beq	a0,s1,438 <core_bench_list+0x16c>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:440 (discriminator 10)
            list = list->next;
     39c:	6318                	c.ld	a4,0(a4)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:439 (discriminator 24)
        while (list && (list->info->idx != info->idx))
     39e:	cf49                	c.beqz	a4,438 <core_bench_list+0x16c>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:439 (discriminator 26)
     3a0:	6708                	c.ld	a0,8(a4)
     3a2:	00255503          	lhu	a0,2(a0)
     3a6:	08950963          	beq	a0,s1,438 <core_bench_list+0x16c>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:440 (discriminator 12)
            list = list->next;
     3aa:	6318                	c.ld	a4,0(a4)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:439 (discriminator 28)
        while (list && (list->info->idx != info->idx))
     3ac:	c751                	c.beqz	a4,438 <core_bench_list+0x16c>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:439 (discriminator 30)
     3ae:	6708                	c.ld	a0,8(a4)
     3b0:	00255503          	lhu	a0,2(a0)
     3b4:	08950263          	beq	a0,s1,438 <core_bench_list+0x16c>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:440 (discriminator 14)
            list = list->next;
     3b8:	6318                	c.ld	a4,0(a4)
     3ba:	f759                	c.bnez	a4,348 <core_bench_list+0x7c>
     3bc:	07c0006f          	j	438 <core_bench_list+0x16c>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:445
        return list;
    }
    else
    {
        while (list && ((list->info->data16 & 0xff) != info->data16))
     3c0:	f7b1                	c.bnez	a5,30c <core_bench_list+0x40>
     3c2:	0ff2f493          	andi	s1,t0,255
     3c6:	8762                	c.mv	a4,s8
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:445 (discriminator 2)
     3c8:	6708                	c.ld	a0,8(a4)
     3ca:	00054503          	lbu	a0,0(a0)
     3ce:	06950563          	beq	a0,s1,438 <core_bench_list+0x16c>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:446
            list = list->next;
     3d2:	6318                	c.ld	a4,0(a4)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:445 (discriminator 4)
        while (list && ((list->info->data16 & 0xff) != info->data16))
     3d4:	c335                	c.beqz	a4,438 <core_bench_list+0x16c>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:445 (discriminator 6)
     3d6:	6708                	c.ld	a0,8(a4)
     3d8:	00054503          	lbu	a0,0(a0)
     3dc:	04950e63          	beq	a0,s1,438 <core_bench_list+0x16c>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:446 (discriminator 2)
            list = list->next;
     3e0:	6318                	c.ld	a4,0(a4)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:445 (discriminator 8)
        while (list && ((list->info->data16 & 0xff) != info->data16))
     3e2:	cb39                	c.beqz	a4,438 <core_bench_list+0x16c>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:445 (discriminator 10)
     3e4:	6708                	c.ld	a0,8(a4)
     3e6:	00054503          	lbu	a0,0(a0)
     3ea:	04950763          	beq	a0,s1,438 <core_bench_list+0x16c>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:446 (discriminator 4)
            list = list->next;
     3ee:	6318                	c.ld	a4,0(a4)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:445 (discriminator 12)
        while (list && ((list->info->data16 & 0xff) != info->data16))
     3f0:	c721                	c.beqz	a4,438 <core_bench_list+0x16c>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:445 (discriminator 14)
     3f2:	6708                	c.ld	a0,8(a4)
     3f4:	00054503          	lbu	a0,0(a0)
     3f8:	04950063          	beq	a0,s1,438 <core_bench_list+0x16c>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:446 (discriminator 6)
            list = list->next;
     3fc:	6318                	c.ld	a4,0(a4)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:445 (discriminator 16)
        while (list && ((list->info->data16 & 0xff) != info->data16))
     3fe:	cf0d                	c.beqz	a4,438 <core_bench_list+0x16c>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:445 (discriminator 18)
     400:	6708                	c.ld	a0,8(a4)
     402:	00054503          	lbu	a0,0(a0)
     406:	02950963          	beq	a0,s1,438 <core_bench_list+0x16c>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:446 (discriminator 8)
            list = list->next;
     40a:	6318                	c.ld	a4,0(a4)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:445 (discriminator 20)
        while (list && ((list->info->data16 & 0xff) != info->data16))
     40c:	c715                	c.beqz	a4,438 <core_bench_list+0x16c>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:445 (discriminator 22)
     40e:	6708                	c.ld	a0,8(a4)
     410:	00054503          	lbu	a0,0(a0)
     414:	02950263          	beq	a0,s1,438 <core_bench_list+0x16c>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:446 (discriminator 10)
            list = list->next;
     418:	6318                	c.ld	a4,0(a4)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:445 (discriminator 24)
        while (list && ((list->info->data16 & 0xff) != info->data16))
     41a:	cf19                	c.beqz	a4,438 <core_bench_list+0x16c>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:445 (discriminator 26)
     41c:	6708                	c.ld	a0,8(a4)
     41e:	00054503          	lbu	a0,0(a0)
     422:	00950b63          	beq	a0,s1,438 <core_bench_list+0x16c>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:446 (discriminator 12)
            list = list->next;
     426:	6318                	c.ld	a4,0(a4)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:445 (discriminator 28)
        while (list && ((list->info->data16 & 0xff) != info->data16))
     428:	cb01                	c.beqz	a4,438 <core_bench_list+0x16c>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:445 (discriminator 30)
     42a:	6708                	c.ld	a0,8(a4)
     42c:	00054503          	lbu	a0,0(a0)
     430:	00950463          	beq	a0,s1,438 <core_bench_list+0x16c>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:446 (discriminator 14)
            list = list->next;
     434:	6318                	c.ld	a4,0(a4)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:445 (discriminator 32)
        while (list && ((list->info->data16 & 0xff) != info->data16))
     436:	fb49                	c.bnez	a4,3c8 <core_bench_list+0xfc>
core_list_reverse():
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:468

list_head *
core_list_reverse(list_head *list)
{
    list_head *next = NULL, *tmp;
    while (list)
     438:	e3a1                	c.bnez	a5,478 <core_bench_list+0x1ac>
     43a:	4681                	c.li	a3,0
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:470
    {
        tmp        = list->next;
     43c:	000c3783          	ld	a5,0(s8)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:471
        list->next = next;
     440:	00dc3023          	sd	a3,0(s8)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:468 (discriminator 2)
    while (list)
     444:	c3b5                	c.beqz	a5,4a8 <core_bench_list+0x1dc>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:470 (discriminator 2)
        tmp        = list->next;
     446:	6394                	c.ld	a3,0(a5)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:471 (discriminator 2)
        list->next = next;
     448:	0187b023          	sd	s8,0(a5)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:468 (discriminator 4)
    while (list)
     44c:	c2a5                	c.beqz	a3,4ac <core_bench_list+0x1e0>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:470 (discriminator 4)
        tmp        = list->next;
     44e:	6280                	c.ld	s0,0(a3)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:471 (discriminator 4)
        list->next = next;
     450:	e29c                	c.sd	a5,0(a3)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:468 (discriminator 6)
    while (list)
     452:	c40d                	c.beqz	s0,47c <core_bench_list+0x1b0>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:470 (discriminator 6)
        tmp        = list->next;
     454:	601c                	c.ld	a5,0(s0)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:471 (discriminator 6)
        list->next = next;
     456:	e014                	c.sd	a3,0(s0)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:468 (discriminator 8)
    while (list)
     458:	cfa1                	c.beqz	a5,4b0 <core_bench_list+0x1e4>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:470 (discriminator 8)
        tmp        = list->next;
     45a:	6390                	c.ld	a2,0(a5)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:471 (discriminator 8)
        list->next = next;
     45c:	e380                	c.sd	s0,0(a5)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:468 (discriminator 10)
    while (list)
     45e:	ca39                	c.beqz	a2,4b4 <core_bench_list+0x1e8>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:470 (discriminator 10)
        tmp        = list->next;
     460:	6208                	c.ld	a0,0(a2)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:471 (discriminator 10)
        list->next = next;
     462:	e21c                	c.sd	a5,0(a2)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:468 (discriminator 12)
    while (list)
     464:	c931                	c.beqz	a0,4b8 <core_bench_list+0x1ec>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:470 (discriminator 12)
        tmp        = list->next;
     466:	6114                	c.ld	a3,0(a0)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:471 (discriminator 12)
        list->next = next;
     468:	e110                	c.sd	a2,0(a0)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:468 (discriminator 14)
    while (list)
     46a:	caa9                	c.beqz	a3,4bc <core_bench_list+0x1f0>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:470 (discriminator 14)
        tmp        = list->next;
     46c:	0006bc03          	ld	s8,0(a3)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:471 (discriminator 14)
        list->next = next;
     470:	e288                	c.sd	a0,0(a3)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:468 (discriminator 16)
    while (list)
     472:	fc0c15e3          	bnez	s8,43c <core_bench_list+0x170>
     476:	a019                	c.j	47c <core_bench_list+0x1b0>
     478:	00000693          	li	a3,0
core_bench_list():
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:178
        if (this_find == NULL)
     47c:	e80706e3          	beqz	a4,308 <core_bench_list+0x3c>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:186
            if (this_find->info->data16 & 0x1) /* use found value */
     480:	6708                	c.ld	a0,8(a4)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:185
            found++;
     482:	0e85                	c.addi	t4,1
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:186
            if (this_find->info->data16 & 0x1) /* use found value */
     484:	00051503          	lh	a0,0(a0)
     488:	00955613          	srli	a2,a0,0x9
     48c:	8e69                	c.and	a2,a0
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:189
            if (this_find->next != NULL)
     48e:	6308                	c.ld	a0,0(a4)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:186
            if (this_find->info->data16 & 0x1) /* use found value */
     490:	00167493          	andi	s1,a2,1
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:189
            if (this_find->next != NULL)
     494:	c901                	c.beqz	a0,4a4 <core_bench_list+0x1d8>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:192
                this_find->next = finder->next;
     496:	6110                	c.ld	a2,0(a0)
     498:	8c36                	c.mv	s8,a3
     49a:	e310                	c.sd	a2,0(a4)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:193
                finder->next    = list->next;
     49c:	6290                	c.ld	a2,0(a3)
     49e:	e110                	c.sd	a2,0(a0)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:194
                list->next      = finder;
     4a0:	e288                	c.sd	a0,0(a3)
     4a2:	bdad                	c.j	31c <core_bench_list+0x50>
     4a4:	8c36                	c.mv	s8,a3
     4a6:	bd9d                	c.j	31c <core_bench_list+0x50>
core_list_reverse():
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:194
     4a8:	86e2                	c.mv	a3,s8
     4aa:	bfc9                	c.j	47c <core_bench_list+0x1b0>
     4ac:	86be                	c.mv	a3,a5
     4ae:	b7f9                	c.j	47c <core_bench_list+0x1b0>
     4b0:	86a2                	c.mv	a3,s0
     4b2:	b7e9                	c.j	47c <core_bench_list+0x1b0>
     4b4:	86be                	c.mv	a3,a5
     4b6:	b7d9                	c.j	47c <core_bench_list+0x1b0>
     4b8:	86b2                	c.mv	a3,a2
     4ba:	b7c9                	c.j	47c <core_bench_list+0x1b0>
     4bc:	86aa                	c.mv	a3,a0
     4be:	bf7d                	c.j	47c <core_bench_list+0x1b0>
core_bench_list():
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:173 (discriminator 6)
    for (i = 0; i < find_num; i++)
     4c0:	0ff87513          	andi	a0,a6,255
     4c4:	e42a                	c.sdsp	a0,8(sp)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:205
    if (finder_idx > 0)
     4c6:	00b04b63          	bgtz	a1,4dc <core_bench_list+0x210>
     4ca:	3430006f          	j	100c <EDLM_SIZE+0x5c4>
     4ce:	0001                	c.nop
     4d0:	4e01                	c.li	t3,0
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:162
    ee_u16     found = 0, missed = 0;
     4d2:	4e81                	c.li	t4,0
     4d4:	4301                	c.li	t1,0
     4d6:	83ae                	c.mv	t2,a1
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:205
    if (finder_idx > 0)
     4d8:	32b05ae3          	blez	a1,100c <EDLM_SIZE+0x5c4>
     4dc:	04098513          	addi	a0,s3,64
     4e0:	4b05                	c.li	s6,1
     4e2:	e8aa                	c.sdsp	a0,80(sp)
     4e4:	f41a                	c.sdsp	t1,40(sp)
     4e6:	f01e                	c.sdsp	t2,32(sp)
     4e8:	ec72                	c.sdsp	t3,24(sp)
     4ea:	e876                	c.sdsp	t4,16(sp)
     4ec:	01c0006f          	j	508 <core_bench_list+0x23c>
core_list_mergesort():
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:586 (discriminator 2)
        }

        tail->next = NULL;

        /* If we have done only one merge, we're finished. */
        if (nmerges <= 1) /* allow for nmerges==0, the empty list case */
     4f0:	7542                	c.ldsp	a0,48(sp)
     4f2:	7322                	c.ldsp	t1,40(sp)
     4f4:	7382                	c.ldsp	t2,32(sp)
     4f6:	6e62                	c.ldsp	t3,24(sp)
     4f8:	6ec2                	c.ldsp	t4,16(sp)
     4fa:	2501                	c.addiw	a0,0
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:590
            return list;

        /* Otherwise repeat, merging lists twice the size */
        insize *= 2;
     4fc:	001b1b1b          	slliw	s6,s6,0x1
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:583 (discriminator 2)
        tail->next = NULL;
     500:	000a3023          	sd	zero,0(s4)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:586 (discriminator 2)
        if (nmerges <= 1) /* allow for nmerges==0, the empty list case */
     504:	300504e3          	beqz	a0,100c <EDLM_SIZE+0x5c4>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:515
        while (p)
     508:	300c00e3          	beqz	s8,1008 <EDLM_SIZE+0x5c0>
     50c:	000b061b          	sext.w	a2,s6
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:515 (discriminator 2)
     510:	2ec05ae3          	blez	a2,1004 <EDLM_SIZE+0x5bc>
     514:	8d62                	c.mv	s10,s8
     516:	4581                	c.li	a1,0
     518:	4a01                	c.li	s4,0
     51a:	4c01                	c.li	s8,0
     51c:	fc32                	c.sdsp	a2,56(sp)
     51e:	e0da                	c.sdsp	s6,64(sp)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:515
     520:	0140006f          	j	534 <core_bench_list+0x268>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:524 (discriminator 4)
                q = q->next;
     524:	8922                	c.mv	s2,s0
     526:	8a5e                	c.mv	s4,s7
     528:	6b06                	c.ldsp	s6,64(sp)
     52a:	7662                	c.ldsp	a2,56(sp)
     52c:	65a6                	c.ldsp	a1,72(sp)
     52e:	8d4a                	c.mv	s10,s2
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:515 (discriminator 4)
        while (p)
     530:	fc0900e3          	beqz	s2,4f0 <core_bench_list+0x224>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:517
            nmerges++; /* there exists a merge to be done */
     534:	0015869b          	addiw	a3,a1,1
     538:	4501                	c.li	a0,0
     53a:	872e                	c.mv	a4,a1
     53c:	8bd2                	c.mv	s7,s4
     53e:	846a                	c.mv	s0,s10
     540:	e4b6                	c.sdsp	a3,72(sp)
     542:	f82e                	c.sdsp	a1,48(sp)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:521 (discriminator 4)
            for (i = 0; i < insize; i++)
     544:	00156593          	ori	a1,a0,1
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:524
                q = q->next;
     548:	6000                	c.ld	s0,0(s0)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:521 (discriminator 4)
            for (i = 0; i < insize; i++)
     54a:	00058c9b          	sext.w	s9,a1
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:525
                if (!q)
     54e:	c83d                	c.beqz	s0,5c4 <core_bench_list+0x2f8>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:521 (discriminator 2)
            for (i = 0; i < insize; i++)
     550:	06ccdc63          	bge	s9,a2,5c8 <core_bench_list+0x2fc>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:521 (discriminator 6)
     554:	00256593          	ori	a1,a0,2
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:524 (discriminator 6)
                q = q->next;
     558:	6000                	c.ld	s0,0(s0)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:521 (discriminator 6)
            for (i = 0; i < insize; i++)
     55a:	00058c9b          	sext.w	s9,a1
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:525 (discriminator 2)
                if (!q)
     55e:	c449                	c.beqz	s0,5e8 <core_bench_list+0x31c>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:521 (discriminator 8)
            for (i = 0; i < insize; i++)
     560:	06ccd663          	bge	s9,a2,5cc <core_bench_list+0x300>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:521 (discriminator 10)
     564:	00356593          	ori	a1,a0,3
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:524 (discriminator 8)
                q = q->next;
     568:	6000                	c.ld	s0,0(s0)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:521 (discriminator 10)
            for (i = 0; i < insize; i++)
     56a:	00058c9b          	sext.w	s9,a1
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:525 (discriminator 4)
                if (!q)
     56e:	cc2d                	c.beqz	s0,5e8 <core_bench_list+0x31c>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:521 (discriminator 12)
            for (i = 0; i < insize; i++)
     570:	06ccd063          	bge	s9,a2,5d0 <core_bench_list+0x304>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:521 (discriminator 14)
     574:	00456593          	ori	a1,a0,4
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:524 (discriminator 10)
                q = q->next;
     578:	6000                	c.ld	s0,0(s0)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:521 (discriminator 14)
            for (i = 0; i < insize; i++)
     57a:	00058c9b          	sext.w	s9,a1
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:525 (discriminator 6)
                if (!q)
     57e:	c42d                	c.beqz	s0,5e8 <core_bench_list+0x31c>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:521 (discriminator 16)
            for (i = 0; i < insize; i++)
     580:	04ccda63          	bge	s9,a2,5d4 <core_bench_list+0x308>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:521 (discriminator 18)
     584:	00556593          	ori	a1,a0,5
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:524 (discriminator 12)
                q = q->next;
     588:	6000                	c.ld	s0,0(s0)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:521 (discriminator 18)
            for (i = 0; i < insize; i++)
     58a:	00058c9b          	sext.w	s9,a1
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:525 (discriminator 8)
                if (!q)
     58e:	cc29                	c.beqz	s0,5e8 <core_bench_list+0x31c>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:521 (discriminator 20)
            for (i = 0; i < insize; i++)
     590:	04ccd463          	bge	s9,a2,5d8 <core_bench_list+0x30c>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:521 (discriminator 22)
     594:	00656593          	ori	a1,a0,6
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:524 (discriminator 14)
                q = q->next;
     598:	6000                	c.ld	s0,0(s0)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:521 (discriminator 22)
            for (i = 0; i < insize; i++)
     59a:	00058c9b          	sext.w	s9,a1
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:525 (discriminator 10)
                if (!q)
     59e:	c429                	c.beqz	s0,5e8 <core_bench_list+0x31c>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:521 (discriminator 24)
            for (i = 0; i < insize; i++)
     5a0:	02ccde63          	bge	s9,a2,5dc <core_bench_list+0x310>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:521 (discriminator 26)
     5a4:	00756593          	ori	a1,a0,7
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:524 (discriminator 16)
                q = q->next;
     5a8:	6000                	c.ld	s0,0(s0)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:521 (discriminator 26)
            for (i = 0; i < insize; i++)
     5aa:	00058c9b          	sext.w	s9,a1
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:525 (discriminator 12)
                if (!q)
     5ae:	cc0d                	c.beqz	s0,5e8 <core_bench_list+0x31c>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:521 (discriminator 28)
            for (i = 0; i < insize; i++)
     5b0:	02ccd863          	bge	s9,a2,5e0 <core_bench_list+0x314>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:524 (discriminator 18)
                q = q->next;
     5b4:	6000                	c.ld	s0,0(s0)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:521 (discriminator 30)
            for (i = 0; i < insize; i++)
     5b6:	2521                	c.addiw	a0,8
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:525 (discriminator 14)
                if (!q)
     5b8:	c415                	c.beqz	s0,5e4 <core_bench_list+0x318>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:521 (discriminator 32)
            for (i = 0; i < insize; i++)
     5ba:	f8c545e3          	blt	a0,a2,544 <core_bench_list+0x278>
     5be:	8cda                	c.mv	s9,s6
     5c0:	0280006f          	j	5e8 <core_bench_list+0x31c>
     5c4:	0240006f          	j	5e8 <core_bench_list+0x31c>
     5c8:	8cda                	c.mv	s9,s6
     5ca:	a839                	c.j	5e8 <core_bench_list+0x31c>
     5cc:	8cda                	c.mv	s9,s6
     5ce:	a829                	c.j	5e8 <core_bench_list+0x31c>
     5d0:	8cda                	c.mv	s9,s6
     5d2:	a819                	c.j	5e8 <core_bench_list+0x31c>
     5d4:	8cda                	c.mv	s9,s6
     5d6:	a809                	c.j	5e8 <core_bench_list+0x31c>
     5d8:	8cda                	c.mv	s9,s6
     5da:	a039                	c.j	5e8 <core_bench_list+0x31c>
     5dc:	8cda                	c.mv	s9,s6
     5de:	a029                	c.j	5e8 <core_bench_list+0x31c>
     5e0:	8cda                	c.mv	s9,s6
     5e2:	a019                	c.j	5e8 <core_bench_list+0x31c>
     5e4:	00a00cb3          	add	s9,zero,a0
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:533 (discriminator 2)
            while (psize > 0 || (qsize > 0 && q))
     5e8:	000c859b          	sext.w	a1,s9
     5ec:	000b051b          	sext.w	a0,s6
     5f0:	00b04663          	bgtz	a1,5fc <core_bench_list+0x330>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:533 (discriminator 4)
     5f4:	d805                	c.beqz	s0,524 <core_bench_list+0x258>
     5f6:	18a05be3          	blez	a0,f8c <EDLM_SIZE+0x544>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:537
                if (psize == 0)
     5fa:	c1f9                	c.beqz	a1,6c0 <core_bench_list+0x3f4>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:544
                else if (qsize == 0 || !q)
     5fc:	c441                	c.beqz	s0,684 <core_bench_list+0x3b8>
     5fe:	c159                	c.beqz	a0,684 <core_bench_list+0x3b8>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:551
                else if (cmp(p->info, q->info, res) <= 0)
     600:	008d3a83          	ld	s5,8(s10)
     604:	00843903          	ld	s2,8(s0)
calc_func():
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:72
    ee_s16 data = *pdata;
     608:	000ad483          	lhu	s1,0(s5)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:77
    if (optype) /* if cached, use cache */
     60c:	4874f65b          	bbs	s1,7,698 <core_bench_list+0x3cc>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:83
            = ((data >> 3)
     610:	1834a55b          	bfoz	a0,s1,6,3
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:85
        dtype |= dtype << 4; /* replicate the lower 4 bits to get an 8b value */
     614:	00451593          	slli	a1,a0,0x4
     618:	00a5e733          	or	a4,a1,a0
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:86
        switch (flag)
     61c:	0074f513          	andi	a0,s1,7
     620:	0a15585b          	beqc	a0,1,6d0 <core_bench_list+0x404>
     624:	8a26                	c.mv	s4,s1
     626:	e169                	c.bnez	a0,6e8 <core_bench_list+0x41c>
     628:	02200513          	li	a0,34
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:89
                if (dtype < 0x22) /* set min period for bit corruption */
     62c:	00e56463          	bltu	a0,a4,634 <core_bench_list+0x368>
     630:	02200713          	li	a4,34
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:96
                                          res->crc);
     634:	0609d783          	lhu	a5,96(s3)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:93
                                          res->seed1,
     638:	00099603          	lh	a2,0(s3)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:94
                                          res->seed2,
     63c:	00299683          	lh	a3,2(s3)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:92
                                          res->memblock[3],
     640:	0209b583          	ld	a1,32(s3)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:91
                retval = core_bench_state(res->size,
     644:	0289a503          	lw	a0,40(s3)
     648:	2b0050ef          	jal	ra,58f8 <core_bench_state>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:97
                if (res->crcstate == 0)
     64c:	0669d583          	lhu	a1,102(s3)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:91
                retval = core_bench_state(res->size,
     650:	8a2a                	c.mv	s4,a0
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:97
                if (res->crcstate == 0)
     652:	e9d9                	c.bnez	a1,6e8 <core_bench_list+0x41c>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:98
                    res->crcstate = retval;
     654:	07499323          	sh	s4,102(s3)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:109
        res->crc = crcu16(retval, res->crc);
     658:	0609d583          	lhu	a1,96(s3)
     65c:	8552                	c.mv	a0,s4
     65e:	1a6060ef          	jal	ra,6804 <crcu16>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:110
        retval &= 0x007f;
     662:	07fa7a13          	andi	s4,s4,127
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:111
        *pdata = (data & 0xff00) | 0x0080 | retval; /* cache the result */
     666:	f004f593          	andi	a1,s1,-256
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:109
        res->crc = crcu16(retval, res->crc);
     66a:	06a99023          	sh	a0,96(s3)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:111
        *pdata = (data & 0xff00) | 0x0080 | retval; /* cache the result */
     66e:	0145e5b3          	or	a1,a1,s4
     672:	0805e593          	ori	a1,a1,128
     676:	00ba9023          	sh	a1,0(s5)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:72 (discriminator 2)
    ee_s16 data = *pdata;
     67a:	00095483          	lhu	s1,0(s2)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:77 (discriminator 2)
    if (optype) /* if cached, use cache */
     67e:	0874fb5b          	bbc	s1,7,714 <core_bench_list+0x448>
     682:	a00d                	c.j	6a4 <core_bench_list+0x3d8>
core_list_mergesort():
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:548
                    p = p->next;
     684:	000d3503          	ld	a0,0(s10)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:549
                    psize--;
     688:	3cfd                	c.addiw	s9,-1
     68a:	8aa2                	c.mv	s5,s0
     68c:	846a                	c.mv	s0,s10
     68e:	8d2a                	c.mv	s10,a0
     690:	8922                	c.mv	s2,s0
     692:	140b9163          	bnez	s7,7d4 <core_bench_list+0x508>
     696:	a299                	c.j	7dc <core_bench_list+0x510>
calc_func():
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:78
        return (data & 0x007f);
     698:	07f4fa13          	andi	s4,s1,127
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:72 (discriminator 2)
    ee_s16 data = *pdata;
     69c:	00095483          	lhu	s1,0(s2)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:77 (discriminator 2)
    if (optype) /* if cached, use cache */
     6a0:	0674fa5b          	bbc	s1,7,714 <core_bench_list+0x448>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:78 (discriminator 2)
        return (data & 0x007f);
     6a4:	07f4f593          	andi	a1,s1,127
core_list_mergesort():
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:551 (discriminator 2)
                else if (cmp(p->info, q->info, res) <= 0)
     6a8:	1145ec63          	bltu	a1,s4,7c0 <core_bench_list+0x4f4>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:556
                    p = p->next;
     6ac:	000d3503          	ld	a0,0(s10)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:557
                    psize--;
     6b0:	3cfd                	c.addiw	s9,-1
     6b2:	8aa2                	c.mv	s5,s0
     6b4:	846a                	c.mv	s0,s10
     6b6:	8d2a                	c.mv	s10,a0
     6b8:	8922                	c.mv	s2,s0
     6ba:	100b9d63          	bnez	s7,7d4 <core_bench_list+0x508>
     6be:	aa39                	c.j	7dc <core_bench_list+0x510>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:541
                    q = q->next;
     6c0:	00043a83          	ld	s5,0(s0)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:568
                if (tail)
     6c4:	300b8663          	beqz	s7,9d0 <core_bench_list+0x704>
     6c8:	3b7d                	c.addiw	s6,-1
     6ca:	4c81                	c.li	s9,0
     6cc:	1080006f          	j	7d4 <core_bench_list+0x508>
calc_func():
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:101
                retval = core_bench_matrix(&(res->mat), dtype, res->crc);
     6d0:	0609d603          	lhu	a2,96(s3)
     6d4:	6546                	c.ldsp	a0,80(sp)
     6d6:	85ba                	c.mv	a1,a4
     6d8:	585020ef          	jal	ra,345c <core_bench_matrix>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:102
                if (res->crcmatrix == 0)
     6dc:	0649d583          	lhu	a1,100(s3)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:101
                retval = core_bench_matrix(&(res->mat), dtype, res->crc);
     6e0:	00a00a33          	add	s4,zero,a0
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:102
                if (res->crcmatrix == 0)
     6e4:	72058663          	beqz	a1,e10 <EDLM_SIZE+0x3c8>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:109
        res->crc = crcu16(retval, res->crc);
     6e8:	0609d583          	lhu	a1,96(s3)
     6ec:	01400533          	add	a0,zero,s4
     6f0:	114060ef          	jal	ra,6804 <crcu16>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:110
        retval &= 0x007f;
     6f4:	07fa7a13          	andi	s4,s4,127
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:111
        *pdata = (data & 0xff00) | 0x0080 | retval; /* cache the result */
     6f8:	f004f593          	andi	a1,s1,-256
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:109
        res->crc = crcu16(retval, res->crc);
     6fc:	06a99023          	sh	a0,96(s3)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:111
        *pdata = (data & 0xff00) | 0x0080 | retval; /* cache the result */
     700:	0145e5b3          	or	a1,a1,s4
     704:	0805e593          	ori	a1,a1,128
     708:	00ba9023          	sh	a1,0(s5)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:72 (discriminator 2)
    ee_s16 data = *pdata;
     70c:	00095483          	lhu	s1,0(s2)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:77 (discriminator 2)
    if (optype) /* if cached, use cache */
     710:	f874fa5b          	bbs	s1,7,6a4 <core_bench_list+0x3d8>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:83 (discriminator 2)
            = ((data >> 3)
     714:	1834a55b          	bfoz	a0,s1,6,3
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:85 (discriminator 2)
        dtype |= dtype << 4; /* replicate the lower 4 bits to get an 8b value */
     718:	00451593          	slli	a1,a0,0x4
     71c:	00a5e733          	or	a4,a1,a0
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:86 (discriminator 2)
        switch (flag)
     720:	0074f513          	andi	a0,s1,7
     724:	0615505b          	beqc	a0,1,784 <core_bench_list+0x4b8>
     728:	8aa6                	c.mv	s5,s1
     72a:	e92d                	c.bnez	a0,79c <core_bench_list+0x4d0>
     72c:	02200513          	li	a0,34
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:89 (discriminator 2)
                if (dtype < 0x22) /* set min period for bit corruption */
     730:	00e56463          	bltu	a0,a4,738 <core_bench_list+0x46c>
     734:	02200713          	li	a4,34
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:96 (discriminator 2)
                                          res->crc);
     738:	0609d783          	lhu	a5,96(s3)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:93 (discriminator 2)
                                          res->seed1,
     73c:	00099603          	lh	a2,0(s3)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:94 (discriminator 2)
                                          res->seed2,
     740:	00299683          	lh	a3,2(s3)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:92 (discriminator 2)
                                          res->memblock[3],
     744:	0209b583          	ld	a1,32(s3)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:91 (discriminator 2)
                retval = core_bench_state(res->size,
     748:	0289a503          	lw	a0,40(s3)
     74c:	1ac050ef          	jal	ra,58f8 <core_bench_state>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:97 (discriminator 2)
                if (res->crcstate == 0)
     750:	0669d583          	lhu	a1,102(s3)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:91 (discriminator 2)
                retval = core_bench_state(res->size,
     754:	8aaa                	c.mv	s5,a0
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:97 (discriminator 2)
                if (res->crcstate == 0)
     756:	e1b9                	c.bnez	a1,79c <core_bench_list+0x4d0>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:98 (discriminator 2)
                    res->crcstate = retval;
     758:	07599323          	sh	s5,102(s3)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:109 (discriminator 2)
        res->crc = crcu16(retval, res->crc);
     75c:	0609d583          	lhu	a1,96(s3)
     760:	8556                	c.mv	a0,s5
     762:	0a2060ef          	jal	ra,6804 <crcu16>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:110 (discriminator 2)
        retval &= 0x007f;
     766:	07faf593          	andi	a1,s5,127
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:111 (discriminator 2)
        *pdata = (data & 0xff00) | 0x0080 | retval; /* cache the result */
     76a:	f004f613          	andi	a2,s1,-256
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:109 (discriminator 2)
        res->crc = crcu16(retval, res->crc);
     76e:	06a99023          	sh	a0,96(s3)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:111 (discriminator 2)
        *pdata = (data & 0xff00) | 0x0080 | retval; /* cache the result */
     772:	8e4d                	c.or	a2,a1
     774:	08066613          	ori	a2,a2,128
     778:	00c91023          	sh	a2,0(s2)
core_list_mergesort():
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:551 (discriminator 2)
                else if (cmp(p->info, q->info, res) <= 0)
     77c:	f345f8e3          	bgeu	a1,s4,6ac <core_bench_list+0x3e0>
     780:	0400006f          	j	7c0 <core_bench_list+0x4f4>
calc_func():
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:101 (discriminator 2)
                retval = core_bench_matrix(&(res->mat), dtype, res->crc);
     784:	0609d603          	lhu	a2,96(s3)
     788:	6546                	c.ldsp	a0,80(sp)
     78a:	85ba                	c.mv	a1,a4
     78c:	4d1020ef          	jal	ra,345c <core_bench_matrix>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:102 (discriminator 2)
                if (res->crcmatrix == 0)
     790:	0649d583          	lhu	a1,100(s3)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:101 (discriminator 2)
                retval = core_bench_matrix(&(res->mat), dtype, res->crc);
     794:	00a00ab3          	add	s5,zero,a0
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:102 (discriminator 2)
                if (res->crcmatrix == 0)
     798:	6a058663          	beqz	a1,e44 <EDLM_SIZE+0x3fc>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:109 (discriminator 2)
        res->crc = crcu16(retval, res->crc);
     79c:	0609d583          	lhu	a1,96(s3)
     7a0:	8556                	c.mv	a0,s5
     7a2:	062060ef          	jal	ra,6804 <crcu16>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:110 (discriminator 2)
        retval &= 0x007f;
     7a6:	07faf593          	andi	a1,s5,127
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:111 (discriminator 2)
        *pdata = (data & 0xff00) | 0x0080 | retval; /* cache the result */
     7aa:	f004f613          	andi	a2,s1,-256
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:109 (discriminator 2)
        res->crc = crcu16(retval, res->crc);
     7ae:	06a99023          	sh	a0,96(s3)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:111 (discriminator 2)
        *pdata = (data & 0xff00) | 0x0080 | retval; /* cache the result */
     7b2:	8e4d                	c.or	a2,a1
     7b4:	08066613          	ori	a2,a2,128
     7b8:	00c91023          	sh	a2,0(s2)
core_list_mergesort():
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:551 (discriminator 2)
                else if (cmp(p->info, q->info, res) <= 0)
     7bc:	ef45f8e3          	bgeu	a1,s4,6ac <core_bench_list+0x3e0>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:563
                    q = q->next;
     7c0:	00043a83          	ld	s5,0(s0)
     7c4:	856a                	c.mv	a0,s10
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:564
                    qsize--;
     7c6:	3b7d                	c.addiw	s6,-1
     7c8:	8d22                	c.mv	s10,s0
     7ca:	846a                	c.mv	s0,s10
     7cc:	8d2a                	c.mv	s10,a0
     7ce:	8922                	c.mv	s2,s0
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:568 (discriminator 4)
                if (tail)
     7d0:	000b8663          	beqz	s7,7dc <core_bench_list+0x510>
     7d4:	01800933          	add	s2,zero,s8
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:570
                    tail->next = e;
     7d8:	008bb023          	sd	s0,0(s7)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:533 (discriminator 8)
            while (psize > 0 || (qsize > 0 && q))
     7dc:	000c859b          	sext.w	a1,s9
     7e0:	000b051b          	sext.w	a0,s6
     7e4:	00b04863          	bgtz	a1,7f4 <core_bench_list+0x528>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:533 (discriminator 10)
     7e8:	7aa05663          	blez	a0,f94 <EDLM_SIZE+0x54c>
     7ec:	7a0a8a63          	beqz	s5,fa0 <EDLM_SIZE+0x558>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:537 (discriminator 2)
                if (psize == 0)
     7f0:	0c058663          	beqz	a1,8bc <core_bench_list+0x5f0>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:544 (discriminator 2)
                else if (qsize == 0 || !q)
     7f4:	c551                	c.beqz	a0,880 <core_bench_list+0x5b4>
     7f6:	080a8563          	beqz	s5,880 <core_bench_list+0x5b4>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:551 (discriminator 4)
                else if (cmp(p->info, q->info, res) <= 0)
     7fa:	008d3c03          	ld	s8,8(s10)
     7fe:	008aba03          	ld	s4,8(s5)
calc_func():
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:72 (discriminator 4)
    ee_s16 data = *pdata;
     802:	000c5483          	lhu	s1,0(s8)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:77 (discriminator 4)
    if (optype) /* if cached, use cache */
     806:	4874f75b          	bbs	s1,7,894 <core_bench_list+0x5c8>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:83 (discriminator 4)
            = ((data >> 3)
     80a:	1834a55b          	bfoz	a0,s1,6,3
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:85 (discriminator 4)
        dtype |= dtype << 4; /* replicate the lower 4 bits to get an 8b value */
     80e:	00451593          	slli	a1,a0,0x4
     812:	00a5e733          	or	a4,a1,a0
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:86 (discriminator 4)
        switch (flag)
     816:	0074f513          	andi	a0,s1,7
     81a:	0a15595b          	beqc	a0,1,8cc <core_bench_list+0x600>
     81e:	8ba6                	c.mv	s7,s1
     820:	0c051263          	bnez	a0,8e4 <core_bench_list+0x618>
     824:	02200513          	li	a0,34
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:89 (discriminator 4)
                if (dtype < 0x22) /* set min period for bit corruption */
     828:	00e56463          	bltu	a0,a4,830 <core_bench_list+0x564>
     82c:	02200713          	li	a4,34
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:96 (discriminator 4)
                                          res->crc);
     830:	0609d783          	lhu	a5,96(s3)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:93 (discriminator 4)
                                          res->seed1,
     834:	00099603          	lh	a2,0(s3)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:94 (discriminator 4)
                                          res->seed2,
     838:	00299683          	lh	a3,2(s3)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:92 (discriminator 4)
                                          res->memblock[3],
     83c:	0209b583          	ld	a1,32(s3)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:91 (discriminator 4)
                retval = core_bench_state(res->size,
     840:	0289a503          	lw	a0,40(s3)
     844:	0b4050ef          	jal	ra,58f8 <core_bench_state>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:97 (discriminator 4)
                if (res->crcstate == 0)
     848:	0669d583          	lhu	a1,102(s3)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:91 (discriminator 4)
                retval = core_bench_state(res->size,
     84c:	8baa                	c.mv	s7,a0
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:97 (discriminator 4)
                if (res->crcstate == 0)
     84e:	e9d9                	c.bnez	a1,8e4 <core_bench_list+0x618>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:98 (discriminator 4)
                    res->crcstate = retval;
     850:	07799323          	sh	s7,102(s3)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:109 (discriminator 4)
        res->crc = crcu16(retval, res->crc);
     854:	0609d583          	lhu	a1,96(s3)
     858:	855e                	c.mv	a0,s7
     85a:	7ab050ef          	jal	ra,6804 <crcu16>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:110 (discriminator 4)
        retval &= 0x007f;
     85e:	07fbfb93          	andi	s7,s7,127
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:111 (discriminator 4)
        *pdata = (data & 0xff00) | 0x0080 | retval; /* cache the result */
     862:	f004f593          	andi	a1,s1,-256
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:109 (discriminator 4)
        res->crc = crcu16(retval, res->crc);
     866:	06a99023          	sh	a0,96(s3)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:111 (discriminator 4)
        *pdata = (data & 0xff00) | 0x0080 | retval; /* cache the result */
     86a:	0175e5b3          	or	a1,a1,s7
     86e:	0805e593          	ori	a1,a1,128
     872:	00bc1023          	sh	a1,0(s8)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:72 (discriminator 6)
    ee_s16 data = *pdata;
     876:	000a5483          	lhu	s1,0(s4)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:77 (discriminator 6)
    if (optype) /* if cached, use cache */
     87a:	0874fb5b          	bbc	s1,7,910 <core_bench_list+0x644>
     87e:	a00d                	c.j	8a0 <core_bench_list+0x5d4>
core_list_mergesort():
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:548 (discriminator 2)
                    p = p->next;
     880:	000d3503          	ld	a0,0(s10)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:549 (discriminator 2)
                    psize--;
     884:	3cfd                	c.addiw	s9,-1
     886:	8a56                	c.mv	s4,s5
     888:	8aea                	c.mv	s5,s10
     88a:	8d2a                	c.mv	s10,a0
     88c:	8c56                	c.mv	s8,s5
     88e:	14041b63          	bnez	s0,9e4 <core_bench_list+0x718>
     892:	aaa9                	c.j	9ec <core_bench_list+0x720>
calc_func():
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:78 (discriminator 4)
        return (data & 0x007f);
     894:	07f4fb93          	andi	s7,s1,127
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:72 (discriminator 6)
    ee_s16 data = *pdata;
     898:	000a5483          	lhu	s1,0(s4)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:77 (discriminator 6)
    if (optype) /* if cached, use cache */
     89c:	0674fa5b          	bbc	s1,7,910 <core_bench_list+0x644>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:78 (discriminator 6)
        return (data & 0x007f);
     8a0:	07f4f593          	andi	a1,s1,127
core_list_mergesort():
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:551 (discriminator 6)
                else if (cmp(p->info, q->info, res) <= 0)
     8a4:	1175ec63          	bltu	a1,s7,9bc <core_bench_list+0x6f0>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:556 (discriminator 2)
                    p = p->next;
     8a8:	000d3503          	ld	a0,0(s10)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:557 (discriminator 2)
                    psize--;
     8ac:	3cfd                	c.addiw	s9,-1
     8ae:	8a56                	c.mv	s4,s5
     8b0:	8aea                	c.mv	s5,s10
     8b2:	8d2a                	c.mv	s10,a0
     8b4:	8c56                	c.mv	s8,s5
     8b6:	12041763          	bnez	s0,9e4 <core_bench_list+0x718>
     8ba:	aa0d                	c.j	9ec <core_bench_list+0x720>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:541 (discriminator 4)
                    q = q->next;
     8bc:	000aba03          	ld	s4,0(s5)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:568 (discriminator 6)
                if (tail)
     8c0:	32040263          	beqz	s0,be4 <EDLM_SIZE+0x19c>
     8c4:	3b7d                	c.addiw	s6,-1
     8c6:	4c81                	c.li	s9,0
     8c8:	11c0006f          	j	9e4 <core_bench_list+0x718>
calc_func():
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:101 (discriminator 4)
                retval = core_bench_matrix(&(res->mat), dtype, res->crc);
     8cc:	0609d603          	lhu	a2,96(s3)
     8d0:	6546                	c.ldsp	a0,80(sp)
     8d2:	85ba                	c.mv	a1,a4
     8d4:	389020ef          	jal	ra,345c <core_bench_matrix>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:102 (discriminator 4)
                if (res->crcmatrix == 0)
     8d8:	0649d583          	lhu	a1,100(s3)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:101 (discriminator 4)
                retval = core_bench_matrix(&(res->mat), dtype, res->crc);
     8dc:	00a00bb3          	add	s7,zero,a0
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:102 (discriminator 4)
                if (res->crcmatrix == 0)
     8e0:	58058863          	beqz	a1,e70 <EDLM_SIZE+0x428>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:109 (discriminator 4)
        res->crc = crcu16(retval, res->crc);
     8e4:	0609d583          	lhu	a1,96(s3)
     8e8:	01700533          	add	a0,zero,s7
     8ec:	719050ef          	jal	ra,6804 <crcu16>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:110 (discriminator 4)
        retval &= 0x007f;
     8f0:	07fbfb93          	andi	s7,s7,127
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:111 (discriminator 4)
        *pdata = (data & 0xff00) | 0x0080 | retval; /* cache the result */
     8f4:	f004f593          	andi	a1,s1,-256
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:109 (discriminator 4)
        res->crc = crcu16(retval, res->crc);
     8f8:	06a99023          	sh	a0,96(s3)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:111 (discriminator 4)
        *pdata = (data & 0xff00) | 0x0080 | retval; /* cache the result */
     8fc:	0175e5b3          	or	a1,a1,s7
     900:	0805e593          	ori	a1,a1,128
     904:	00bc1023          	sh	a1,0(s8)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:72 (discriminator 6)
    ee_s16 data = *pdata;
     908:	000a5483          	lhu	s1,0(s4)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:77 (discriminator 6)
    if (optype) /* if cached, use cache */
     90c:	f874fa5b          	bbs	s1,7,8a0 <core_bench_list+0x5d4>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:83 (discriminator 6)
            = ((data >> 3)
     910:	1834a55b          	bfoz	a0,s1,6,3
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:85 (discriminator 6)
        dtype |= dtype << 4; /* replicate the lower 4 bits to get an 8b value */
     914:	00451593          	slli	a1,a0,0x4
     918:	00a5e733          	or	a4,a1,a0
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:86 (discriminator 6)
        switch (flag)
     91c:	0074f513          	andi	a0,s1,7
     920:	0615505b          	beqc	a0,1,980 <core_bench_list+0x6b4>
     924:	8c26                	c.mv	s8,s1
     926:	e92d                	c.bnez	a0,998 <core_bench_list+0x6cc>
     928:	02200513          	li	a0,34
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:89 (discriminator 6)
                if (dtype < 0x22) /* set min period for bit corruption */
     92c:	00e56463          	bltu	a0,a4,934 <core_bench_list+0x668>
     930:	02200713          	li	a4,34
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:96 (discriminator 6)
                                          res->crc);
     934:	0609d783          	lhu	a5,96(s3)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:93 (discriminator 6)
                                          res->seed1,
     938:	00099603          	lh	a2,0(s3)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:94 (discriminator 6)
                                          res->seed2,
     93c:	00299683          	lh	a3,2(s3)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:92 (discriminator 6)
                                          res->memblock[3],
     940:	0209b583          	ld	a1,32(s3)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:91 (discriminator 6)
                retval = core_bench_state(res->size,
     944:	0289a503          	lw	a0,40(s3)
     948:	7b1040ef          	jal	ra,58f8 <core_bench_state>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:97 (discriminator 6)
                if (res->crcstate == 0)
     94c:	0669d583          	lhu	a1,102(s3)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:91 (discriminator 6)
                retval = core_bench_state(res->size,
     950:	8c2a                	c.mv	s8,a0
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:97 (discriminator 6)
                if (res->crcstate == 0)
     952:	e1b9                	c.bnez	a1,998 <core_bench_list+0x6cc>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:98 (discriminator 6)
                    res->crcstate = retval;
     954:	07899323          	sh	s8,102(s3)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:109 (discriminator 6)
        res->crc = crcu16(retval, res->crc);
     958:	0609d583          	lhu	a1,96(s3)
     95c:	8562                	c.mv	a0,s8
     95e:	6a7050ef          	jal	ra,6804 <crcu16>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:110 (discriminator 6)
        retval &= 0x007f;
     962:	07fc7593          	andi	a1,s8,127
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:111 (discriminator 6)
        *pdata = (data & 0xff00) | 0x0080 | retval; /* cache the result */
     966:	f004f613          	andi	a2,s1,-256
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:109 (discriminator 6)
        res->crc = crcu16(retval, res->crc);
     96a:	06a99023          	sh	a0,96(s3)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:111 (discriminator 6)
        *pdata = (data & 0xff00) | 0x0080 | retval; /* cache the result */
     96e:	8e4d                	c.or	a2,a1
     970:	08066613          	ori	a2,a2,128
     974:	00ca1023          	sh	a2,0(s4)
core_list_mergesort():
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:551 (discriminator 6)
                else if (cmp(p->info, q->info, res) <= 0)
     978:	f375f8e3          	bgeu	a1,s7,8a8 <core_bench_list+0x5dc>
     97c:	0400006f          	j	9bc <core_bench_list+0x6f0>
calc_func():
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:101 (discriminator 6)
                retval = core_bench_matrix(&(res->mat), dtype, res->crc);
     980:	0609d603          	lhu	a2,96(s3)
     984:	6546                	c.ldsp	a0,80(sp)
     986:	85ba                	c.mv	a1,a4
     988:	2d5020ef          	jal	ra,345c <core_bench_matrix>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:102 (discriminator 6)
                if (res->crcmatrix == 0)
     98c:	0649d583          	lhu	a1,100(s3)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:101 (discriminator 6)
                retval = core_bench_matrix(&(res->mat), dtype, res->crc);
     990:	00a00c33          	add	s8,zero,a0
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:102 (discriminator 6)
                if (res->crcmatrix == 0)
     994:	50058863          	beqz	a1,ea4 <EDLM_SIZE+0x45c>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:109 (discriminator 6)
        res->crc = crcu16(retval, res->crc);
     998:	0609d583          	lhu	a1,96(s3)
     99c:	8562                	c.mv	a0,s8
     99e:	667050ef          	jal	ra,6804 <crcu16>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:110 (discriminator 6)
        retval &= 0x007f;
     9a2:	07fc7593          	andi	a1,s8,127
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:111 (discriminator 6)
        *pdata = (data & 0xff00) | 0x0080 | retval; /* cache the result */
     9a6:	f004f613          	andi	a2,s1,-256
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:109 (discriminator 6)
        res->crc = crcu16(retval, res->crc);
     9aa:	06a99023          	sh	a0,96(s3)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:111 (discriminator 6)
        *pdata = (data & 0xff00) | 0x0080 | retval; /* cache the result */
     9ae:	8e4d                	c.or	a2,a1
     9b0:	08066613          	ori	a2,a2,128
     9b4:	00ca1023          	sh	a2,0(s4)
core_list_mergesort():
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:551 (discriminator 6)
                else if (cmp(p->info, q->info, res) <= 0)
     9b8:	ef75f8e3          	bgeu	a1,s7,8a8 <core_bench_list+0x5dc>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:563 (discriminator 2)
                    q = q->next;
     9bc:	000aba03          	ld	s4,0(s5)
     9c0:	856a                	c.mv	a0,s10
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:564 (discriminator 2)
                    qsize--;
     9c2:	3b7d                	c.addiw	s6,-1
     9c4:	8d56                	c.mv	s10,s5
     9c6:	8aea                	c.mv	s5,s10
     9c8:	8d2a                	c.mv	s10,a0
     9ca:	8c56                	c.mv	s8,s5
     9cc:	ec01                	c.bnez	s0,9e4 <core_bench_list+0x718>
     9ce:	a839                	c.j	9ec <core_bench_list+0x720>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:533 (discriminator 6)
            while (psize > 0 || (qsize > 0 && q))
     9d0:	4589                	c.li	a1,2
     9d2:	5eb54d63          	blt	a0,a1,fcc <EDLM_SIZE+0x584>
     9d6:	600a8163          	beqz	s5,fd8 <EDLM_SIZE+0x590>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:541 (discriminator 2)
                    q = q->next;
     9da:	000aba03          	ld	s4,0(s5)
     9de:	4c81                	c.li	s9,0
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:542 (discriminator 2)
                    qsize--;
     9e0:	3b79                	c.addiw	s6,-2
     9e2:	8922                	c.mv	s2,s0
     9e4:	01200c33          	add	s8,zero,s2
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:570 (discriminator 2)
                    tail->next = e;
     9e8:	01543023          	sd	s5,0(s0)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:533 (discriminator 14)
            while (psize > 0 || (qsize > 0 && q))
     9ec:	000c859b          	sext.w	a1,s9
     9f0:	000b051b          	sext.w	a0,s6
     9f4:	00b04863          	bgtz	a1,a04 <core_bench_list+0x738>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:533 (discriminator 16)
     9f8:	5aa05a63          	blez	a0,fac <EDLM_SIZE+0x564>
     9fc:	5a0a0c63          	beqz	s4,fb4 <EDLM_SIZE+0x56c>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:537 (discriminator 4)
                if (psize == 0)
     a00:	0c058663          	beqz	a1,acc <EDLM_SIZE+0x84>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:544 (discriminator 4)
                else if (qsize == 0 || !q)
     a04:	c551                	c.beqz	a0,a90 <EDLM_SIZE+0x48>
     a06:	080a0563          	beqz	s4,a90 <EDLM_SIZE+0x48>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:551 (discriminator 8)
                else if (cmp(p->info, q->info, res) <= 0)
     a0a:	008d3d83          	ld	s11,8(s10)
     a0e:	008a3903          	ld	s2,8(s4)
calc_func():
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:72 (discriminator 8)
    ee_s16 data = *pdata;
     a12:	000dd483          	lhu	s1,0(s11)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:77 (discriminator 8)
    if (optype) /* if cached, use cache */
     a16:	4874f75b          	bbs	s1,7,aa4 <EDLM_SIZE+0x5c>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:83 (discriminator 8)
            = ((data >> 3)
     a1a:	1834a55b          	bfoz	a0,s1,6,3
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:85 (discriminator 8)
        dtype |= dtype << 4; /* replicate the lower 4 bits to get an 8b value */
     a1e:	00451593          	slli	a1,a0,0x4
     a22:	00a5e733          	or	a4,a1,a0
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:86 (discriminator 8)
        switch (flag)
     a26:	0074f513          	andi	a0,s1,7
     a2a:	0a15595b          	beqc	a0,1,adc <EDLM_SIZE+0x94>
     a2e:	8426                	c.mv	s0,s1
     a30:	0c051263          	bnez	a0,af4 <EDLM_SIZE+0xac>
     a34:	02200513          	li	a0,34
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:89 (discriminator 8)
                if (dtype < 0x22) /* set min period for bit corruption */
     a38:	00e56463          	bltu	a0,a4,a40 <core_bench_list+0x774>
     a3c:	02200713          	li	a4,34
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:96 (discriminator 8)
                                          res->crc);
     a40:	0609d783          	lhu	a5,96(s3)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:93 (discriminator 8)
                                          res->seed1,
     a44:	00099603          	lh	a2,0(s3)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:94 (discriminator 8)
                                          res->seed2,
     a48:	00299683          	lh	a3,2(s3)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:92 (discriminator 8)
                                          res->memblock[3],
     a4c:	0209b583          	ld	a1,32(s3)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:91 (discriminator 8)
                retval = core_bench_state(res->size,
     a50:	0289a503          	lw	a0,40(s3)
     a54:	6a5040ef          	jal	ra,58f8 <core_bench_state>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:97 (discriminator 8)
                if (res->crcstate == 0)
     a58:	0669d583          	lhu	a1,102(s3)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:91 (discriminator 8)
                retval = core_bench_state(res->size,
     a5c:	842a                	c.mv	s0,a0
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:97 (discriminator 8)
                if (res->crcstate == 0)
     a5e:	e9d9                	c.bnez	a1,af4 <EDLM_SIZE+0xac>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:98 (discriminator 8)
                    res->crcstate = retval;
     a60:	06899323          	sh	s0,102(s3)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:109 (discriminator 8)
        res->crc = crcu16(retval, res->crc);
     a64:	0609d583          	lhu	a1,96(s3)
     a68:	8522                	c.mv	a0,s0
     a6a:	59b050ef          	jal	ra,6804 <crcu16>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:110 (discriminator 8)
        retval &= 0x007f;
     a6e:	07f47b93          	andi	s7,s0,127
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:111 (discriminator 8)
        *pdata = (data & 0xff00) | 0x0080 | retval; /* cache the result */
     a72:	f004f593          	andi	a1,s1,-256
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:109 (discriminator 8)
        res->crc = crcu16(retval, res->crc);
     a76:	06a99023          	sh	a0,96(s3)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:111 (discriminator 8)
        *pdata = (data & 0xff00) | 0x0080 | retval; /* cache the result */
     a7a:	0175e5b3          	or	a1,a1,s7
     a7e:	0805e593          	ori	a1,a1,128
     a82:	00bd9023          	sh	a1,0(s11)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:72 (discriminator 10)
    ee_s16 data = *pdata;
     a86:	00095403          	lhu	s0,0(s2)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:77 (discriminator 10)
    if (optype) /* if cached, use cache */
     a8a:	08747b5b          	bbc	s0,7,b20 <EDLM_SIZE+0xd8>
     a8e:	a00d                	c.j	ab0 <EDLM_SIZE+0x68>
core_list_mergesort():
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:548 (discriminator 4)
                    p = p->next;
     a90:	000d3b83          	ld	s7,0(s10)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:549 (discriminator 4)
                    psize--;
     a94:	3cfd                	c.addiw	s9,-1
     a96:	8952                	c.mv	s2,s4
     a98:	8a6a                	c.mv	s4,s10
     a9a:	8d5e                	c.mv	s10,s7
     a9c:	8dd2                	c.mv	s11,s4
     a9e:	140a9d63          	bnez	s5,bf8 <EDLM_SIZE+0x1b0>
     aa2:	a28d                	c.j	c04 <EDLM_SIZE+0x1bc>
calc_func():
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:78 (discriminator 8)
        return (data & 0x007f);
     aa4:	07f4fb93          	andi	s7,s1,127
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:72 (discriminator 10)
    ee_s16 data = *pdata;
     aa8:	00095403          	lhu	s0,0(s2)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:77 (discriminator 10)
    if (optype) /* if cached, use cache */
     aac:	06747a5b          	bbc	s0,7,b20 <EDLM_SIZE+0xd8>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:78 (discriminator 10)
        return (data & 0x007f);
     ab0:	07f47593          	andi	a1,s0,127
core_list_mergesort():
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:551 (discriminator 10)
                else if (cmp(p->info, q->info, res) <= 0)
     ab4:	1175ec63          	bltu	a1,s7,bcc <EDLM_SIZE+0x184>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:556 (discriminator 4)
                    p = p->next;
     ab8:	000d3b83          	ld	s7,0(s10)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:557 (discriminator 4)
                    psize--;
     abc:	3cfd                	c.addiw	s9,-1
     abe:	8952                	c.mv	s2,s4
     ac0:	8a6a                	c.mv	s4,s10
     ac2:	8d5e                	c.mv	s10,s7
     ac4:	8dd2                	c.mv	s11,s4
     ac6:	120a9963          	bnez	s5,bf8 <EDLM_SIZE+0x1b0>
     aca:	aa2d                	c.j	c04 <EDLM_SIZE+0x1bc>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:541 (discriminator 8)
                    q = q->next;
     acc:	000a3903          	ld	s2,0(s4)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:542 (discriminator 8)
                    qsize--;
     ad0:	3b7d                	c.addiw	s6,-1
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:568 (discriminator 12)
                if (tail)
     ad2:	300a8963          	beqz	s5,de4 <EDLM_SIZE+0x39c>
     ad6:	4c81                	c.li	s9,0
     ad8:	1200006f          	j	bf8 <EDLM_SIZE+0x1b0>
calc_func():
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:101 (discriminator 8)
                retval = core_bench_matrix(&(res->mat), dtype, res->crc);
     adc:	0609d603          	lhu	a2,96(s3)
     ae0:	6546                	c.ldsp	a0,80(sp)
     ae2:	85ba                	c.mv	a1,a4
     ae4:	179020ef          	jal	ra,345c <core_bench_matrix>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:102 (discriminator 8)
                if (res->crcmatrix == 0)
     ae8:	0649d583          	lhu	a1,100(s3)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:101 (discriminator 8)
                retval = core_bench_matrix(&(res->mat), dtype, res->crc);
     aec:	00a00433          	add	s0,zero,a0
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:102 (discriminator 8)
                if (res->crcmatrix == 0)
     af0:	3e058063          	beqz	a1,ed0 <EDLM_SIZE+0x488>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:109 (discriminator 8)
        res->crc = crcu16(retval, res->crc);
     af4:	0609d583          	lhu	a1,96(s3)
     af8:	00800533          	add	a0,zero,s0
     afc:	509050ef          	jal	ra,6804 <crcu16>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:110 (discriminator 8)
        retval &= 0x007f;
     b00:	07f47b93          	andi	s7,s0,127
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:111 (discriminator 8)
        *pdata = (data & 0xff00) | 0x0080 | retval; /* cache the result */
     b04:	f004f593          	andi	a1,s1,-256
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:109 (discriminator 8)
        res->crc = crcu16(retval, res->crc);
     b08:	06a99023          	sh	a0,96(s3)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:111 (discriminator 8)
        *pdata = (data & 0xff00) | 0x0080 | retval; /* cache the result */
     b0c:	0175e5b3          	or	a1,a1,s7
     b10:	0805e593          	ori	a1,a1,128
     b14:	00bd9023          	sh	a1,0(s11)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:72 (discriminator 10)
    ee_s16 data = *pdata;
     b18:	00095403          	lhu	s0,0(s2)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:77 (discriminator 10)
    if (optype) /* if cached, use cache */
     b1c:	f8747a5b          	bbs	s0,7,ab0 <EDLM_SIZE+0x68>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:83 (discriminator 10)
            = ((data >> 3)
     b20:	1834255b          	bfoz	a0,s0,6,3
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:85 (discriminator 10)
        dtype |= dtype << 4; /* replicate the lower 4 bits to get an 8b value */
     b24:	00451593          	slli	a1,a0,0x4
     b28:	00a5e733          	or	a4,a1,a0
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:86 (discriminator 10)
        switch (flag)
     b2c:	00747513          	andi	a0,s0,7
     b30:	0615505b          	beqc	a0,1,b90 <EDLM_SIZE+0x148>
     b34:	84a2                	c.mv	s1,s0
     b36:	e92d                	c.bnez	a0,ba8 <EDLM_SIZE+0x160>
     b38:	02200513          	li	a0,34
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:89 (discriminator 10)
                if (dtype < 0x22) /* set min period for bit corruption */
     b3c:	00e56463          	bltu	a0,a4,b44 <EDLM_SIZE+0xfc>
     b40:	02200713          	li	a4,34
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:96 (discriminator 10)
                                          res->crc);
     b44:	0609d783          	lhu	a5,96(s3)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:93 (discriminator 10)
                                          res->seed1,
     b48:	00099603          	lh	a2,0(s3)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:94 (discriminator 10)
                                          res->seed2,
     b4c:	00299683          	lh	a3,2(s3)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:92 (discriminator 10)
                                          res->memblock[3],
     b50:	0209b583          	ld	a1,32(s3)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:91 (discriminator 10)
                retval = core_bench_state(res->size,
     b54:	0289a503          	lw	a0,40(s3)
     b58:	5a1040ef          	jal	ra,58f8 <core_bench_state>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:97 (discriminator 10)
                if (res->crcstate == 0)
     b5c:	0669d583          	lhu	a1,102(s3)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:91 (discriminator 10)
                retval = core_bench_state(res->size,
     b60:	84aa                	c.mv	s1,a0
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:97 (discriminator 10)
                if (res->crcstate == 0)
     b62:	e1b9                	c.bnez	a1,ba8 <EDLM_SIZE+0x160>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:98 (discriminator 10)
                    res->crcstate = retval;
     b64:	06999323          	sh	s1,102(s3)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:109 (discriminator 10)
        res->crc = crcu16(retval, res->crc);
     b68:	0609d583          	lhu	a1,96(s3)
     b6c:	8526                	c.mv	a0,s1
     b6e:	497050ef          	jal	ra,6804 <crcu16>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:110 (discriminator 10)
        retval &= 0x007f;
     b72:	07f4f593          	andi	a1,s1,127
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:111 (discriminator 10)
        *pdata = (data & 0xff00) | 0x0080 | retval; /* cache the result */
     b76:	f0047613          	andi	a2,s0,-256
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:109 (discriminator 10)
        res->crc = crcu16(retval, res->crc);
     b7a:	06a99023          	sh	a0,96(s3)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:111 (discriminator 10)
        *pdata = (data & 0xff00) | 0x0080 | retval; /* cache the result */
     b7e:	8e4d                	c.or	a2,a1
     b80:	08066613          	ori	a2,a2,128
     b84:	00c91023          	sh	a2,0(s2)
core_list_mergesort():
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:551 (discriminator 10)
                else if (cmp(p->info, q->info, res) <= 0)
     b88:	f375f8e3          	bgeu	a1,s7,ab8 <EDLM_SIZE+0x70>
     b8c:	0400006f          	j	bcc <EDLM_SIZE+0x184>
calc_func():
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:101 (discriminator 10)
                retval = core_bench_matrix(&(res->mat), dtype, res->crc);
     b90:	0609d603          	lhu	a2,96(s3)
     b94:	6546                	c.ldsp	a0,80(sp)
     b96:	85ba                	c.mv	a1,a4
     b98:	0c5020ef          	jal	ra,345c <core_bench_matrix>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:102 (discriminator 10)
                if (res->crcmatrix == 0)
     b9c:	0649d583          	lhu	a1,100(s3)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:101 (discriminator 10)
                retval = core_bench_matrix(&(res->mat), dtype, res->crc);
     ba0:	00a004b3          	add	s1,zero,a0
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:102 (discriminator 10)
                if (res->crcmatrix == 0)
     ba4:	36058063          	beqz	a1,f04 <EDLM_SIZE+0x4bc>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:109 (discriminator 10)
        res->crc = crcu16(retval, res->crc);
     ba8:	0609d583          	lhu	a1,96(s3)
     bac:	8526                	c.mv	a0,s1
     bae:	457050ef          	jal	ra,6804 <crcu16>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:110 (discriminator 10)
        retval &= 0x007f;
     bb2:	07f4f593          	andi	a1,s1,127
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:111 (discriminator 10)
        *pdata = (data & 0xff00) | 0x0080 | retval; /* cache the result */
     bb6:	f0047613          	andi	a2,s0,-256
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:109 (discriminator 10)
        res->crc = crcu16(retval, res->crc);
     bba:	06a99023          	sh	a0,96(s3)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:111 (discriminator 10)
        *pdata = (data & 0xff00) | 0x0080 | retval; /* cache the result */
     bbe:	8e4d                	c.or	a2,a1
     bc0:	08066613          	ori	a2,a2,128
     bc4:	00c91023          	sh	a2,0(s2)
core_list_mergesort():
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:551 (discriminator 10)
                else if (cmp(p->info, q->info, res) <= 0)
     bc8:	ef75f8e3          	bgeu	a1,s7,ab8 <EDLM_SIZE+0x70>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:563 (discriminator 4)
                    q = q->next;
     bcc:	000a3903          	ld	s2,0(s4)
     bd0:	8bea                	c.mv	s7,s10
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:564 (discriminator 4)
                    qsize--;
     bd2:	3b7d                	c.addiw	s6,-1
     bd4:	8d52                	c.mv	s10,s4
     bd6:	8a6a                	c.mv	s4,s10
     bd8:	8d5e                	c.mv	s10,s7
     bda:	8dd2                	c.mv	s11,s4
     bdc:	000a9e63          	bnez	s5,bf8 <EDLM_SIZE+0x1b0>
     be0:	0240006f          	j	c04 <EDLM_SIZE+0x1bc>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:533 (discriminator 12)
            while (psize > 0 || (qsize > 0 && q))
     be4:	4589                	c.li	a1,2
     be6:	3eb54f63          	blt	a0,a1,fe4 <EDLM_SIZE+0x59c>
     bea:	400a0363          	beqz	s4,ff0 <EDLM_SIZE+0x5a8>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:541 (discriminator 6)
                    q = q->next;
     bee:	000a3903          	ld	s2,0(s4)
     bf2:	4c81                	c.li	s9,0
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:542 (discriminator 6)
                    qsize--;
     bf4:	3b79                	c.addiw	s6,-2
     bf6:	8c56                	c.mv	s8,s5
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:570 (discriminator 4)
                    tail->next = e;
     bf8:	014ab023          	sd	s4,0(s5)
     bfc:	8dd2                	c.mv	s11,s4
     bfe:	8bea                	c.mv	s7,s10
     c00:	01800a33          	add	s4,zero,s8
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:533 (discriminator 20)
            while (psize > 0 || (qsize > 0 && q))
     c04:	000c851b          	sext.w	a0,s9
     c08:	000b059b          	sext.w	a1,s6
     c0c:	00a04863          	bgtz	a0,c1c <EDLM_SIZE+0x1d4>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:533 (discriminator 22)
     c10:	3ab05663          	blez	a1,fbc <EDLM_SIZE+0x574>
     c14:	3a090863          	beqz	s2,fc4 <EDLM_SIZE+0x57c>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:537 (discriminator 6)
                if (psize == 0)
     c18:	0c050263          	beqz	a0,cdc <EDLM_SIZE+0x294>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:544 (discriminator 6)
                else if (qsize == 0 || !q)
     c1c:	c5d1                	c.beqz	a1,ca8 <EDLM_SIZE+0x260>
     c1e:	08090563          	beqz	s2,ca8 <EDLM_SIZE+0x260>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:551 (discriminator 12)
                else if (cmp(p->info, q->info, res) <= 0)
     c22:	008bbd03          	ld	s10,8(s7)
     c26:	00893a83          	ld	s5,8(s2)
calc_func():
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:72 (discriminator 12)
    ee_s16 data = *pdata;
     c2a:	000d5483          	lhu	s1,0(s10)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:77 (discriminator 12)
    if (optype) /* if cached, use cache */
     c2e:	4874f55b          	bbs	s1,7,cb8 <EDLM_SIZE+0x270>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:83 (discriminator 12)
            = ((data >> 3)
     c32:	1834a55b          	bfoz	a0,s1,6,3
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:85 (discriminator 12)
        dtype |= dtype << 4; /* replicate the lower 4 bits to get an 8b value */
     c36:	00451593          	slli	a1,a0,0x4
     c3a:	00a5e733          	or	a4,a1,a0
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:86 (discriminator 12)
        switch (flag)
     c3e:	0074f513          	andi	a0,s1,7
     c42:	08155f5b          	beqc	a0,1,ce0 <EDLM_SIZE+0x298>
     c46:	8426                	c.mv	s0,s1
     c48:	0a051863          	bnez	a0,cf8 <EDLM_SIZE+0x2b0>
     c4c:	02200513          	li	a0,34
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:89 (discriminator 12)
                if (dtype < 0x22) /* set min period for bit corruption */
     c50:	00e56463          	bltu	a0,a4,c58 <EDLM_SIZE+0x210>
     c54:	02200713          	li	a4,34
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:96 (discriminator 12)
                                          res->crc);
     c58:	0609d783          	lhu	a5,96(s3)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:93 (discriminator 12)
                                          res->seed1,
     c5c:	00099603          	lh	a2,0(s3)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:94 (discriminator 12)
                                          res->seed2,
     c60:	00299683          	lh	a3,2(s3)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:92 (discriminator 12)
                                          res->memblock[3],
     c64:	0209b583          	ld	a1,32(s3)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:91 (discriminator 12)
                retval = core_bench_state(res->size,
     c68:	0289a503          	lw	a0,40(s3)
     c6c:	48d040ef          	jal	ra,58f8 <core_bench_state>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:97 (discriminator 12)
                if (res->crcstate == 0)
     c70:	0669d583          	lhu	a1,102(s3)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:91 (discriminator 12)
                retval = core_bench_state(res->size,
     c74:	842a                	c.mv	s0,a0
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:97 (discriminator 12)
                if (res->crcstate == 0)
     c76:	e1c9                	c.bnez	a1,cf8 <EDLM_SIZE+0x2b0>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:98 (discriminator 12)
                    res->crcstate = retval;
     c78:	06899323          	sh	s0,102(s3)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:109 (discriminator 12)
        res->crc = crcu16(retval, res->crc);
     c7c:	0609d583          	lhu	a1,96(s3)
     c80:	8522                	c.mv	a0,s0
     c82:	383050ef          	jal	ra,6804 <crcu16>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:110 (discriminator 12)
        retval &= 0x007f;
     c86:	07f47c13          	andi	s8,s0,127
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:111 (discriminator 12)
        *pdata = (data & 0xff00) | 0x0080 | retval; /* cache the result */
     c8a:	f004f593          	andi	a1,s1,-256
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:109 (discriminator 12)
        res->crc = crcu16(retval, res->crc);
     c8e:	06a99023          	sh	a0,96(s3)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:111 (discriminator 12)
        *pdata = (data & 0xff00) | 0x0080 | retval; /* cache the result */
     c92:	0185e5b3          	or	a1,a1,s8
     c96:	0805e593          	ori	a1,a1,128
     c9a:	00bd1023          	sh	a1,0(s10)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:72 (discriminator 14)
    ee_s16 data = *pdata;
     c9e:	000ad403          	lhu	s0,0(s5)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:77 (discriminator 14)
    if (optype) /* if cached, use cache */
     ca2:	0874715b          	bbc	s0,7,d24 <EDLM_SIZE+0x2dc>
     ca6:	a839                	c.j	cc4 <EDLM_SIZE+0x27c>
core_list_mergesort():
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:548 (discriminator 6)
                    p = p->next;
     ca8:	000bbd03          	ld	s10,0(s7)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:549 (discriminator 6)
                    psize--;
     cac:	3cfd                	c.addiw	s9,-1
     cae:	844a                	c.mv	s0,s2
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:510
        list = NULL;
     cb0:	8c5e                	c.mv	s8,s7
     cb2:	140d9963          	bnez	s11,e04 <EDLM_SIZE+0x3bc>
     cb6:	ba0d                	c.j	5e8 <core_bench_list+0x31c>
calc_func():
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:78 (discriminator 12)
        return (data & 0x007f);
     cb8:	07f4fc13          	andi	s8,s1,127
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:72 (discriminator 14)
    ee_s16 data = *pdata;
     cbc:	000ad403          	lhu	s0,0(s5)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:77 (discriminator 14)
    if (optype) /* if cached, use cache */
     cc0:	0674725b          	bbc	s0,7,d24 <EDLM_SIZE+0x2dc>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:78 (discriminator 14)
        return (data & 0x007f);
     cc4:	07f47593          	andi	a1,s0,127
core_list_mergesort():
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:551 (discriminator 14)
                else if (cmp(p->info, q->info, res) <= 0)
     cc8:	1185e463          	bltu	a1,s8,dd0 <EDLM_SIZE+0x388>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:556 (discriminator 6)
                    p = p->next;
     ccc:	000bbd03          	ld	s10,0(s7)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:557 (discriminator 6)
                    psize--;
     cd0:	3cfd                	c.addiw	s9,-1
     cd2:	844a                	c.mv	s0,s2
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:510
        list = NULL;
     cd4:	8c5e                	c.mv	s8,s7
     cd6:	120d9763          	bnez	s11,e04 <EDLM_SIZE+0x3bc>
     cda:	b239                	c.j	5e8 <core_bench_list+0x31c>
     cdc:	8d5e                	c.mv	s10,s7
     cde:	aa19                	c.j	df4 <EDLM_SIZE+0x3ac>
calc_func():
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:101 (discriminator 12)
                retval = core_bench_matrix(&(res->mat), dtype, res->crc);
     ce0:	0609d603          	lhu	a2,96(s3)
     ce4:	6546                	c.ldsp	a0,80(sp)
     ce6:	85ba                	c.mv	a1,a4
     ce8:	774020ef          	jal	ra,345c <core_bench_matrix>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:102 (discriminator 12)
                if (res->crcmatrix == 0)
     cec:	0649d583          	lhu	a1,100(s3)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:101 (discriminator 12)
                retval = core_bench_matrix(&(res->mat), dtype, res->crc);
     cf0:	00a00433          	add	s0,zero,a0
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:102 (discriminator 12)
                if (res->crcmatrix == 0)
     cf4:	22058e63          	beqz	a1,f30 <EDLM_SIZE+0x4e8>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:109 (discriminator 12)
        res->crc = crcu16(retval, res->crc);
     cf8:	0609d583          	lhu	a1,96(s3)
     cfc:	00800533          	add	a0,zero,s0
     d00:	305050ef          	jal	ra,6804 <crcu16>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:110 (discriminator 12)
        retval &= 0x007f;
     d04:	07f47c13          	andi	s8,s0,127
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:111 (discriminator 12)
        *pdata = (data & 0xff00) | 0x0080 | retval; /* cache the result */
     d08:	f004f593          	andi	a1,s1,-256
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:109 (discriminator 12)
        res->crc = crcu16(retval, res->crc);
     d0c:	06a99023          	sh	a0,96(s3)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:111 (discriminator 12)
        *pdata = (data & 0xff00) | 0x0080 | retval; /* cache the result */
     d10:	0185e5b3          	or	a1,a1,s8
     d14:	0805e593          	ori	a1,a1,128
     d18:	00bd1023          	sh	a1,0(s10)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:72 (discriminator 14)
    ee_s16 data = *pdata;
     d1c:	000ad403          	lhu	s0,0(s5)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:77 (discriminator 14)
    if (optype) /* if cached, use cache */
     d20:	fa74725b          	bbs	s0,7,cc4 <EDLM_SIZE+0x27c>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:83 (discriminator 14)
            = ((data >> 3)
     d24:	1834255b          	bfoz	a0,s0,6,3
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:85 (discriminator 14)
        dtype |= dtype << 4; /* replicate the lower 4 bits to get an 8b value */
     d28:	00451593          	slli	a1,a0,0x4
     d2c:	00a5e733          	or	a4,a1,a0
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:86 (discriminator 14)
        switch (flag)
     d30:	00747513          	andi	a0,s0,7
     d34:	0615505b          	beqc	a0,1,d94 <EDLM_SIZE+0x34c>
     d38:	84a2                	c.mv	s1,s0
     d3a:	e92d                	c.bnez	a0,dac <EDLM_SIZE+0x364>
     d3c:	02200513          	li	a0,34
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:89 (discriminator 14)
                if (dtype < 0x22) /* set min period for bit corruption */
     d40:	00e56463          	bltu	a0,a4,d48 <EDLM_SIZE+0x300>
     d44:	02200713          	li	a4,34
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:96 (discriminator 14)
                                          res->crc);
     d48:	0609d783          	lhu	a5,96(s3)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:93 (discriminator 14)
                                          res->seed1,
     d4c:	00099603          	lh	a2,0(s3)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:94 (discriminator 14)
                                          res->seed2,
     d50:	00299683          	lh	a3,2(s3)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:92 (discriminator 14)
                                          res->memblock[3],
     d54:	0209b583          	ld	a1,32(s3)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:91 (discriminator 14)
                retval = core_bench_state(res->size,
     d58:	0289a503          	lw	a0,40(s3)
     d5c:	39d040ef          	jal	ra,58f8 <core_bench_state>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:97 (discriminator 14)
                if (res->crcstate == 0)
     d60:	0669d583          	lhu	a1,102(s3)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:91 (discriminator 14)
                retval = core_bench_state(res->size,
     d64:	84aa                	c.mv	s1,a0
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:97 (discriminator 14)
                if (res->crcstate == 0)
     d66:	e1b9                	c.bnez	a1,dac <EDLM_SIZE+0x364>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:98 (discriminator 14)
                    res->crcstate = retval;
     d68:	06999323          	sh	s1,102(s3)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:109 (discriminator 14)
        res->crc = crcu16(retval, res->crc);
     d6c:	0609d583          	lhu	a1,96(s3)
     d70:	8526                	c.mv	a0,s1
     d72:	293050ef          	jal	ra,6804 <crcu16>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:110 (discriminator 14)
        retval &= 0x007f;
     d76:	07f4f593          	andi	a1,s1,127
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:111 (discriminator 14)
        *pdata = (data & 0xff00) | 0x0080 | retval; /* cache the result */
     d7a:	f0047613          	andi	a2,s0,-256
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:109 (discriminator 14)
        res->crc = crcu16(retval, res->crc);
     d7e:	06a99023          	sh	a0,96(s3)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:111 (discriminator 14)
        *pdata = (data & 0xff00) | 0x0080 | retval; /* cache the result */
     d82:	8e4d                	c.or	a2,a1
     d84:	08066613          	ori	a2,a2,128
     d88:	00ca9023          	sh	a2,0(s5)
core_list_mergesort():
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:551 (discriminator 14)
                else if (cmp(p->info, q->info, res) <= 0)
     d8c:	f585f0e3          	bgeu	a1,s8,ccc <EDLM_SIZE+0x284>
     d90:	0400006f          	j	dd0 <EDLM_SIZE+0x388>
calc_func():
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:101 (discriminator 14)
                retval = core_bench_matrix(&(res->mat), dtype, res->crc);
     d94:	0609d603          	lhu	a2,96(s3)
     d98:	6546                	c.ldsp	a0,80(sp)
     d9a:	85ba                	c.mv	a1,a4
     d9c:	6c0020ef          	jal	ra,345c <core_bench_matrix>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:102 (discriminator 14)
                if (res->crcmatrix == 0)
     da0:	0649d583          	lhu	a1,100(s3)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:101 (discriminator 14)
                retval = core_bench_matrix(&(res->mat), dtype, res->crc);
     da4:	00a004b3          	add	s1,zero,a0
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:102 (discriminator 14)
                if (res->crcmatrix == 0)
     da8:	1a058c63          	beqz	a1,f60 <EDLM_SIZE+0x518>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:109 (discriminator 14)
        res->crc = crcu16(retval, res->crc);
     dac:	0609d583          	lhu	a1,96(s3)
     db0:	8526                	c.mv	a0,s1
     db2:	253050ef          	jal	ra,6804 <crcu16>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:110 (discriminator 14)
        retval &= 0x007f;
     db6:	07f4f593          	andi	a1,s1,127
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:111 (discriminator 14)
        *pdata = (data & 0xff00) | 0x0080 | retval; /* cache the result */
     dba:	f0047613          	andi	a2,s0,-256
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:109 (discriminator 14)
        res->crc = crcu16(retval, res->crc);
     dbe:	06a99023          	sh	a0,96(s3)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:111 (discriminator 14)
        *pdata = (data & 0xff00) | 0x0080 | retval; /* cache the result */
     dc2:	8e4d                	c.or	a2,a1
     dc4:	08066613          	ori	a2,a2,128
     dc8:	00ca9023          	sh	a2,0(s5)
core_list_mergesort():
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:551 (discriminator 14)
                else if (cmp(p->info, q->info, res) <= 0)
     dcc:	f185f0e3          	bgeu	a1,s8,ccc <EDLM_SIZE+0x284>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:563 (discriminator 6)
                    q = q->next;
     dd0:	00093403          	ld	s0,0(s2)
     dd4:	8d5e                	c.mv	s10,s7
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:564 (discriminator 6)
                    qsize--;
     dd6:	3b7d                	c.addiw	s6,-1
     dd8:	8bca                	c.mv	s7,s2
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:510
        list = NULL;
     dda:	8c5e                	c.mv	s8,s7
     ddc:	020d9463          	bnez	s11,e04 <EDLM_SIZE+0x3bc>
     de0:	809ff06f          	j	5e8 <core_bench_list+0x31c>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:533 (discriminator 18)
            while (psize > 0 || (qsize > 0 && q))
     de4:	4589                	c.li	a1,2
     de6:	20b54b63          	blt	a0,a1,ffc <EDLM_SIZE+0x5b4>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:510 (discriminator 2)
        list = NULL;
     dea:	8c52                	c.mv	s8,s4
     dec:	01400db3          	add	s11,zero,s4
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:533 (discriminator 18)
            while (psize > 0 || (qsize > 0 && q))
     df0:	f2090c63          	beqz	s2,528 <core_bench_list+0x25c>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:541 (discriminator 10)
                    q = q->next;
     df4:	00093403          	ld	s0,0(s2)
     df8:	4c81                	c.li	s9,0
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:542 (discriminator 10)
                    qsize--;
     dfa:	3b7d                	c.addiw	s6,-1
     dfc:	8bca                	c.mv	s7,s2
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:510
        list = NULL;
     dfe:	8c5e                	c.mv	s8,s7
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:568 (discriminator 16)
                if (tail)
     e00:	fe0d8463          	beqz	s11,5e8 <core_bench_list+0x31c>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:570 (discriminator 6)
                    tail->next = e;
     e04:	017db023          	sd	s7,0(s11)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:510
        list = NULL;
     e08:	01400c33          	add	s8,zero,s4
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:571 (discriminator 6)
                }
     e0c:	fdcff06f          	j	5e8 <core_bench_list+0x31c>
calc_func():
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:103
                    res->crcmatrix = retval;
     e10:	07499223          	sh	s4,100(s3)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:109
        res->crc = crcu16(retval, res->crc);
     e14:	0609d583          	lhu	a1,96(s3)
     e18:	8552                	c.mv	a0,s4
     e1a:	1eb050ef          	jal	ra,6804 <crcu16>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:110
        retval &= 0x007f;
     e1e:	07fa7a13          	andi	s4,s4,127
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:111
        *pdata = (data & 0xff00) | 0x0080 | retval; /* cache the result */
     e22:	f004f593          	andi	a1,s1,-256
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:109
        res->crc = crcu16(retval, res->crc);
     e26:	06a99023          	sh	a0,96(s3)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:111
        *pdata = (data & 0xff00) | 0x0080 | retval; /* cache the result */
     e2a:	0145e5b3          	or	a1,a1,s4
     e2e:	0805e593          	ori	a1,a1,128
     e32:	00ba9023          	sh	a1,0(s5)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:72 (discriminator 2)
    ee_s16 data = *pdata;
     e36:	00095483          	lhu	s1,0(s2)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:77 (discriminator 2)
    if (optype) /* if cached, use cache */
     e3a:	4074f35b          	bbs	s1,7,e40 <EDLM_SIZE+0x3f8>
     e3e:	b8d9                	c.j	714 <core_bench_list+0x448>
     e40:	865ff06f          	j	6a4 <core_bench_list+0x3d8>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:103 (discriminator 2)
                    res->crcmatrix = retval;
     e44:	07599223          	sh	s5,100(s3)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:109 (discriminator 2)
        res->crc = crcu16(retval, res->crc);
     e48:	0609d583          	lhu	a1,96(s3)
     e4c:	8556                	c.mv	a0,s5
     e4e:	1b7050ef          	jal	ra,6804 <crcu16>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:110 (discriminator 2)
        retval &= 0x007f;
     e52:	07faf593          	andi	a1,s5,127
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:111 (discriminator 2)
        *pdata = (data & 0xff00) | 0x0080 | retval; /* cache the result */
     e56:	f004f613          	andi	a2,s1,-256
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:109 (discriminator 2)
        res->crc = crcu16(retval, res->crc);
     e5a:	06a99023          	sh	a0,96(s3)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:111 (discriminator 2)
        *pdata = (data & 0xff00) | 0x0080 | retval; /* cache the result */
     e5e:	8e4d                	c.or	a2,a1
     e60:	08066613          	ori	a2,a2,128
     e64:	00c91023          	sh	a2,0(s2)
core_list_mergesort():
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:551 (discriminator 2)
                else if (cmp(p->info, q->info, res) <= 0)
     e68:	8545f2e3          	bgeu	a1,s4,6ac <core_bench_list+0x3e0>
     e6c:	955ff06f          	j	7c0 <core_bench_list+0x4f4>
calc_func():
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:103 (discriminator 4)
                    res->crcmatrix = retval;
     e70:	07799223          	sh	s7,100(s3)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:109 (discriminator 4)
        res->crc = crcu16(retval, res->crc);
     e74:	0609d583          	lhu	a1,96(s3)
     e78:	855e                	c.mv	a0,s7
     e7a:	18b050ef          	jal	ra,6804 <crcu16>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:110 (discriminator 4)
        retval &= 0x007f;
     e7e:	07fbfb93          	andi	s7,s7,127
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:111 (discriminator 4)
        *pdata = (data & 0xff00) | 0x0080 | retval; /* cache the result */
     e82:	f004f593          	andi	a1,s1,-256
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:109 (discriminator 4)
        res->crc = crcu16(retval, res->crc);
     e86:	06a99023          	sh	a0,96(s3)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:111 (discriminator 4)
        *pdata = (data & 0xff00) | 0x0080 | retval; /* cache the result */
     e8a:	0175e5b3          	or	a1,a1,s7
     e8e:	0805e593          	ori	a1,a1,128
     e92:	00bc1023          	sh	a1,0(s8)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:72 (discriminator 6)
    ee_s16 data = *pdata;
     e96:	000a5483          	lhu	s1,0(s4)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:77 (discriminator 6)
    if (optype) /* if cached, use cache */
     e9a:	4074f35b          	bbs	s1,7,ea0 <EDLM_SIZE+0x458>
     e9e:	bc8d                	c.j	910 <core_bench_list+0x644>
     ea0:	a01ff06f          	j	8a0 <core_bench_list+0x5d4>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:103 (discriminator 6)
                    res->crcmatrix = retval;
     ea4:	07899223          	sh	s8,100(s3)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:109 (discriminator 6)
        res->crc = crcu16(retval, res->crc);
     ea8:	0609d583          	lhu	a1,96(s3)
     eac:	8562                	c.mv	a0,s8
     eae:	157050ef          	jal	ra,6804 <crcu16>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:110 (discriminator 6)
        retval &= 0x007f;
     eb2:	07fc7593          	andi	a1,s8,127
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:111 (discriminator 6)
        *pdata = (data & 0xff00) | 0x0080 | retval; /* cache the result */
     eb6:	f004f613          	andi	a2,s1,-256
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:109 (discriminator 6)
        res->crc = crcu16(retval, res->crc);
     eba:	06a99023          	sh	a0,96(s3)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:111 (discriminator 6)
        *pdata = (data & 0xff00) | 0x0080 | retval; /* cache the result */
     ebe:	8e4d                	c.or	a2,a1
     ec0:	08066613          	ori	a2,a2,128
     ec4:	00ca1023          	sh	a2,0(s4)
core_list_mergesort():
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:551 (discriminator 6)
                else if (cmp(p->info, q->info, res) <= 0)
     ec8:	9f75f0e3          	bgeu	a1,s7,8a8 <core_bench_list+0x5dc>
     ecc:	af1ff06f          	j	9bc <core_bench_list+0x6f0>
calc_func():
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:103 (discriminator 8)
                    res->crcmatrix = retval;
     ed0:	06899223          	sh	s0,100(s3)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:109 (discriminator 8)
        res->crc = crcu16(retval, res->crc);
     ed4:	0609d583          	lhu	a1,96(s3)
     ed8:	8522                	c.mv	a0,s0
     eda:	12b050ef          	jal	ra,6804 <crcu16>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:110 (discriminator 8)
        retval &= 0x007f;
     ede:	07f47b93          	andi	s7,s0,127
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:111 (discriminator 8)
        *pdata = (data & 0xff00) | 0x0080 | retval; /* cache the result */
     ee2:	f004f593          	andi	a1,s1,-256
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:109 (discriminator 8)
        res->crc = crcu16(retval, res->crc);
     ee6:	06a99023          	sh	a0,96(s3)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:111 (discriminator 8)
        *pdata = (data & 0xff00) | 0x0080 | retval; /* cache the result */
     eea:	0175e5b3          	or	a1,a1,s7
     eee:	0805e593          	ori	a1,a1,128
     ef2:	00bd9023          	sh	a1,0(s11)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:72 (discriminator 10)
    ee_s16 data = *pdata;
     ef6:	00095403          	lhu	s0,0(s2)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:77 (discriminator 10)
    if (optype) /* if cached, use cache */
     efa:	4074735b          	bbs	s0,7,f00 <EDLM_SIZE+0x4b8>
     efe:	b10d                	c.j	b20 <EDLM_SIZE+0xd8>
     f00:	bb1ff06f          	j	ab0 <EDLM_SIZE+0x68>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:103 (discriminator 10)
                    res->crcmatrix = retval;
     f04:	06999223          	sh	s1,100(s3)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:109 (discriminator 10)
        res->crc = crcu16(retval, res->crc);
     f08:	0609d583          	lhu	a1,96(s3)
     f0c:	8526                	c.mv	a0,s1
     f0e:	0f7050ef          	jal	ra,6804 <crcu16>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:110 (discriminator 10)
        retval &= 0x007f;
     f12:	07f4f593          	andi	a1,s1,127
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:111 (discriminator 10)
        *pdata = (data & 0xff00) | 0x0080 | retval; /* cache the result */
     f16:	f0047613          	andi	a2,s0,-256
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:109 (discriminator 10)
        res->crc = crcu16(retval, res->crc);
     f1a:	06a99023          	sh	a0,96(s3)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:111 (discriminator 10)
        *pdata = (data & 0xff00) | 0x0080 | retval; /* cache the result */
     f1e:	8e4d                	c.or	a2,a1
     f20:	08066613          	ori	a2,a2,128
     f24:	00c91023          	sh	a2,0(s2)
core_list_mergesort():
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:551 (discriminator 10)
                else if (cmp(p->info, q->info, res) <= 0)
     f28:	b975f8e3          	bgeu	a1,s7,ab8 <EDLM_SIZE+0x70>
     f2c:	ca1ff06f          	j	bcc <EDLM_SIZE+0x184>
calc_func():
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:103 (discriminator 12)
                    res->crcmatrix = retval;
     f30:	06899223          	sh	s0,100(s3)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:109 (discriminator 12)
        res->crc = crcu16(retval, res->crc);
     f34:	0609d583          	lhu	a1,96(s3)
     f38:	8522                	c.mv	a0,s0
     f3a:	0cb050ef          	jal	ra,6804 <crcu16>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:110 (discriminator 12)
        retval &= 0x007f;
     f3e:	07f47c13          	andi	s8,s0,127
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:111 (discriminator 12)
        *pdata = (data & 0xff00) | 0x0080 | retval; /* cache the result */
     f42:	f004f593          	andi	a1,s1,-256
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:109 (discriminator 12)
        res->crc = crcu16(retval, res->crc);
     f46:	06a99023          	sh	a0,96(s3)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:111 (discriminator 12)
        *pdata = (data & 0xff00) | 0x0080 | retval; /* cache the result */
     f4a:	0185e5b3          	or	a1,a1,s8
     f4e:	0805e593          	ori	a1,a1,128
     f52:	00bd1023          	sh	a1,0(s10)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:72 (discriminator 14)
    ee_s16 data = *pdata;
     f56:	000ad403          	lhu	s0,0(s5)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:77 (discriminator 14)
    if (optype) /* if cached, use cache */
     f5a:	9c74755b          	bbc	s0,7,d24 <EDLM_SIZE+0x2dc>
     f5e:	b39d                	c.j	cc4 <EDLM_SIZE+0x27c>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:103 (discriminator 14)
                    res->crcmatrix = retval;
     f60:	06999223          	sh	s1,100(s3)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:109 (discriminator 14)
        res->crc = crcu16(retval, res->crc);
     f64:	0609d583          	lhu	a1,96(s3)
     f68:	8526                	c.mv	a0,s1
     f6a:	09b050ef          	jal	ra,6804 <crcu16>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:110 (discriminator 14)
        retval &= 0x007f;
     f6e:	07f4f593          	andi	a1,s1,127
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:111 (discriminator 14)
        *pdata = (data & 0xff00) | 0x0080 | retval; /* cache the result */
     f72:	f0047613          	andi	a2,s0,-256
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:109 (discriminator 14)
        res->crc = crcu16(retval, res->crc);
     f76:	06a99023          	sh	a0,96(s3)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:111 (discriminator 14)
        *pdata = (data & 0xff00) | 0x0080 | retval; /* cache the result */
     f7a:	8e4d                	c.or	a2,a1
     f7c:	08066613          	ori	a2,a2,128
     f80:	00ca9023          	sh	a2,0(s5)
core_list_mergesort():
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:551 (discriminator 14)
                else if (cmp(p->info, q->info, res) <= 0)
     f84:	d585f4e3          	bgeu	a1,s8,ccc <EDLM_SIZE+0x284>
     f88:	e49ff06f          	j	dd0 <EDLM_SIZE+0x388>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:524 (discriminator 4)
                q = q->next;
     f8c:	8922                	c.mv	s2,s0
     f8e:	8a5e                	c.mv	s4,s7
     f90:	d98ff06f          	j	528 <core_bench_list+0x25c>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:510 (discriminator 2)
        list = NULL;
     f94:	8c4a                	c.mv	s8,s2
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:524 (discriminator 4)
                q = q->next;
     f96:	8956                	c.mv	s2,s5
     f98:	00800a33          	add	s4,zero,s0
     f9c:	d8cff06f          	j	528 <core_bench_list+0x25c>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:510 (discriminator 2)
        list = NULL;
     fa0:	8c4a                	c.mv	s8,s2
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:524 (discriminator 4)
                q = q->next;
     fa2:	8956                	c.mv	s2,s5
     fa4:	00800a33          	add	s4,zero,s0
     fa8:	d80ff06f          	j	528 <core_bench_list+0x25c>
     fac:	8952                	c.mv	s2,s4
     fae:	8a56                	c.mv	s4,s5
     fb0:	d78ff06f          	j	528 <core_bench_list+0x25c>
     fb4:	8952                	c.mv	s2,s4
     fb6:	8a56                	c.mv	s4,s5
     fb8:	d70ff06f          	j	528 <core_bench_list+0x25c>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:510 (discriminator 2)
        list = NULL;
     fbc:	8c52                	c.mv	s8,s4
     fbe:	8a6e                	c.mv	s4,s11
     fc0:	d68ff06f          	j	528 <core_bench_list+0x25c>
     fc4:	8c52                	c.mv	s8,s4
     fc6:	8a6e                	c.mv	s4,s11
     fc8:	d60ff06f          	j	528 <core_bench_list+0x25c>
     fcc:	8c22                	c.mv	s8,s0
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:524 (discriminator 4)
                q = q->next;
     fce:	8956                	c.mv	s2,s5
     fd0:	00800a33          	add	s4,zero,s0
     fd4:	d54ff06f          	j	528 <core_bench_list+0x25c>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:510 (discriminator 2)
        list = NULL;
     fd8:	8c22                	c.mv	s8,s0
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:524 (discriminator 4)
                q = q->next;
     fda:	8956                	c.mv	s2,s5
     fdc:	00800a33          	add	s4,zero,s0
     fe0:	d48ff06f          	j	528 <core_bench_list+0x25c>
     fe4:	8952                	c.mv	s2,s4
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:510 (discriminator 2)
        list = NULL;
     fe6:	8c56                	c.mv	s8,s5
     fe8:	01500a33          	add	s4,zero,s5
     fec:	d3cff06f          	j	528 <core_bench_list+0x25c>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:524 (discriminator 4)
                q = q->next;
     ff0:	8952                	c.mv	s2,s4
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:510 (discriminator 2)
        list = NULL;
     ff2:	8c56                	c.mv	s8,s5
     ff4:	01500a33          	add	s4,zero,s5
     ff8:	d30ff06f          	j	528 <core_bench_list+0x25c>
     ffc:	01400c33          	add	s8,zero,s4
    1000:	d28ff06f          	j	528 <core_bench_list+0x25c>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:515 (discriminator 14)
        while (p)
    1004:	0000006f          	j	1004 <EDLM_SIZE+0x5bc>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:583
        tail->next = NULL;
    1008:	00003023          	sd	zero,0(zero) # 0 <NDS_SAG_LMA_TEXT>
core_bench_list():
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:207
    remover = core_list_remove(list->next);
    100c:	000c3583          	ld	a1,0(s8)
    1010:	002e9693          	slli	a3,t4,0x2
core_list_remove():
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:380
    list_head *ret = item->next;
    1014:	6180                	c.ld	s0,0(a1)
core_bench_list():
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:380
    1016:	41c686b3          	sub	a3,a3,t3
core_list_remove():
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:386
    item->next = item->next->next;
    101a:	6018                	c.ld	a4,0(s0)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:382
    tmp        = item->info;
    101c:	6588                	c.ld	a0,8(a1)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:383
    item->info = ret->info;
    101e:	6410                	c.ld	a2,8(s0)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:386
    item->next = item->next->next;
    1020:	e198                	c.sd	a4,0(a1)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:383
    item->info = ret->info;
    1022:	e590                	c.sd	a2,8(a1)
core_list_find():
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:383
    1024:	001c3593          	seqz	a1,s8
core_bench_list():
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:383
    1028:	00668833          	add	a6,a3,t1
core_list_find():
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:437 (discriminator 2)
    if (info->idx >= 0)
    102c:	3c03b65b          	bfos	a2,t2,15,0
core_list_remove():
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:384
    ret->info  = tmp;
    1030:	e408                	c.sd	a0,8(s0)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:387
    ret->next  = NULL;
    1032:	00043023          	sd	zero,0(s0)
core_list_find():
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:437 (discriminator 2)
    if (info->idx >= 0)
    1036:	08064163          	bltz	a2,10b8 <EDLM_SIZE+0x670>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:439 (discriminator 34)
        while (list && (list->info->idx != info->idx))
    103a:	eded                	c.bnez	a1,1134 <EDLM_SIZE+0x6ec>
    103c:	3c03a5db          	bfoz	a1,t2,15,0
    1040:	018004b3          	add	s1,zero,s8
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:439 (discriminator 36)
    1044:	6490                	c.ld	a2,8(s1)
    1046:	00265603          	lhu	a2,2(a2)
    104a:	0eb60963          	beq	a2,a1,113c <EDLM_SIZE+0x6f4>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:440 (discriminator 16)
            list = list->next;
    104e:	6084                	c.ld	s1,0(s1)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:439 (discriminator 38)
        while (list && (list->info->idx != info->idx))
    1050:	c0f5                	c.beqz	s1,1134 <EDLM_SIZE+0x6ec>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:439 (discriminator 40)
    1052:	6490                	c.ld	a2,8(s1)
    1054:	00265603          	lhu	a2,2(a2)
    1058:	0eb60263          	beq	a2,a1,113c <EDLM_SIZE+0x6f4>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:440 (discriminator 18)
            list = list->next;
    105c:	6084                	c.ld	s1,0(s1)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:439 (discriminator 42)
        while (list && (list->info->idx != info->idx))
    105e:	c8f9                	c.beqz	s1,1134 <EDLM_SIZE+0x6ec>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:439 (discriminator 44)
    1060:	6490                	c.ld	a2,8(s1)
    1062:	00265603          	lhu	a2,2(a2)
    1066:	0cb60b63          	beq	a2,a1,113c <EDLM_SIZE+0x6f4>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:440 (discriminator 20)
            list = list->next;
    106a:	6084                	c.ld	s1,0(s1)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:439 (discriminator 46)
        while (list && (list->info->idx != info->idx))
    106c:	c4e1                	c.beqz	s1,1134 <EDLM_SIZE+0x6ec>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:439 (discriminator 48)
    106e:	6490                	c.ld	a2,8(s1)
    1070:	00265603          	lhu	a2,2(a2)
    1074:	0cb60463          	beq	a2,a1,113c <EDLM_SIZE+0x6f4>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:440 (discriminator 22)
            list = list->next;
    1078:	6084                	c.ld	s1,0(s1)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:439 (discriminator 50)
        while (list && (list->info->idx != info->idx))
    107a:	cccd                	c.beqz	s1,1134 <EDLM_SIZE+0x6ec>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:439 (discriminator 52)
    107c:	6490                	c.ld	a2,8(s1)
    107e:	00265603          	lhu	a2,2(a2)
    1082:	0ab60d63          	beq	a2,a1,113c <EDLM_SIZE+0x6f4>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:440 (discriminator 24)
            list = list->next;
    1086:	6084                	c.ld	s1,0(s1)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:439 (discriminator 54)
        while (list && (list->info->idx != info->idx))
    1088:	c4d5                	c.beqz	s1,1134 <EDLM_SIZE+0x6ec>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:439 (discriminator 56)
    108a:	6490                	c.ld	a2,8(s1)
    108c:	00265603          	lhu	a2,2(a2)
    1090:	0ab60663          	beq	a2,a1,113c <EDLM_SIZE+0x6f4>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:440 (discriminator 26)
            list = list->next;
    1094:	6084                	c.ld	s1,0(s1)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:439 (discriminator 58)
        while (list && (list->info->idx != info->idx))
    1096:	ccd9                	c.beqz	s1,1134 <EDLM_SIZE+0x6ec>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:439 (discriminator 60)
    1098:	6490                	c.ld	a2,8(s1)
    109a:	00265603          	lhu	a2,2(a2)
    109e:	08b60f63          	beq	a2,a1,113c <EDLM_SIZE+0x6f4>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:440 (discriminator 28)
            list = list->next;
    10a2:	6084                	c.ld	s1,0(s1)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:439 (discriminator 62)
        while (list && (list->info->idx != info->idx))
    10a4:	c8c1                	c.beqz	s1,1134 <EDLM_SIZE+0x6ec>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:439 (discriminator 192)
    10a6:	6490                	c.ld	a2,8(s1)
    10a8:	00265603          	lhu	a2,2(a2)
    10ac:	08b60863          	beq	a2,a1,113c <EDLM_SIZE+0x6f4>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:440 (discriminator 30)
            list = list->next;
    10b0:	6084                	c.ld	s1,0(s1)
    10b2:	f8c9                	c.bnez	s1,1044 <EDLM_SIZE+0x5fc>
    10b4:	0800006f          	j	1134 <EDLM_SIZE+0x6ec>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:445 (discriminator 34)
        while (list && ((list->info->data16 & 0xff) != info->data16))
    10b8:	edb5                	c.bnez	a1,1134 <EDLM_SIZE+0x6ec>
    10ba:	65a2                	c.ldsp	a1,8(sp)
    10bc:	018004b3          	add	s1,zero,s8
    10c0:	3c05b5db          	bfos	a1,a1,15,0
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:445 (discriminator 38)
    10c4:	6490                	c.ld	a2,8(s1)
    10c6:	00064603          	lbu	a2,0(a2)
    10ca:	06b60963          	beq	a2,a1,113c <EDLM_SIZE+0x6f4>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:446 (discriminator 16)
            list = list->next;
    10ce:	6084                	c.ld	s1,0(s1)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:445 (discriminator 40)
        while (list && ((list->info->data16 & 0xff) != info->data16))
    10d0:	c0b5                	c.beqz	s1,1134 <EDLM_SIZE+0x6ec>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:445 (discriminator 42)
    10d2:	6490                	c.ld	a2,8(s1)
    10d4:	00064603          	lbu	a2,0(a2)
    10d8:	06b60263          	beq	a2,a1,113c <EDLM_SIZE+0x6f4>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:446 (discriminator 18)
            list = list->next;
    10dc:	6084                	c.ld	s1,0(s1)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:445 (discriminator 44)
        while (list && ((list->info->data16 & 0xff) != info->data16))
    10de:	c8b9                	c.beqz	s1,1134 <EDLM_SIZE+0x6ec>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:445 (discriminator 46)
    10e0:	6490                	c.ld	a2,8(s1)
    10e2:	00064603          	lbu	a2,0(a2)
    10e6:	04b60b63          	beq	a2,a1,113c <EDLM_SIZE+0x6f4>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:446 (discriminator 20)
            list = list->next;
    10ea:	6084                	c.ld	s1,0(s1)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:445 (discriminator 48)
        while (list && ((list->info->data16 & 0xff) != info->data16))
    10ec:	c4a1                	c.beqz	s1,1134 <EDLM_SIZE+0x6ec>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:445 (discriminator 50)
    10ee:	6490                	c.ld	a2,8(s1)
    10f0:	00064603          	lbu	a2,0(a2)
    10f4:	04b60463          	beq	a2,a1,113c <EDLM_SIZE+0x6f4>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:446 (discriminator 22)
            list = list->next;
    10f8:	6084                	c.ld	s1,0(s1)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:445 (discriminator 52)
        while (list && ((list->info->data16 & 0xff) != info->data16))
    10fa:	cc8d                	c.beqz	s1,1134 <EDLM_SIZE+0x6ec>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:445 (discriminator 54)
    10fc:	6490                	c.ld	a2,8(s1)
    10fe:	00064603          	lbu	a2,0(a2)
    1102:	02b60d63          	beq	a2,a1,113c <EDLM_SIZE+0x6f4>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:446 (discriminator 24)
            list = list->next;
    1106:	6084                	c.ld	s1,0(s1)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:445 (discriminator 56)
        while (list && ((list->info->data16 & 0xff) != info->data16))
    1108:	c495                	c.beqz	s1,1134 <EDLM_SIZE+0x6ec>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:445 (discriminator 58)
    110a:	6490                	c.ld	a2,8(s1)
    110c:	00064603          	lbu	a2,0(a2)
    1110:	02b60663          	beq	a2,a1,113c <EDLM_SIZE+0x6f4>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:446 (discriminator 26)
            list = list->next;
    1114:	6084                	c.ld	s1,0(s1)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:445 (discriminator 60)
        while (list && ((list->info->data16 & 0xff) != info->data16))
    1116:	cc99                	c.beqz	s1,1134 <EDLM_SIZE+0x6ec>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:445 (discriminator 62)
    1118:	6490                	c.ld	a2,8(s1)
    111a:	00064603          	lbu	a2,0(a2)
    111e:	00b60f63          	beq	a2,a1,113c <EDLM_SIZE+0x6f4>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:446 (discriminator 28)
            list = list->next;
    1122:	6084                	c.ld	s1,0(s1)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:445 (discriminator 192)
        while (list && ((list->info->data16 & 0xff) != info->data16))
    1124:	c881                	c.beqz	s1,1134 <EDLM_SIZE+0x6ec>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:445 (discriminator 194)
    1126:	6490                	c.ld	a2,8(s1)
    1128:	00064603          	lbu	a2,0(a2)
    112c:	00b60863          	beq	a2,a1,113c <EDLM_SIZE+0x6f4>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:446 (discriminator 30)
            list = list->next;
    1130:	6084                	c.ld	s1,0(s1)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:445 (discriminator 196)
        while (list && ((list->info->data16 & 0xff) != info->data16))
    1132:	f8c9                	c.bnez	s1,10c4 <EDLM_SIZE+0x67c>
core_bench_list():
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:212
        finder = list->next;
    1134:	000c3483          	ld	s1,0(s8)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:213
    while (finder)
    1138:	0a048663          	beqz	s1,11e4 <EDLM_SIZE+0x79c>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:215
        retval = crc16(list->info->data16, retval);
    113c:	008c3503          	ld	a0,8(s8)
    1140:	3c0825db          	bfoz	a1,a6,15,0
    1144:	00051503          	lh	a0,0(a0)
    1148:	27d050ef          	jal	ra,6bc4 <crc16>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:216
        finder = finder->next;
    114c:	6084                	c.ld	s1,0(s1)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:215
        retval = crc16(list->info->data16, retval);
    114e:	882a                	c.mv	a6,a0
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:213 (discriminator 4)
    while (finder)
    1150:	c8c1                	c.beqz	s1,11e0 <EDLM_SIZE+0x798>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:215 (discriminator 4)
        retval = crc16(list->info->data16, retval);
    1152:	008c3503          	ld	a0,8(s8)
    1156:	85c2                	c.mv	a1,a6
    1158:	00051503          	lh	a0,0(a0)
    115c:	269050ef          	jal	ra,6bc4 <crc16>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:216 (discriminator 2)
        finder = finder->next;
    1160:	6084                	c.ld	s1,0(s1)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:215 (discriminator 4)
        retval = crc16(list->info->data16, retval);
    1162:	882a                	c.mv	a6,a0
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:213 (discriminator 6)
    while (finder)
    1164:	ccb5                	c.beqz	s1,11e0 <EDLM_SIZE+0x798>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:215 (discriminator 6)
        retval = crc16(list->info->data16, retval);
    1166:	008c3503          	ld	a0,8(s8)
    116a:	85c2                	c.mv	a1,a6
    116c:	00051503          	lh	a0,0(a0)
    1170:	255050ef          	jal	ra,6bc4 <crc16>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:216 (discriminator 4)
        finder = finder->next;
    1174:	6084                	c.ld	s1,0(s1)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:215 (discriminator 6)
        retval = crc16(list->info->data16, retval);
    1176:	882a                	c.mv	a6,a0
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:213 (discriminator 8)
    while (finder)
    1178:	c4a5                	c.beqz	s1,11e0 <EDLM_SIZE+0x798>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:215 (discriminator 8)
        retval = crc16(list->info->data16, retval);
    117a:	008c3503          	ld	a0,8(s8)
    117e:	85c2                	c.mv	a1,a6
    1180:	00051503          	lh	a0,0(a0)
    1184:	241050ef          	jal	ra,6bc4 <crc16>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:216 (discriminator 6)
        finder = finder->next;
    1188:	6084                	c.ld	s1,0(s1)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:215 (discriminator 8)
        retval = crc16(list->info->data16, retval);
    118a:	882a                	c.mv	a6,a0
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:213 (discriminator 10)
    while (finder)
    118c:	c8b1                	c.beqz	s1,11e0 <EDLM_SIZE+0x798>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:215 (discriminator 10)
        retval = crc16(list->info->data16, retval);
    118e:	008c3503          	ld	a0,8(s8)
    1192:	85c2                	c.mv	a1,a6
    1194:	00051503          	lh	a0,0(a0)
    1198:	22d050ef          	jal	ra,6bc4 <crc16>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:216 (discriminator 8)
        finder = finder->next;
    119c:	6084                	c.ld	s1,0(s1)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:215 (discriminator 10)
        retval = crc16(list->info->data16, retval);
    119e:	882a                	c.mv	a6,a0
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:213 (discriminator 12)
    while (finder)
    11a0:	c0a1                	c.beqz	s1,11e0 <EDLM_SIZE+0x798>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:215 (discriminator 12)
        retval = crc16(list->info->data16, retval);
    11a2:	008c3503          	ld	a0,8(s8)
    11a6:	85c2                	c.mv	a1,a6
    11a8:	00051503          	lh	a0,0(a0)
    11ac:	219050ef          	jal	ra,6bc4 <crc16>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:216 (discriminator 10)
        finder = finder->next;
    11b0:	6084                	c.ld	s1,0(s1)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:215 (discriminator 12)
        retval = crc16(list->info->data16, retval);
    11b2:	882a                	c.mv	a6,a0
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:213 (discriminator 14)
    while (finder)
    11b4:	c495                	c.beqz	s1,11e0 <EDLM_SIZE+0x798>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:215 (discriminator 14)
        retval = crc16(list->info->data16, retval);
    11b6:	008c3503          	ld	a0,8(s8)
    11ba:	85c2                	c.mv	a1,a6
    11bc:	00051503          	lh	a0,0(a0)
    11c0:	205050ef          	jal	ra,6bc4 <crc16>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:216 (discriminator 12)
        finder = finder->next;
    11c4:	6084                	c.ld	s1,0(s1)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:215 (discriminator 14)
        retval = crc16(list->info->data16, retval);
    11c6:	882a                	c.mv	a6,a0
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:213 (discriminator 16)
    while (finder)
    11c8:	cc81                	c.beqz	s1,11e0 <EDLM_SIZE+0x798>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:215 (discriminator 16)
        retval = crc16(list->info->data16, retval);
    11ca:	008c3503          	ld	a0,8(s8)
    11ce:	85c2                	c.mv	a1,a6
    11d0:	00051503          	lh	a0,0(a0)
    11d4:	1f1050ef          	jal	ra,6bc4 <crc16>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:216 (discriminator 14)
        finder = finder->next;
    11d8:	6084                	c.ld	s1,0(s1)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:215 (discriminator 16)
        retval = crc16(list->info->data16, retval);
    11da:	882a                	c.mv	a6,a0
    11dc:	f0a5                	c.bnez	s1,113c <EDLM_SIZE+0x6f4>
    11de:	a009                	c.j	11e0 <EDLM_SIZE+0x798>
core_list_undo_remove():
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:412
    tmp                 = item_removed->info;
    11e0:	6408                	c.ld	a0,8(s0)
core_bench_list():
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:412
    11e2:	0001                	c.nop
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:221 (discriminator 2)
    remover = core_list_undo_remove(remover, list->next);
    11e4:	000c3583          	ld	a1,0(s8)
    11e8:	4285                	c.li	t0,1
core_list_undo_remove():
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:413
    item_removed->info  = item_modified->info;
    11ea:	6590                	c.ld	a2,8(a1)
    11ec:	4889                	c.li	a7,2
    11ee:	e410                	c.sd	a2,8(s0)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:416
    item_removed->next  = item_modified->next;
    11f0:	6190                	c.ld	a2,0(a1)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:414
    item_modified->info = tmp;
    11f2:	e588                	c.sd	a0,8(a1)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:416
    item_removed->next  = item_modified->next;
    11f4:	e010                	c.sd	a2,0(s0)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:417
    item_modified->next = item_removed;
    11f6:	e180                	c.sd	s0,0(a1)
    11f8:	0140006f          	j	120c <EDLM_SIZE+0x7c4>
core_list_mergesort():
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:586 (discriminator 4)
        if (nmerges <= 1) /* allow for nmerges==0, the empty list case */
    11fc:	0003851b          	sext.w	a0,t2
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:590 (discriminator 2)
        insize *= 2;
    1200:	0012929b          	slliw	t0,t0,0x1
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:583 (discriminator 6)
        tail->next = NULL;
    1204:	0004b023          	sd	zero,0(s1)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:586 (discriminator 4)
        if (nmerges <= 1) /* allow for nmerges==0, the empty list case */
    1208:	36050c63          	beqz	a0,1580 <EDLM_SIZE+0xb38>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:515 (discriminator 6)
        while (p)
    120c:	340c0663          	beqz	s8,1558 <EDLM_SIZE+0xb10>
    1210:	00028e1b          	sext.w	t3,t0
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:515 (discriminator 8)
    1214:	35c05063          	blez	t3,1554 <EDLM_SIZE+0xb0c>
    1218:	8fe2                	c.mv	t6,s8
    121a:	4301                	c.li	t1,0
    121c:	4481                	c.li	s1,0
    121e:	4c01                	c.li	s8,0
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:515
    1220:	00c0006f          	j	122c <EDLM_SIZE+0x7e4>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:524 (discriminator 24)
                q = q->next;
    1224:	8726                	c.mv	a4,s1
    1226:	84f6                	c.mv	s1,t4
    1228:	8fba                	c.mv	t6,a4
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:515 (discriminator 10)
        while (p)
    122a:	db69                	c.beqz	a4,11fc <EDLM_SIZE+0x7b4>
    122c:	839a                	c.mv	t2,t1
    122e:	8ea6                	c.mv	t4,s1
    1230:	4581                	c.li	a1,0
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:517 (discriminator 2)
            nmerges++; /* there exists a merge to be done */
    1232:	2305                	c.addiw	t1,1
    1234:	01f004b3          	add	s1,zero,t6
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:521 (discriminator 38)
            for (i = 0; i < insize; i++)
    1238:	0015e513          	ori	a0,a1,1
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:524 (discriminator 20)
                q = q->next;
    123c:	6084                	c.ld	s1,0(s1)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:521 (discriminator 38)
            for (i = 0; i < insize; i++)
    123e:	2501                	c.addiw	a0,0
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:525 (discriminator 16)
                if (!q)
    1240:	c4a5                	c.beqz	s1,12a8 <EDLM_SIZE+0x860>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:521 (discriminator 36)
            for (i = 0; i < insize; i++)
    1242:	07c55563          	bge	a0,t3,12ac <EDLM_SIZE+0x864>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:521 (discriminator 40)
    1246:	0025e513          	ori	a0,a1,2
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:524 (discriminator 26)
                q = q->next;
    124a:	6084                	c.ld	s1,0(s1)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:521 (discriminator 40)
            for (i = 0; i < insize; i++)
    124c:	2501                	c.addiw	a0,0
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:525 (discriminator 18)
                if (!q)
    124e:	ccbd                	c.beqz	s1,12cc <EDLM_SIZE+0x884>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:521 (discriminator 42)
            for (i = 0; i < insize; i++)
    1250:	07c55063          	bge	a0,t3,12b0 <EDLM_SIZE+0x868>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:521 (discriminator 44)
    1254:	0035e513          	ori	a0,a1,3
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:524 (discriminator 28)
                q = q->next;
    1258:	6084                	c.ld	s1,0(s1)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:521 (discriminator 44)
            for (i = 0; i < insize; i++)
    125a:	2501                	c.addiw	a0,0
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:525 (discriminator 20)
                if (!q)
    125c:	c8a5                	c.beqz	s1,12cc <EDLM_SIZE+0x884>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:521 (discriminator 46)
            for (i = 0; i < insize; i++)
    125e:	05c55b63          	bge	a0,t3,12b4 <EDLM_SIZE+0x86c>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:521 (discriminator 48)
    1262:	0045e513          	ori	a0,a1,4
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:524 (discriminator 30)
                q = q->next;
    1266:	6084                	c.ld	s1,0(s1)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:521 (discriminator 48)
            for (i = 0; i < insize; i++)
    1268:	2501                	c.addiw	a0,0
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:525 (discriminator 22)
                if (!q)
    126a:	c0ad                	c.beqz	s1,12cc <EDLM_SIZE+0x884>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:521 (discriminator 50)
            for (i = 0; i < insize; i++)
    126c:	05c55663          	bge	a0,t3,12b8 <EDLM_SIZE+0x870>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:521 (discriminator 52)
    1270:	0055e513          	ori	a0,a1,5
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:524 (discriminator 32)
                q = q->next;
    1274:	6084                	c.ld	s1,0(s1)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:521 (discriminator 52)
            for (i = 0; i < insize; i++)
    1276:	2501                	c.addiw	a0,0
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:525 (discriminator 24)
                if (!q)
    1278:	c8b1                	c.beqz	s1,12cc <EDLM_SIZE+0x884>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:521 (discriminator 54)
            for (i = 0; i < insize; i++)
    127a:	05c55163          	bge	a0,t3,12bc <EDLM_SIZE+0x874>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:521 (discriminator 56)
    127e:	0065e513          	ori	a0,a1,6
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:524 (discriminator 34)
                q = q->next;
    1282:	6084                	c.ld	s1,0(s1)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:521 (discriminator 56)
            for (i = 0; i < insize; i++)
    1284:	2501                	c.addiw	a0,0
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:525 (discriminator 26)
                if (!q)
    1286:	c0b9                	c.beqz	s1,12cc <EDLM_SIZE+0x884>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:521 (discriminator 58)
            for (i = 0; i < insize; i++)
    1288:	03c55c63          	bge	a0,t3,12c0 <EDLM_SIZE+0x878>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:521 (discriminator 60)
    128c:	0075e513          	ori	a0,a1,7
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:524 (discriminator 36)
                q = q->next;
    1290:	6084                	c.ld	s1,0(s1)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:521 (discriminator 60)
            for (i = 0; i < insize; i++)
    1292:	2501                	c.addiw	a0,0
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:525 (discriminator 28)
                if (!q)
    1294:	cc85                	c.beqz	s1,12cc <EDLM_SIZE+0x884>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:521 (discriminator 62)
            for (i = 0; i < insize; i++)
    1296:	03c55763          	bge	a0,t3,12c4 <EDLM_SIZE+0x87c>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:524 (discriminator 38)
                q = q->next;
    129a:	6084                	c.ld	s1,0(s1)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:521 (discriminator 192)
            for (i = 0; i < insize; i++)
    129c:	25a1                	c.addiw	a1,8
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:525 (discriminator 30)
                if (!q)
    129e:	c48d                	c.beqz	s1,12c8 <EDLM_SIZE+0x880>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:521 (discriminator 194)
            for (i = 0; i < insize; i++)
    12a0:	f9c5cce3          	blt	a1,t3,1238 <EDLM_SIZE+0x7f0>
    12a4:	8516                	c.mv	a0,t0
    12a6:	a01d                	c.j	12cc <EDLM_SIZE+0x884>
    12a8:	0240006f          	j	12cc <EDLM_SIZE+0x884>
    12ac:	8516                	c.mv	a0,t0
    12ae:	a839                	c.j	12cc <EDLM_SIZE+0x884>
    12b0:	8516                	c.mv	a0,t0
    12b2:	a829                	c.j	12cc <EDLM_SIZE+0x884>
    12b4:	8516                	c.mv	a0,t0
    12b6:	a819                	c.j	12cc <EDLM_SIZE+0x884>
    12b8:	8516                	c.mv	a0,t0
    12ba:	a809                	c.j	12cc <EDLM_SIZE+0x884>
    12bc:	8516                	c.mv	a0,t0
    12be:	a039                	c.j	12cc <EDLM_SIZE+0x884>
    12c0:	8516                	c.mv	a0,t0
    12c2:	a029                	c.j	12cc <EDLM_SIZE+0x884>
    12c4:	8516                	c.mv	a0,t0
    12c6:	a019                	c.j	12cc <EDLM_SIZE+0x884>
    12c8:	00b00533          	add	a0,zero,a1
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:530 (discriminator 2)
            qsize = insize;
    12cc:	00500f33          	add	t5,zero,t0
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:533 (discriminator 26)
            while (psize > 0 || (qsize > 0 && q))
    12d0:	0005061b          	sext.w	a2,a0
    12d4:	000f059b          	sext.w	a1,t5
    12d8:	00c04663          	bgtz	a2,12e4 <EDLM_SIZE+0x89c>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:533 (discriminator 28)
    12dc:	d4a1                	c.beqz	s1,1224 <EDLM_SIZE+0x7dc>
    12de:	22b05d63          	blez	a1,1518 <EDLM_SIZE+0xad0>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:537 (discriminator 8)
                if (psize == 0)
    12e2:	ca59                	c.beqz	a2,1378 <EDLM_SIZE+0x930>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:544 (discriminator 8)
                else if (qsize == 0 || !q)
    12e4:	cc95                	c.beqz	s1,1320 <EDLM_SIZE+0x8d8>
    12e6:	cd8d                	c.beqz	a1,1320 <EDLM_SIZE+0x8d8>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:551 (discriminator 16)
                else if (cmp(p->info, q->info, res) <= 0)
    12e8:	008fb583          	ld	a1,8(t6)
    12ec:	6494                	c.ld	a3,8(s1)
cmp_idx():
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:138
        a->data16 = (a->data16 & 0xff00) | (0x00ff & (a->data16 >> 8));
    12ee:	00158603          	lb	a2,1(a1)
    12f2:	00c58023          	sb	a2,0(a1)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:139
        b->data16 = (b->data16 & 0xff00) | (0x00ff & (b->data16 >> 8));
    12f6:	00168603          	lb	a2,1(a3)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:141
    return a->idx - b->idx;
    12fa:	00269703          	lh	a4,2(a3)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:139
        b->data16 = (b->data16 & 0xff00) | (0x00ff & (b->data16 >> 8));
    12fe:	00c68023          	sb	a2,0(a3)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:141
    return a->idx - b->idx;
    1302:	00259583          	lh	a1,2(a1)
core_list_mergesort():
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:551 (discriminator 16)
                else if (cmp(p->info, q->info, res) <= 0)
    1306:	02b75f63          	bge	a4,a1,1344 <EDLM_SIZE+0x8fc>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:563 (discriminator 8)
                    q = q->next;
    130a:	6098                	c.ld	a4,0(s1)
    130c:	85fe                	c.mv	a1,t6
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:564 (discriminator 8)
                    qsize--;
    130e:	3f7d                	c.addiw	t5,-1
    1310:	8fa6                	c.mv	t6,s1
    1312:	84fe                	c.mv	s1,t6
    1314:	8fae                	c.mv	t6,a1
    1316:	86a6                	c.mv	a3,s1
    1318:	040e9063          	bnez	t4,1358 <EDLM_SIZE+0x910>
    131c:	0180006f          	j	1334 <EDLM_SIZE+0x8ec>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:548 (discriminator 8)
                    p = p->next;
    1320:	000fb583          	ld	a1,0(t6)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:549 (discriminator 8)
                    psize--;
    1324:	357d                	c.addiw	a0,-1
    1326:	8726                	c.mv	a4,s1
    1328:	84fe                	c.mv	s1,t6
    132a:	8fae                	c.mv	t6,a1
    132c:	009006b3          	add	a3,zero,s1
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:568 (discriminator 20)
                if (tail)
    1330:	020e9463          	bnez	t4,1358 <EDLM_SIZE+0x910>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:533 (discriminator 32)
            while (psize > 0 || (qsize > 0 && q))
    1334:	0005059b          	sext.w	a1,a0
    1338:	000f061b          	sext.w	a2,t5
    133c:	04b04e63          	bgtz	a1,1398 <EDLM_SIZE+0x950>
    1340:	02c0006f          	j	136c <EDLM_SIZE+0x924>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:556 (discriminator 8)
                    p = p->next;
    1344:	000fb583          	ld	a1,0(t6)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:557 (discriminator 8)
                    psize--;
    1348:	357d                	c.addiw	a0,-1
    134a:	8726                	c.mv	a4,s1
    134c:	84fe                	c.mv	s1,t6
    134e:	8fae                	c.mv	t6,a1
    1350:	009006b3          	add	a3,zero,s1
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:568 (discriminator 20)
                if (tail)
    1354:	fe0e80e3          	beqz	t4,1334 <EDLM_SIZE+0x8ec>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:570 (discriminator 8)
                    tail->next = e;
    1358:	009eb023          	sd	s1,0(t4)
    135c:	86a6                	c.mv	a3,s1
    135e:	84e2                	c.mv	s1,s8
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:533 (discriminator 32)
            while (psize > 0 || (qsize > 0 && q))
    1360:	0005059b          	sext.w	a1,a0
    1364:	000f061b          	sext.w	a2,t5
    1368:	02b04863          	bgtz	a1,1398 <EDLM_SIZE+0x950>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:533 (discriminator 34)
    136c:	1cc05a63          	blez	a2,1540 <EDLM_SIZE+0xaf8>
    1370:	1c070c63          	beqz	a4,1548 <EDLM_SIZE+0xb00>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:537 (discriminator 10)
                if (psize == 0)
    1374:	e195                	c.bnez	a1,1398 <EDLM_SIZE+0x950>
    1376:	a279                	c.j	1504 <EDLM_SIZE+0xabc>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:541 (discriminator 12)
                    q = q->next;
    1378:	6098                	c.ld	a4,0(s1)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:542 (discriminator 12)
                    qsize--;
    137a:	3f7d                	c.addiw	t5,-1
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:568 (discriminator 18)
                if (tail)
    137c:	160e8e63          	beqz	t4,14f8 <EDLM_SIZE+0xab0>
    1380:	4501                	c.li	a0,0
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:570 (discriminator 8)
                    tail->next = e;
    1382:	009eb023          	sd	s1,0(t4)
    1386:	86a6                	c.mv	a3,s1
    1388:	018004b3          	add	s1,zero,s8
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:533 (discriminator 32)
            while (psize > 0 || (qsize > 0 && q))
    138c:	0005059b          	sext.w	a1,a0
    1390:	000f061b          	sext.w	a2,t5
    1394:	fcb05ce3          	blez	a1,136c <EDLM_SIZE+0x924>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:544 (discriminator 10)
                else if (qsize == 0 || !q)
    1398:	ca15                	c.beqz	a2,13cc <EDLM_SIZE+0x984>
    139a:	cb0d                	c.beqz	a4,13cc <EDLM_SIZE+0x984>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:551 (discriminator 18)
                else if (cmp(p->info, q->info, res) <= 0)
    139c:	008fb583          	ld	a1,8(t6)
    13a0:	6700                	c.ld	s0,8(a4)
cmp_idx():
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:138 (discriminator 2)
        a->data16 = (a->data16 & 0xff00) | (0x00ff & (a->data16 >> 8));
    13a2:	00158603          	lb	a2,1(a1)
    13a6:	00c58023          	sb	a2,0(a1)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:139 (discriminator 2)
        b->data16 = (b->data16 & 0xff00) | (0x00ff & (b->data16 >> 8));
    13aa:	00140603          	lb	a2,1(s0)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:141 (discriminator 2)
    return a->idx - b->idx;
    13ae:	00241783          	lh	a5,2(s0)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:139 (discriminator 2)
        b->data16 = (b->data16 & 0xff00) | (0x00ff & (b->data16 >> 8));
    13b2:	00c40023          	sb	a2,0(s0)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:141 (discriminator 2)
    return a->idx - b->idx;
    13b6:	00259583          	lh	a1,2(a1)
core_list_mergesort():
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:551 (discriminator 18)
                else if (cmp(p->info, q->info, res) <= 0)
    13ba:	02b7d163          	bge	a5,a1,13dc <EDLM_SIZE+0x994>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:563 (discriminator 10)
                    q = q->next;
    13be:	630c                	c.ld	a1,0(a4)
    13c0:	867e                	c.mv	a2,t6
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:564 (discriminator 10)
                    qsize--;
    13c2:	3f7d                	c.addiw	t5,-1
    13c4:	8fba                	c.mv	t6,a4
    13c6:	8c7e                	c.mv	s8,t6
    13c8:	e285                	c.bnez	a3,13e8 <EDLM_SIZE+0x9a0>
    13ca:	a01d                	c.j	13f0 <EDLM_SIZE+0x9a8>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:548 (discriminator 10)
                    p = p->next;
    13cc:	000fb603          	ld	a2,0(t6)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:549 (discriminator 10)
                    psize--;
    13d0:	357d                	c.addiw	a0,-1
    13d2:	85ba                	c.mv	a1,a4
    13d4:	8c7e                	c.mv	s8,t6
    13d6:	ea89                	c.bnez	a3,13e8 <EDLM_SIZE+0x9a0>
    13d8:	0180006f          	j	13f0 <EDLM_SIZE+0x9a8>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:556 (discriminator 10)
                    p = p->next;
    13dc:	000fb603          	ld	a2,0(t6)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:557 (discriminator 10)
                    psize--;
    13e0:	357d                	c.addiw	a0,-1
    13e2:	85ba                	c.mv	a1,a4
    13e4:	8c7e                	c.mv	s8,t6
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:568 (discriminator 22)
                if (tail)
    13e6:	c689                	c.beqz	a3,13f0 <EDLM_SIZE+0x9a8>
    13e8:	00900c33          	add	s8,zero,s1
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:570 (discriminator 10)
                    tail->next = e;
    13ec:	01f6b023          	sd	t6,0(a3)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:533 (discriminator 36)
            while (psize > 0 || (qsize > 0 && q))
    13f0:	0005071b          	sext.w	a4,a0
    13f4:	000f069b          	sext.w	a3,t5
    13f8:	00e04863          	bgtz	a4,1408 <EDLM_SIZE+0x9c0>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:533 (discriminator 38)
    13fc:	12058263          	beqz	a1,1520 <EDLM_SIZE+0xad8>
    1400:	12d05463          	blez	a3,1528 <EDLM_SIZE+0xae0>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:537 (discriminator 12)
                if (psize == 0)
    1404:	0c070463          	beqz	a4,14cc <EDLM_SIZE+0xa84>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:544 (discriminator 12)
                else if (qsize == 0 || !q)
    1408:	c995                	c.beqz	a1,143c <EDLM_SIZE+0x9f4>
    140a:	ca8d                	c.beqz	a3,143c <EDLM_SIZE+0x9f4>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:551 (discriminator 20)
                else if (cmp(p->info, q->info, res) <= 0)
    140c:	6614                	c.ld	a3,8(a2)
    140e:	659c                	c.ld	a5,8(a1)
cmp_idx():
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:138 (discriminator 4)
        a->data16 = (a->data16 & 0xff00) | (0x00ff & (a->data16 >> 8));
    1410:	00168703          	lb	a4,1(a3)
    1414:	00e68023          	sb	a4,0(a3)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:139 (discriminator 4)
        b->data16 = (b->data16 & 0xff00) | (0x00ff & (b->data16 >> 8));
    1418:	00178703          	lb	a4,1(a5)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:141 (discriminator 4)
    return a->idx - b->idx;
    141c:	00279483          	lh	s1,2(a5)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:139 (discriminator 4)
        b->data16 = (b->data16 & 0xff00) | (0x00ff & (b->data16 >> 8));
    1420:	00e78023          	sb	a4,0(a5)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:141 (discriminator 4)
    return a->idx - b->idx;
    1424:	00269683          	lh	a3,2(a3)
core_list_mergesort():
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:551 (discriminator 20)
                else if (cmp(p->info, q->info, res) <= 0)
    1428:	02d4d263          	bge	s1,a3,144c <EDLM_SIZE+0xa04>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:563 (discriminator 12)
                    q = q->next;
    142c:	6198                	c.ld	a4,0(a1)
    142e:	8eb2                	c.mv	t4,a2
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:564 (discriminator 12)
                    qsize--;
    1430:	3f7d                	c.addiw	t5,-1
    1432:	862e                	c.mv	a2,a1
    1434:	85b2                	c.mv	a1,a2
    1436:	020f9363          	bnez	t6,145c <EDLM_SIZE+0xa14>
    143a:	a02d                	c.j	1464 <EDLM_SIZE+0xa1c>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:548 (discriminator 12)
                    p = p->next;
    143c:	00063e83          	ld	t4,0(a2)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:549 (discriminator 12)
                    psize--;
    1440:	357d                	c.addiw	a0,-1
    1442:	872e                	c.mv	a4,a1
    1444:	85b2                	c.mv	a1,a2
    1446:	000f9b63          	bnez	t6,145c <EDLM_SIZE+0xa14>
    144a:	a829                	c.j	1464 <EDLM_SIZE+0xa1c>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:556 (discriminator 12)
                    p = p->next;
    144c:	00063e83          	ld	t4,0(a2)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:557 (discriminator 12)
                    psize--;
    1450:	357d                	c.addiw	a0,-1
    1452:	872e                	c.mv	a4,a1
    1454:	00c005b3          	add	a1,zero,a2
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:568 (discriminator 24)
                if (tail)
    1458:	000f8663          	beqz	t6,1464 <EDLM_SIZE+0xa1c>
    145c:	018005b3          	add	a1,zero,s8
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:570 (discriminator 12)
                    tail->next = e;
    1460:	00cfb023          	sd	a2,0(t6)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:533 (discriminator 40)
            while (psize > 0 || (qsize > 0 && q))
    1464:	0005079b          	sext.w	a5,a0
    1468:	000f069b          	sext.w	a3,t5
    146c:	00f04663          	bgtz	a5,1478 <EDLM_SIZE+0xa30>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:533 (discriminator 42)
    1470:	c361                	c.beqz	a4,1530 <EDLM_SIZE+0xae8>
    1472:	0cd05363          	blez	a3,1538 <EDLM_SIZE+0xaf0>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:537 (discriminator 14)
                if (psize == 0)
    1476:	c7ad                	c.beqz	a5,14e0 <EDLM_SIZE+0xa98>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:544 (discriminator 14)
                else if (qsize == 0 || !q)
    1478:	cb15                	c.beqz	a4,14ac <EDLM_SIZE+0xa64>
    147a:	ca8d                	c.beqz	a3,14ac <EDLM_SIZE+0xa64>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:551 (discriminator 22)
                else if (cmp(p->info, q->info, res) <= 0)
    147c:	008eb683          	ld	a3,8(t4)
    1480:	6704                	c.ld	s1,8(a4)
cmp_idx():
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:138 (discriminator 6)
        a->data16 = (a->data16 & 0xff00) | (0x00ff & (a->data16 >> 8));
    1482:	00168783          	lb	a5,1(a3)
    1486:	00f68023          	sb	a5,0(a3)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:139 (discriminator 6)
        b->data16 = (b->data16 & 0xff00) | (0x00ff & (b->data16 >> 8));
    148a:	00148783          	lb	a5,1(s1)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:141 (discriminator 6)
    return a->idx - b->idx;
    148e:	00249403          	lh	s0,2(s1)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:139 (discriminator 6)
        b->data16 = (b->data16 & 0xff00) | (0x00ff & (b->data16 >> 8));
    1492:	00f48023          	sb	a5,0(s1)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:141 (discriminator 6)
    return a->idx - b->idx;
    1496:	00269683          	lh	a3,2(a3)
core_list_mergesort():
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:551 (discriminator 22)
                else if (cmp(p->info, q->info, res) <= 0)
    149a:	02d45163          	bge	s0,a3,14bc <EDLM_SIZE+0xa74>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:563 (discriminator 14)
                    q = q->next;
    149e:	6304                	c.ld	s1,0(a4)
    14a0:	8ff6                	c.mv	t6,t4
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:564 (discriminator 14)
                    qsize--;
    14a2:	3f7d                	c.addiw	t5,-1
    14a4:	8eba                	c.mv	t4,a4
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:510 (discriminator 4)
        list = NULL;
    14a6:	8c76                	c.mv	s8,t4
    14a8:	e621                	c.bnez	a2,14f0 <EDLM_SIZE+0xaa8>
    14aa:	b51d                	c.j	12d0 <EDLM_SIZE+0x888>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:548 (discriminator 14)
                    p = p->next;
    14ac:	000ebf83          	ld	t6,0(t4)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:549 (discriminator 14)
                    psize--;
    14b0:	357d                	c.addiw	a0,-1
    14b2:	84ba                	c.mv	s1,a4
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:510 (discriminator 4)
        list = NULL;
    14b4:	8c76                	c.mv	s8,t4
    14b6:	ee0d                	c.bnez	a2,14f0 <EDLM_SIZE+0xaa8>
    14b8:	e19ff06f          	j	12d0 <EDLM_SIZE+0x888>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:556 (discriminator 14)
                    p = p->next;
    14bc:	000ebf83          	ld	t6,0(t4)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:557 (discriminator 14)
                    psize--;
    14c0:	357d                	c.addiw	a0,-1
    14c2:	84ba                	c.mv	s1,a4
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:510 (discriminator 4)
        list = NULL;
    14c4:	8c76                	c.mv	s8,t4
    14c6:	e60d                	c.bnez	a2,14f0 <EDLM_SIZE+0xaa8>
    14c8:	e09ff06f          	j	12d0 <EDLM_SIZE+0x888>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:541 (discriminator 16)
                    q = q->next;
    14cc:	6198                	c.ld	a4,0(a1)
    14ce:	8eb2                	c.mv	t4,a2
    14d0:	4501                	c.li	a0,0
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:542 (discriminator 16)
                    qsize--;
    14d2:	3f7d                	c.addiw	t5,-1
    14d4:	862e                	c.mv	a2,a1
    14d6:	85b2                	c.mv	a1,a2
    14d8:	f80f92e3          	bnez	t6,145c <EDLM_SIZE+0xa14>
    14dc:	f89ff06f          	j	1464 <EDLM_SIZE+0xa1c>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:541 (discriminator 18)
                    q = q->next;
    14e0:	6304                	c.ld	s1,0(a4)
    14e2:	8ff6                	c.mv	t6,t4
    14e4:	4501                	c.li	a0,0
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:542 (discriminator 18)
                    qsize--;
    14e6:	3f7d                	c.addiw	t5,-1
    14e8:	8eba                	c.mv	t4,a4
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:510 (discriminator 4)
        list = NULL;
    14ea:	8c76                	c.mv	s8,t4
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:568 (discriminator 26)
                if (tail)
    14ec:	de0602e3          	beqz	a2,12d0 <EDLM_SIZE+0x888>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:570 (discriminator 14)
                    tail->next = e;
    14f0:	01d63023          	sd	t4,0(a2)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:510 (discriminator 4)
        list = NULL;
    14f4:	8c2e                	c.mv	s8,a1
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:571 (discriminator 14)
                }
    14f6:	bbe9                	c.j	12d0 <EDLM_SIZE+0x888>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:533 (discriminator 30)
            while (psize > 0 || (qsize > 0 && q))
    14f8:	0515cc63          	blt	a1,a7,1550 <EDLM_SIZE+0xb08>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:510 (discriminator 6)
        list = NULL;
    14fc:	8c26                	c.mv	s8,s1
    14fe:	86a6                	c.mv	a3,s1
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:533 (discriminator 30)
            while (psize > 0 || (qsize > 0 && q))
    1500:	d20704e3          	beqz	a4,1228 <EDLM_SIZE+0x7e0>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:541 (discriminator 14)
                    q = q->next;
    1504:	630c                	c.ld	a1,0(a4)
    1506:	867e                	c.mv	a2,t6
    1508:	4501                	c.li	a0,0
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:542 (discriminator 14)
                    qsize--;
    150a:	3f7d                	c.addiw	t5,-1
    150c:	8fba                	c.mv	t6,a4
    150e:	8c7e                	c.mv	s8,t6
    1510:	ec069ce3          	bnez	a3,13e8 <EDLM_SIZE+0x9a0>
    1514:	eddff06f          	j	13f0 <EDLM_SIZE+0x9a8>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:524 (discriminator 24)
                q = q->next;
    1518:	8726                	c.mv	a4,s1
    151a:	84f6                	c.mv	s1,t4
    151c:	d0dff06f          	j	1228 <EDLM_SIZE+0x7e0>
    1520:	872e                	c.mv	a4,a1
    1522:	84fe                	c.mv	s1,t6
    1524:	d05ff06f          	j	1228 <EDLM_SIZE+0x7e0>
    1528:	872e                	c.mv	a4,a1
    152a:	84fe                	c.mv	s1,t6
    152c:	cfdff06f          	j	1228 <EDLM_SIZE+0x7e0>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:510 (discriminator 6)
        list = NULL;
    1530:	8c2e                	c.mv	s8,a1
    1532:	84b2                	c.mv	s1,a2
    1534:	cf5ff06f          	j	1228 <EDLM_SIZE+0x7e0>
    1538:	8c2e                	c.mv	s8,a1
    153a:	84b2                	c.mv	s1,a2
    153c:	cedff06f          	j	1228 <EDLM_SIZE+0x7e0>
    1540:	8c26                	c.mv	s8,s1
    1542:	84b6                	c.mv	s1,a3
    1544:	ce5ff06f          	j	1228 <EDLM_SIZE+0x7e0>
    1548:	8c26                	c.mv	s8,s1
    154a:	84b6                	c.mv	s1,a3
    154c:	cddff06f          	j	1228 <EDLM_SIZE+0x7e0>
    1550:	8c26                	c.mv	s8,s1
    1552:	b9d9                	c.j	1228 <EDLM_SIZE+0x7e0>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:515 (discriminator 12)
        while (p)
    1554:	0000006f          	j	1554 <EDLM_SIZE+0xb0c>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:583 (discriminator 4)
        tail->next = NULL;
    1558:	00003023          	sd	zero,0(zero) # 0 <NDS_SAG_LMA_TEXT>
core_bench_list():
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:234
    return retval;
    155c:	6de6                	c.ldsp	s11,88(sp)
    155e:	7d06                	c.ldsp	s10,96(sp)
    1560:	7ca6                	c.ldsp	s9,104(sp)
    1562:	7c46                	c.ldsp	s8,112(sp)
    1564:	7be6                	c.ldsp	s7,120(sp)
    1566:	6b0a                	c.ldsp	s6,128(sp)
    1568:	6aaa                	c.ldsp	s5,136(sp)
    156a:	6a4a                	c.ldsp	s4,144(sp)
    156c:	69ea                	c.ldsp	s3,152(sp)
    156e:	790a                	c.ldsp	s2,160(sp)
    1570:	74aa                	c.ldsp	s1,168(sp)
    1572:	744a                	c.ldsp	s0,176(sp)
    1574:	70ea                	c.ldsp	ra,184(sp)
    1576:	3c08255b          	bfoz	a0,a6,15,0
    157a:	6129                	c.addi16sp	sp,192
    157c:	00008067          	ret
    1580:	000c3403          	ld	s0,0(s8)
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:226 (discriminator 2)
    while (finder)
    1584:	fc040ce3          	beqz	s0,155c <EDLM_SIZE+0xb14>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:228
        retval = crc16(list->info->data16, retval);
    1588:	008c3503          	ld	a0,8(s8)
    158c:	3c0825db          	bfoz	a1,a6,15,0
    1590:	00051503          	lh	a0,0(a0)
    1594:	630050ef          	jal	ra,6bc4 <crc16>
    1598:	6000                	c.ld	s0,0(s0)
    159a:	882a                	c.mv	a6,a0
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:226 (discriminator 6)
    while (finder)
    159c:	c841                	c.beqz	s0,162c <EDLM_SIZE+0xbe4>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:228 (discriminator 2)
        retval = crc16(list->info->data16, retval);
    159e:	008c3503          	ld	a0,8(s8)
    15a2:	85c2                	c.mv	a1,a6
    15a4:	00051503          	lh	a0,0(a0)
    15a8:	61c050ef          	jal	ra,6bc4 <crc16>
    15ac:	6000                	c.ld	s0,0(s0)
    15ae:	882a                	c.mv	a6,a0
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:226 (discriminator 8)
    while (finder)
    15b0:	d455                	c.beqz	s0,155c <EDLM_SIZE+0xb14>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:228 (discriminator 4)
        retval = crc16(list->info->data16, retval);
    15b2:	008c3503          	ld	a0,8(s8)
    15b6:	85c2                	c.mv	a1,a6
    15b8:	00051503          	lh	a0,0(a0)
    15bc:	608050ef          	jal	ra,6bc4 <crc16>
    15c0:	6000                	c.ld	s0,0(s0)
    15c2:	882a                	c.mv	a6,a0
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:226 (discriminator 10)
    while (finder)
    15c4:	dc41                	c.beqz	s0,155c <EDLM_SIZE+0xb14>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:228 (discriminator 6)
        retval = crc16(list->info->data16, retval);
    15c6:	008c3503          	ld	a0,8(s8)
    15ca:	85c2                	c.mv	a1,a6
    15cc:	00051503          	lh	a0,0(a0)
    15d0:	5f4050ef          	jal	ra,6bc4 <crc16>
    15d4:	6000                	c.ld	s0,0(s0)
    15d6:	882a                	c.mv	a6,a0
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:226 (discriminator 12)
    while (finder)
    15d8:	d051                	c.beqz	s0,155c <EDLM_SIZE+0xb14>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:228 (discriminator 8)
        retval = crc16(list->info->data16, retval);
    15da:	008c3503          	ld	a0,8(s8)
    15de:	85c2                	c.mv	a1,a6
    15e0:	00051503          	lh	a0,0(a0)
    15e4:	5e0050ef          	jal	ra,6bc4 <crc16>
    15e8:	6000                	c.ld	s0,0(s0)
    15ea:	882a                	c.mv	a6,a0
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:226 (discriminator 14)
    while (finder)
    15ec:	d825                	c.beqz	s0,155c <EDLM_SIZE+0xb14>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:228 (discriminator 10)
        retval = crc16(list->info->data16, retval);
    15ee:	008c3503          	ld	a0,8(s8)
    15f2:	85c2                	c.mv	a1,a6
    15f4:	00051503          	lh	a0,0(a0)
    15f8:	5cc050ef          	jal	ra,6bc4 <crc16>
    15fc:	6000                	c.ld	s0,0(s0)
    15fe:	882a                	c.mv	a6,a0
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:226 (discriminator 16)
    while (finder)
    1600:	dc31                	c.beqz	s0,155c <EDLM_SIZE+0xb14>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:228 (discriminator 12)
        retval = crc16(list->info->data16, retval);
    1602:	008c3503          	ld	a0,8(s8)
    1606:	85c2                	c.mv	a1,a6
    1608:	00051503          	lh	a0,0(a0)
    160c:	5b8050ef          	jal	ra,6bc4 <crc16>
    1610:	6000                	c.ld	s0,0(s0)
    1612:	882a                	c.mv	a6,a0
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:226 (discriminator 18)
    while (finder)
    1614:	d421                	c.beqz	s0,155c <EDLM_SIZE+0xb14>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:228 (discriminator 14)
        retval = crc16(list->info->data16, retval);
    1616:	008c3503          	ld	a0,8(s8)
    161a:	85c2                	c.mv	a1,a6
    161c:	00051503          	lh	a0,0(a0)
    1620:	5a4050ef          	jal	ra,6bc4 <crc16>
    1624:	6000                	c.ld	s0,0(s0)
    1626:	882a                	c.mv	a6,a0
    1628:	f025                	c.bnez	s0,1588 <EDLM_SIZE+0xb40>
    162a:	bf0d                	c.j	155c <EDLM_SIZE+0xb14>
/home/users3/rex603/automation/CoreMark-V5/demo/core_list_join.c:234
    return retval;
    162c:	6de6                	c.ldsp	s11,88(sp)
    162e:	7d06                	c.ldsp	s10,96(sp)
    1630:	7ca6                	c.ldsp	s9,104(sp)
    1632:	7c46                	c.ldsp	s8,112(sp)
    1634:	7be6                	c.ldsp	s7,120(sp)
    1636:	6b0a                	c.ldsp	s6,128(sp)
    1638:	6aaa                	c.ldsp	s5,136(sp)
    163a:	6a4a                	c.ldsp	s4,144(sp)
    163c:	69ea                	c.ldsp	s3,152(sp)
    163e:	790a                	c.ldsp	s2,160(sp)
    1640:	74aa                	c.ldsp	s1,168(sp)
    1642:	744a                	c.ldsp	s0,176(sp)
    1644:	70ea                	c.ldsp	ra,184(sp)
    1646:	3c08255b          	bfoz	a0,a6,15,0
    164a:	6129                	c.addi16sp	sp,192
    164c:	00008067          	ret
