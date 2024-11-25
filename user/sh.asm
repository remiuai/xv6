
user/_sh:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <getcmd>:
  exit(0);
}

int
getcmd(char *buf, int nbuf)
{
       0:	1101                	addi	sp,sp,-32
       2:	ec06                	sd	ra,24(sp)
       4:	e822                	sd	s0,16(sp)
       6:	e426                	sd	s1,8(sp)
       8:	e04a                	sd	s2,0(sp)
       a:	1000                	addi	s0,sp,32
       c:	84aa                	mv	s1,a0
       e:	892e                	mv	s2,a1
  write(2, "$ ", 2);
      10:	4609                	li	a2,2
      12:	00001597          	auipc	a1,0x1
      16:	1ce58593          	addi	a1,a1,462 # 11e0 <malloc+0xfe>
      1a:	4509                	li	a0,2
      1c:	413000ef          	jal	c2e <write>
  memset(buf, 0, nbuf);
      20:	864a                	mv	a2,s2
      22:	4581                	li	a1,0
      24:	8526                	mv	a0,s1
      26:	203000ef          	jal	a28 <memset>
  gets(buf, nbuf);
      2a:	85ca                	mv	a1,s2
      2c:	8526                	mv	a0,s1
      2e:	241000ef          	jal	a6e <gets>
  if(buf[0] == 0) // EOF
      32:	0004c503          	lbu	a0,0(s1)
      36:	00153513          	seqz	a0,a0
    return -1;
  return 0;
}
      3a:	40a00533          	neg	a0,a0
      3e:	60e2                	ld	ra,24(sp)
      40:	6442                	ld	s0,16(sp)
      42:	64a2                	ld	s1,8(sp)
      44:	6902                	ld	s2,0(sp)
      46:	6105                	addi	sp,sp,32
      48:	8082                	ret

000000000000004a <panic>:
  exit(0);
}

void
panic(char *s)
{
      4a:	1141                	addi	sp,sp,-16
      4c:	e406                	sd	ra,8(sp)
      4e:	e022                	sd	s0,0(sp)
      50:	0800                	addi	s0,sp,16
      52:	862a                	mv	a2,a0
  fprintf(2, "%s\n", s);
      54:	00001597          	auipc	a1,0x1
      58:	19c58593          	addi	a1,a1,412 # 11f0 <malloc+0x10e>
      5c:	4509                	li	a0,2
      5e:	7a7000ef          	jal	1004 <fprintf>
  exit(1);
      62:	4505                	li	a0,1
      64:	3ab000ef          	jal	c0e <exit>

0000000000000068 <fork1>:
}

int
fork1(void)
{
      68:	1141                	addi	sp,sp,-16
      6a:	e406                	sd	ra,8(sp)
      6c:	e022                	sd	s0,0(sp)
      6e:	0800                	addi	s0,sp,16
  int pid;

  pid = fork();
      70:	397000ef          	jal	c06 <fork>
  if(pid == -1)
      74:	57fd                	li	a5,-1
      76:	00f50663          	beq	a0,a5,82 <fork1+0x1a>
    panic("fork");
  return pid;
}
      7a:	60a2                	ld	ra,8(sp)
      7c:	6402                	ld	s0,0(sp)
      7e:	0141                	addi	sp,sp,16
      80:	8082                	ret
    panic("fork");
      82:	00001517          	auipc	a0,0x1
      86:	17650513          	addi	a0,a0,374 # 11f8 <malloc+0x116>
      8a:	fc1ff0ef          	jal	4a <panic>

000000000000008e <runcmd>:
{
      8e:	7179                	addi	sp,sp,-48
      90:	f406                	sd	ra,40(sp)
      92:	f022                	sd	s0,32(sp)
      94:	1800                	addi	s0,sp,48
  if(cmd == 0)
      96:	c115                	beqz	a0,ba <runcmd+0x2c>
      98:	ec26                	sd	s1,24(sp)
      9a:	84aa                	mv	s1,a0
  switch(cmd->type){
      9c:	4118                	lw	a4,0(a0)
      9e:	4795                	li	a5,5
      a0:	02e7e163          	bltu	a5,a4,c2 <runcmd+0x34>
      a4:	00056783          	lwu	a5,0(a0)
      a8:	078a                	slli	a5,a5,0x2
      aa:	00001717          	auipc	a4,0x1
      ae:	27670713          	addi	a4,a4,630 # 1320 <malloc+0x23e>
      b2:	97ba                	add	a5,a5,a4
      b4:	439c                	lw	a5,0(a5)
      b6:	97ba                	add	a5,a5,a4
      b8:	8782                	jr	a5
      ba:	ec26                	sd	s1,24(sp)
    exit(1);
      bc:	4505                	li	a0,1
      be:	351000ef          	jal	c0e <exit>
    panic("runcmd");
      c2:	00001517          	auipc	a0,0x1
      c6:	13e50513          	addi	a0,a0,318 # 1200 <malloc+0x11e>
      ca:	f81ff0ef          	jal	4a <panic>
    if(ecmd->argv[0] == 0)
      ce:	6508                	ld	a0,8(a0)
      d0:	c105                	beqz	a0,f0 <runcmd+0x62>
    exec(ecmd->argv[0], ecmd->argv);
      d2:	00848593          	addi	a1,s1,8
      d6:	371000ef          	jal	c46 <exec>
    fprintf(2, "exec %s failed\n", ecmd->argv[0]);
      da:	6490                	ld	a2,8(s1)
      dc:	00001597          	auipc	a1,0x1
      e0:	12c58593          	addi	a1,a1,300 # 1208 <malloc+0x126>
      e4:	4509                	li	a0,2
      e6:	71f000ef          	jal	1004 <fprintf>
  exit(0);
      ea:	4501                	li	a0,0
      ec:	323000ef          	jal	c0e <exit>
      exit(1);
      f0:	4505                	li	a0,1
      f2:	31d000ef          	jal	c0e <exit>
    close(rcmd->fd);
      f6:	5148                	lw	a0,36(a0)
      f8:	33f000ef          	jal	c36 <close>
    if(open(rcmd->file, rcmd->mode) < 0){
      fc:	508c                	lw	a1,32(s1)
      fe:	6888                	ld	a0,16(s1)
     100:	34f000ef          	jal	c4e <open>
     104:	00054563          	bltz	a0,10e <runcmd+0x80>
    runcmd(rcmd->cmd);
     108:	6488                	ld	a0,8(s1)
     10a:	f85ff0ef          	jal	8e <runcmd>
      fprintf(2, "open %s failed\n", rcmd->file);
     10e:	6890                	ld	a2,16(s1)
     110:	00001597          	auipc	a1,0x1
     114:	10858593          	addi	a1,a1,264 # 1218 <malloc+0x136>
     118:	4509                	li	a0,2
     11a:	6eb000ef          	jal	1004 <fprintf>
      exit(1);
     11e:	4505                	li	a0,1
     120:	2ef000ef          	jal	c0e <exit>
    if(fork1() == 0)
     124:	f45ff0ef          	jal	68 <fork1>
     128:	e501                	bnez	a0,130 <runcmd+0xa2>
      runcmd(lcmd->left);
     12a:	6488                	ld	a0,8(s1)
     12c:	f63ff0ef          	jal	8e <runcmd>
    wait(0);
     130:	4501                	li	a0,0
     132:	2e5000ef          	jal	c16 <wait>
    runcmd(lcmd->right);
     136:	6888                	ld	a0,16(s1)
     138:	f57ff0ef          	jal	8e <runcmd>
    if(pipe(p) < 0)
     13c:	fd840513          	addi	a0,s0,-40
     140:	2df000ef          	jal	c1e <pipe>
     144:	02054763          	bltz	a0,172 <runcmd+0xe4>
    if(fork1() == 0){
     148:	f21ff0ef          	jal	68 <fork1>
     14c:	e90d                	bnez	a0,17e <runcmd+0xf0>
      close(1);
     14e:	4505                	li	a0,1
     150:	2e7000ef          	jal	c36 <close>
      dup(p[1]);
     154:	fdc42503          	lw	a0,-36(s0)
     158:	32f000ef          	jal	c86 <dup>
      close(p[0]);
     15c:	fd842503          	lw	a0,-40(s0)
     160:	2d7000ef          	jal	c36 <close>
      close(p[1]);
     164:	fdc42503          	lw	a0,-36(s0)
     168:	2cf000ef          	jal	c36 <close>
      runcmd(pcmd->left);
     16c:	6488                	ld	a0,8(s1)
     16e:	f21ff0ef          	jal	8e <runcmd>
      panic("pipe");
     172:	00001517          	auipc	a0,0x1
     176:	0b650513          	addi	a0,a0,182 # 1228 <malloc+0x146>
     17a:	ed1ff0ef          	jal	4a <panic>
    if(fork1() == 0){
     17e:	eebff0ef          	jal	68 <fork1>
     182:	e115                	bnez	a0,1a6 <runcmd+0x118>
      close(0);
     184:	2b3000ef          	jal	c36 <close>
      dup(p[0]);
     188:	fd842503          	lw	a0,-40(s0)
     18c:	2fb000ef          	jal	c86 <dup>
      close(p[0]);
     190:	fd842503          	lw	a0,-40(s0)
     194:	2a3000ef          	jal	c36 <close>
      close(p[1]);
     198:	fdc42503          	lw	a0,-36(s0)
     19c:	29b000ef          	jal	c36 <close>
      runcmd(pcmd->right);
     1a0:	6888                	ld	a0,16(s1)
     1a2:	eedff0ef          	jal	8e <runcmd>
    close(p[0]);
     1a6:	fd842503          	lw	a0,-40(s0)
     1aa:	28d000ef          	jal	c36 <close>
    close(p[1]);
     1ae:	fdc42503          	lw	a0,-36(s0)
     1b2:	285000ef          	jal	c36 <close>
    wait(0);
     1b6:	4501                	li	a0,0
     1b8:	25f000ef          	jal	c16 <wait>
    wait(0);
     1bc:	4501                	li	a0,0
     1be:	259000ef          	jal	c16 <wait>
    break;
     1c2:	b725                	j	ea <runcmd+0x5c>
    if(fork1() == 0)
     1c4:	ea5ff0ef          	jal	68 <fork1>
     1c8:	f20511e3          	bnez	a0,ea <runcmd+0x5c>
      runcmd(bcmd->cmd);
     1cc:	6488                	ld	a0,8(s1)
     1ce:	ec1ff0ef          	jal	8e <runcmd>

00000000000001d2 <execcmd>:
//PAGEBREAK!
// Constructors

struct cmd*
execcmd(void)
{
     1d2:	1101                	addi	sp,sp,-32
     1d4:	ec06                	sd	ra,24(sp)
     1d6:	e822                	sd	s0,16(sp)
     1d8:	e426                	sd	s1,8(sp)
     1da:	1000                	addi	s0,sp,32
  struct execcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     1dc:	0a800513          	li	a0,168
     1e0:	703000ef          	jal	10e2 <malloc>
     1e4:	84aa                	mv	s1,a0
  memset(cmd, 0, sizeof(*cmd));
     1e6:	0a800613          	li	a2,168
     1ea:	4581                	li	a1,0
     1ec:	03d000ef          	jal	a28 <memset>
  cmd->type = EXEC;
     1f0:	4785                	li	a5,1
     1f2:	c09c                	sw	a5,0(s1)
  return (struct cmd*)cmd;
}
     1f4:	8526                	mv	a0,s1
     1f6:	60e2                	ld	ra,24(sp)
     1f8:	6442                	ld	s0,16(sp)
     1fa:	64a2                	ld	s1,8(sp)
     1fc:	6105                	addi	sp,sp,32
     1fe:	8082                	ret

0000000000000200 <redircmd>:

struct cmd*
redircmd(struct cmd *subcmd, char *file, char *efile, int mode, int fd)
{
     200:	7139                	addi	sp,sp,-64
     202:	fc06                	sd	ra,56(sp)
     204:	f822                	sd	s0,48(sp)
     206:	f426                	sd	s1,40(sp)
     208:	f04a                	sd	s2,32(sp)
     20a:	ec4e                	sd	s3,24(sp)
     20c:	e852                	sd	s4,16(sp)
     20e:	e456                	sd	s5,8(sp)
     210:	e05a                	sd	s6,0(sp)
     212:	0080                	addi	s0,sp,64
     214:	8b2a                	mv	s6,a0
     216:	8aae                	mv	s5,a1
     218:	8a32                	mv	s4,a2
     21a:	89b6                	mv	s3,a3
     21c:	893a                	mv	s2,a4
  struct redircmd *cmd;

  cmd = malloc(sizeof(*cmd));
     21e:	02800513          	li	a0,40
     222:	6c1000ef          	jal	10e2 <malloc>
     226:	84aa                	mv	s1,a0
  memset(cmd, 0, sizeof(*cmd));
     228:	02800613          	li	a2,40
     22c:	4581                	li	a1,0
     22e:	7fa000ef          	jal	a28 <memset>
  cmd->type = REDIR;
     232:	4789                	li	a5,2
     234:	c09c                	sw	a5,0(s1)
  cmd->cmd = subcmd;
     236:	0164b423          	sd	s6,8(s1)
  cmd->file = file;
     23a:	0154b823          	sd	s5,16(s1)
  cmd->efile = efile;
     23e:	0144bc23          	sd	s4,24(s1)
  cmd->mode = mode;
     242:	0334a023          	sw	s3,32(s1)
  cmd->fd = fd;
     246:	0324a223          	sw	s2,36(s1)
  return (struct cmd*)cmd;
}
     24a:	8526                	mv	a0,s1
     24c:	70e2                	ld	ra,56(sp)
     24e:	7442                	ld	s0,48(sp)
     250:	74a2                	ld	s1,40(sp)
     252:	7902                	ld	s2,32(sp)
     254:	69e2                	ld	s3,24(sp)
     256:	6a42                	ld	s4,16(sp)
     258:	6aa2                	ld	s5,8(sp)
     25a:	6b02                	ld	s6,0(sp)
     25c:	6121                	addi	sp,sp,64
     25e:	8082                	ret

0000000000000260 <pipecmd>:

struct cmd*
pipecmd(struct cmd *left, struct cmd *right)
{
     260:	7179                	addi	sp,sp,-48
     262:	f406                	sd	ra,40(sp)
     264:	f022                	sd	s0,32(sp)
     266:	ec26                	sd	s1,24(sp)
     268:	e84a                	sd	s2,16(sp)
     26a:	e44e                	sd	s3,8(sp)
     26c:	1800                	addi	s0,sp,48
     26e:	89aa                	mv	s3,a0
     270:	892e                	mv	s2,a1
  struct pipecmd *cmd;

  cmd = malloc(sizeof(*cmd));
     272:	4561                	li	a0,24
     274:	66f000ef          	jal	10e2 <malloc>
     278:	84aa                	mv	s1,a0
  memset(cmd, 0, sizeof(*cmd));
     27a:	4661                	li	a2,24
     27c:	4581                	li	a1,0
     27e:	7aa000ef          	jal	a28 <memset>
  cmd->type = PIPE;
     282:	478d                	li	a5,3
     284:	c09c                	sw	a5,0(s1)
  cmd->left = left;
     286:	0134b423          	sd	s3,8(s1)
  cmd->right = right;
     28a:	0124b823          	sd	s2,16(s1)
  return (struct cmd*)cmd;
}
     28e:	8526                	mv	a0,s1
     290:	70a2                	ld	ra,40(sp)
     292:	7402                	ld	s0,32(sp)
     294:	64e2                	ld	s1,24(sp)
     296:	6942                	ld	s2,16(sp)
     298:	69a2                	ld	s3,8(sp)
     29a:	6145                	addi	sp,sp,48
     29c:	8082                	ret

000000000000029e <listcmd>:

struct cmd*
listcmd(struct cmd *left, struct cmd *right)
{
     29e:	7179                	addi	sp,sp,-48
     2a0:	f406                	sd	ra,40(sp)
     2a2:	f022                	sd	s0,32(sp)
     2a4:	ec26                	sd	s1,24(sp)
     2a6:	e84a                	sd	s2,16(sp)
     2a8:	e44e                	sd	s3,8(sp)
     2aa:	1800                	addi	s0,sp,48
     2ac:	89aa                	mv	s3,a0
     2ae:	892e                	mv	s2,a1
  struct listcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     2b0:	4561                	li	a0,24
     2b2:	631000ef          	jal	10e2 <malloc>
     2b6:	84aa                	mv	s1,a0
  memset(cmd, 0, sizeof(*cmd));
     2b8:	4661                	li	a2,24
     2ba:	4581                	li	a1,0
     2bc:	76c000ef          	jal	a28 <memset>
  cmd->type = LIST;
     2c0:	4791                	li	a5,4
     2c2:	c09c                	sw	a5,0(s1)
  cmd->left = left;
     2c4:	0134b423          	sd	s3,8(s1)
  cmd->right = right;
     2c8:	0124b823          	sd	s2,16(s1)
  return (struct cmd*)cmd;
}
     2cc:	8526                	mv	a0,s1
     2ce:	70a2                	ld	ra,40(sp)
     2d0:	7402                	ld	s0,32(sp)
     2d2:	64e2                	ld	s1,24(sp)
     2d4:	6942                	ld	s2,16(sp)
     2d6:	69a2                	ld	s3,8(sp)
     2d8:	6145                	addi	sp,sp,48
     2da:	8082                	ret

00000000000002dc <backcmd>:

struct cmd*
backcmd(struct cmd *subcmd)
{
     2dc:	1101                	addi	sp,sp,-32
     2de:	ec06                	sd	ra,24(sp)
     2e0:	e822                	sd	s0,16(sp)
     2e2:	e426                	sd	s1,8(sp)
     2e4:	e04a                	sd	s2,0(sp)
     2e6:	1000                	addi	s0,sp,32
     2e8:	892a                	mv	s2,a0
  struct backcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     2ea:	4541                	li	a0,16
     2ec:	5f7000ef          	jal	10e2 <malloc>
     2f0:	84aa                	mv	s1,a0
  memset(cmd, 0, sizeof(*cmd));
     2f2:	4641                	li	a2,16
     2f4:	4581                	li	a1,0
     2f6:	732000ef          	jal	a28 <memset>
  cmd->type = BACK;
     2fa:	4795                	li	a5,5
     2fc:	c09c                	sw	a5,0(s1)
  cmd->cmd = subcmd;
     2fe:	0124b423          	sd	s2,8(s1)
  return (struct cmd*)cmd;
}
     302:	8526                	mv	a0,s1
     304:	60e2                	ld	ra,24(sp)
     306:	6442                	ld	s0,16(sp)
     308:	64a2                	ld	s1,8(sp)
     30a:	6902                	ld	s2,0(sp)
     30c:	6105                	addi	sp,sp,32
     30e:	8082                	ret

0000000000000310 <gettoken>:
char whitespace[] = " \t\r\n\v";
char symbols[] = "<|>&;()";

int
gettoken(char **ps, char *es, char **q, char **eq)
{
     310:	7139                	addi	sp,sp,-64
     312:	fc06                	sd	ra,56(sp)
     314:	f822                	sd	s0,48(sp)
     316:	f426                	sd	s1,40(sp)
     318:	f04a                	sd	s2,32(sp)
     31a:	ec4e                	sd	s3,24(sp)
     31c:	e852                	sd	s4,16(sp)
     31e:	e456                	sd	s5,8(sp)
     320:	e05a                	sd	s6,0(sp)
     322:	0080                	addi	s0,sp,64
     324:	8a2a                	mv	s4,a0
     326:	892e                	mv	s2,a1
     328:	8ab2                	mv	s5,a2
     32a:	8b36                	mv	s6,a3
  char *s;
  int ret;

  s = *ps;
     32c:	6104                	ld	s1,0(a0)
  while(s < es && strchr(whitespace, *s))
     32e:	00002997          	auipc	s3,0x2
     332:	cda98993          	addi	s3,s3,-806 # 2008 <whitespace>
     336:	00b4fc63          	bgeu	s1,a1,34e <gettoken+0x3e>
     33a:	0004c583          	lbu	a1,0(s1)
     33e:	854e                	mv	a0,s3
     340:	70a000ef          	jal	a4a <strchr>
     344:	c509                	beqz	a0,34e <gettoken+0x3e>
    s++;
     346:	0485                	addi	s1,s1,1
  while(s < es && strchr(whitespace, *s))
     348:	fe9919e3          	bne	s2,s1,33a <gettoken+0x2a>
     34c:	84ca                	mv	s1,s2
  if(q)
     34e:	000a8463          	beqz	s5,356 <gettoken+0x46>
    *q = s;
     352:	009ab023          	sd	s1,0(s5)
  ret = *s;
     356:	0004c783          	lbu	a5,0(s1)
     35a:	00078a9b          	sext.w	s5,a5
  switch(*s){
     35e:	03c00713          	li	a4,60
     362:	06f76463          	bltu	a4,a5,3ca <gettoken+0xba>
     366:	03a00713          	li	a4,58
     36a:	00f76e63          	bltu	a4,a5,386 <gettoken+0x76>
     36e:	cf89                	beqz	a5,388 <gettoken+0x78>
     370:	02600713          	li	a4,38
     374:	00e78963          	beq	a5,a4,386 <gettoken+0x76>
     378:	fd87879b          	addiw	a5,a5,-40
     37c:	0ff7f793          	zext.b	a5,a5
     380:	4705                	li	a4,1
     382:	06f76b63          	bltu	a4,a5,3f8 <gettoken+0xe8>
  case '(':
  case ')':
  case ';':
  case '&':
  case '<':
    s++;
     386:	0485                	addi	s1,s1,1
    ret = 'a';
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
      s++;
    break;
  }
  if(eq)
     388:	000b0463          	beqz	s6,390 <gettoken+0x80>
    *eq = s;
     38c:	009b3023          	sd	s1,0(s6)

  while(s < es && strchr(whitespace, *s))
     390:	00002997          	auipc	s3,0x2
     394:	c7898993          	addi	s3,s3,-904 # 2008 <whitespace>
     398:	0124fc63          	bgeu	s1,s2,3b0 <gettoken+0xa0>
     39c:	0004c583          	lbu	a1,0(s1)
     3a0:	854e                	mv	a0,s3
     3a2:	6a8000ef          	jal	a4a <strchr>
     3a6:	c509                	beqz	a0,3b0 <gettoken+0xa0>
    s++;
     3a8:	0485                	addi	s1,s1,1
  while(s < es && strchr(whitespace, *s))
     3aa:	fe9919e3          	bne	s2,s1,39c <gettoken+0x8c>
     3ae:	84ca                	mv	s1,s2
  *ps = s;
     3b0:	009a3023          	sd	s1,0(s4)
  return ret;
}
     3b4:	8556                	mv	a0,s5
     3b6:	70e2                	ld	ra,56(sp)
     3b8:	7442                	ld	s0,48(sp)
     3ba:	74a2                	ld	s1,40(sp)
     3bc:	7902                	ld	s2,32(sp)
     3be:	69e2                	ld	s3,24(sp)
     3c0:	6a42                	ld	s4,16(sp)
     3c2:	6aa2                	ld	s5,8(sp)
     3c4:	6b02                	ld	s6,0(sp)
     3c6:	6121                	addi	sp,sp,64
     3c8:	8082                	ret
  switch(*s){
     3ca:	03e00713          	li	a4,62
     3ce:	02e79163          	bne	a5,a4,3f0 <gettoken+0xe0>
    s++;
     3d2:	00148693          	addi	a3,s1,1
    if(*s == '>'){
     3d6:	0014c703          	lbu	a4,1(s1)
     3da:	03e00793          	li	a5,62
      s++;
     3de:	0489                	addi	s1,s1,2
      ret = '+';
     3e0:	02b00a93          	li	s5,43
    if(*s == '>'){
     3e4:	faf702e3          	beq	a4,a5,388 <gettoken+0x78>
    s++;
     3e8:	84b6                	mv	s1,a3
  ret = *s;
     3ea:	03e00a93          	li	s5,62
     3ee:	bf69                	j	388 <gettoken+0x78>
  switch(*s){
     3f0:	07c00713          	li	a4,124
     3f4:	f8e789e3          	beq	a5,a4,386 <gettoken+0x76>
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     3f8:	00002997          	auipc	s3,0x2
     3fc:	c1098993          	addi	s3,s3,-1008 # 2008 <whitespace>
     400:	00002a97          	auipc	s5,0x2
     404:	c00a8a93          	addi	s5,s5,-1024 # 2000 <symbols>
     408:	0324fd63          	bgeu	s1,s2,442 <gettoken+0x132>
     40c:	0004c583          	lbu	a1,0(s1)
     410:	854e                	mv	a0,s3
     412:	638000ef          	jal	a4a <strchr>
     416:	e11d                	bnez	a0,43c <gettoken+0x12c>
     418:	0004c583          	lbu	a1,0(s1)
     41c:	8556                	mv	a0,s5
     41e:	62c000ef          	jal	a4a <strchr>
     422:	e911                	bnez	a0,436 <gettoken+0x126>
      s++;
     424:	0485                	addi	s1,s1,1
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     426:	fe9913e3          	bne	s2,s1,40c <gettoken+0xfc>
  if(eq)
     42a:	84ca                	mv	s1,s2
    ret = 'a';
     42c:	06100a93          	li	s5,97
  if(eq)
     430:	f40b1ee3          	bnez	s6,38c <gettoken+0x7c>
     434:	bfb5                	j	3b0 <gettoken+0xa0>
    ret = 'a';
     436:	06100a93          	li	s5,97
     43a:	b7b9                	j	388 <gettoken+0x78>
     43c:	06100a93          	li	s5,97
     440:	b7a1                	j	388 <gettoken+0x78>
     442:	06100a93          	li	s5,97
  if(eq)
     446:	f40b13e3          	bnez	s6,38c <gettoken+0x7c>
     44a:	b79d                	j	3b0 <gettoken+0xa0>

000000000000044c <peek>:

int
peek(char **ps, char *es, char *toks)
{
     44c:	7139                	addi	sp,sp,-64
     44e:	fc06                	sd	ra,56(sp)
     450:	f822                	sd	s0,48(sp)
     452:	f426                	sd	s1,40(sp)
     454:	f04a                	sd	s2,32(sp)
     456:	ec4e                	sd	s3,24(sp)
     458:	e852                	sd	s4,16(sp)
     45a:	e456                	sd	s5,8(sp)
     45c:	0080                	addi	s0,sp,64
     45e:	8a2a                	mv	s4,a0
     460:	892e                	mv	s2,a1
     462:	8ab2                	mv	s5,a2
  char *s;

  s = *ps;
     464:	6104                	ld	s1,0(a0)
  while(s < es && strchr(whitespace, *s))
     466:	00002997          	auipc	s3,0x2
     46a:	ba298993          	addi	s3,s3,-1118 # 2008 <whitespace>
     46e:	00b4fc63          	bgeu	s1,a1,486 <peek+0x3a>
     472:	0004c583          	lbu	a1,0(s1)
     476:	854e                	mv	a0,s3
     478:	5d2000ef          	jal	a4a <strchr>
     47c:	c509                	beqz	a0,486 <peek+0x3a>
    s++;
     47e:	0485                	addi	s1,s1,1
  while(s < es && strchr(whitespace, *s))
     480:	fe9919e3          	bne	s2,s1,472 <peek+0x26>
     484:	84ca                	mv	s1,s2
  *ps = s;
     486:	009a3023          	sd	s1,0(s4)
  return *s && strchr(toks, *s);
     48a:	0004c583          	lbu	a1,0(s1)
     48e:	4501                	li	a0,0
     490:	e991                	bnez	a1,4a4 <peek+0x58>
}
     492:	70e2                	ld	ra,56(sp)
     494:	7442                	ld	s0,48(sp)
     496:	74a2                	ld	s1,40(sp)
     498:	7902                	ld	s2,32(sp)
     49a:	69e2                	ld	s3,24(sp)
     49c:	6a42                	ld	s4,16(sp)
     49e:	6aa2                	ld	s5,8(sp)
     4a0:	6121                	addi	sp,sp,64
     4a2:	8082                	ret
  return *s && strchr(toks, *s);
     4a4:	8556                	mv	a0,s5
     4a6:	5a4000ef          	jal	a4a <strchr>
     4aa:	00a03533          	snez	a0,a0
     4ae:	b7d5                	j	492 <peek+0x46>

00000000000004b0 <parseredirs>:
  return cmd;
}

struct cmd*
parseredirs(struct cmd *cmd, char **ps, char *es)
{
     4b0:	711d                	addi	sp,sp,-96
     4b2:	ec86                	sd	ra,88(sp)
     4b4:	e8a2                	sd	s0,80(sp)
     4b6:	e4a6                	sd	s1,72(sp)
     4b8:	e0ca                	sd	s2,64(sp)
     4ba:	fc4e                	sd	s3,56(sp)
     4bc:	f852                	sd	s4,48(sp)
     4be:	f456                	sd	s5,40(sp)
     4c0:	f05a                	sd	s6,32(sp)
     4c2:	ec5e                	sd	s7,24(sp)
     4c4:	1080                	addi	s0,sp,96
     4c6:	8a2a                	mv	s4,a0
     4c8:	89ae                	mv	s3,a1
     4ca:	8932                	mv	s2,a2
  int tok;
  char *q, *eq;

  while(peek(ps, es, "<>")){
     4cc:	00001a97          	auipc	s5,0x1
     4d0:	d84a8a93          	addi	s5,s5,-636 # 1250 <malloc+0x16e>
    tok = gettoken(ps, es, 0, 0);
    if(gettoken(ps, es, &q, &eq) != 'a')
     4d4:	06100b13          	li	s6,97
      panic("missing file for redirection");
    switch(tok){
     4d8:	03c00b93          	li	s7,60
  while(peek(ps, es, "<>")){
     4dc:	a00d                	j	4fe <parseredirs+0x4e>
      panic("missing file for redirection");
     4de:	00001517          	auipc	a0,0x1
     4e2:	d5250513          	addi	a0,a0,-686 # 1230 <malloc+0x14e>
     4e6:	b65ff0ef          	jal	4a <panic>
    case '<':
      cmd = redircmd(cmd, q, eq, O_RDONLY, 0);
     4ea:	4701                	li	a4,0
     4ec:	4681                	li	a3,0
     4ee:	fa043603          	ld	a2,-96(s0)
     4f2:	fa843583          	ld	a1,-88(s0)
     4f6:	8552                	mv	a0,s4
     4f8:	d09ff0ef          	jal	200 <redircmd>
     4fc:	8a2a                	mv	s4,a0
  while(peek(ps, es, "<>")){
     4fe:	8656                	mv	a2,s5
     500:	85ca                	mv	a1,s2
     502:	854e                	mv	a0,s3
     504:	f49ff0ef          	jal	44c <peek>
     508:	c525                	beqz	a0,570 <parseredirs+0xc0>
    tok = gettoken(ps, es, 0, 0);
     50a:	4681                	li	a3,0
     50c:	4601                	li	a2,0
     50e:	85ca                	mv	a1,s2
     510:	854e                	mv	a0,s3
     512:	dffff0ef          	jal	310 <gettoken>
     516:	84aa                	mv	s1,a0
    if(gettoken(ps, es, &q, &eq) != 'a')
     518:	fa040693          	addi	a3,s0,-96
     51c:	fa840613          	addi	a2,s0,-88
     520:	85ca                	mv	a1,s2
     522:	854e                	mv	a0,s3
     524:	dedff0ef          	jal	310 <gettoken>
     528:	fb651be3          	bne	a0,s6,4de <parseredirs+0x2e>
    switch(tok){
     52c:	fb748fe3          	beq	s1,s7,4ea <parseredirs+0x3a>
     530:	03e00793          	li	a5,62
     534:	02f48263          	beq	s1,a5,558 <parseredirs+0xa8>
     538:	02b00793          	li	a5,43
     53c:	fcf491e3          	bne	s1,a5,4fe <parseredirs+0x4e>
      break;
    case '>':
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE|O_TRUNC, 1);
      break;
    case '+':  // >>
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
     540:	4705                	li	a4,1
     542:	20100693          	li	a3,513
     546:	fa043603          	ld	a2,-96(s0)
     54a:	fa843583          	ld	a1,-88(s0)
     54e:	8552                	mv	a0,s4
     550:	cb1ff0ef          	jal	200 <redircmd>
     554:	8a2a                	mv	s4,a0
      break;
     556:	b765                	j	4fe <parseredirs+0x4e>
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE|O_TRUNC, 1);
     558:	4705                	li	a4,1
     55a:	60100693          	li	a3,1537
     55e:	fa043603          	ld	a2,-96(s0)
     562:	fa843583          	ld	a1,-88(s0)
     566:	8552                	mv	a0,s4
     568:	c99ff0ef          	jal	200 <redircmd>
     56c:	8a2a                	mv	s4,a0
      break;
     56e:	bf41                	j	4fe <parseredirs+0x4e>
    }
  }
  return cmd;
}
     570:	8552                	mv	a0,s4
     572:	60e6                	ld	ra,88(sp)
     574:	6446                	ld	s0,80(sp)
     576:	64a6                	ld	s1,72(sp)
     578:	6906                	ld	s2,64(sp)
     57a:	79e2                	ld	s3,56(sp)
     57c:	7a42                	ld	s4,48(sp)
     57e:	7aa2                	ld	s5,40(sp)
     580:	7b02                	ld	s6,32(sp)
     582:	6be2                	ld	s7,24(sp)
     584:	6125                	addi	sp,sp,96
     586:	8082                	ret

0000000000000588 <parseexec>:
  return cmd;
}

struct cmd*
parseexec(char **ps, char *es)
{
     588:	7159                	addi	sp,sp,-112
     58a:	f486                	sd	ra,104(sp)
     58c:	f0a2                	sd	s0,96(sp)
     58e:	eca6                	sd	s1,88(sp)
     590:	e0d2                	sd	s4,64(sp)
     592:	fc56                	sd	s5,56(sp)
     594:	1880                	addi	s0,sp,112
     596:	8a2a                	mv	s4,a0
     598:	8aae                	mv	s5,a1
  char *q, *eq;
  int tok, argc;
  struct execcmd *cmd;
  struct cmd *ret;

  if(peek(ps, es, "("))
     59a:	00001617          	auipc	a2,0x1
     59e:	cbe60613          	addi	a2,a2,-834 # 1258 <malloc+0x176>
     5a2:	eabff0ef          	jal	44c <peek>
     5a6:	e915                	bnez	a0,5da <parseexec+0x52>
     5a8:	e8ca                	sd	s2,80(sp)
     5aa:	e4ce                	sd	s3,72(sp)
     5ac:	f85a                	sd	s6,48(sp)
     5ae:	f45e                	sd	s7,40(sp)
     5b0:	f062                	sd	s8,32(sp)
     5b2:	ec66                	sd	s9,24(sp)
     5b4:	89aa                	mv	s3,a0
    return parseblock(ps, es);

  ret = execcmd();
     5b6:	c1dff0ef          	jal	1d2 <execcmd>
     5ba:	8c2a                	mv	s8,a0
  cmd = (struct execcmd*)ret;

  argc = 0;
  ret = parseredirs(ret, ps, es);
     5bc:	8656                	mv	a2,s5
     5be:	85d2                	mv	a1,s4
     5c0:	ef1ff0ef          	jal	4b0 <parseredirs>
     5c4:	84aa                	mv	s1,a0
  while(!peek(ps, es, "|)&;")){
     5c6:	008c0913          	addi	s2,s8,8
     5ca:	00001b17          	auipc	s6,0x1
     5ce:	caeb0b13          	addi	s6,s6,-850 # 1278 <malloc+0x196>
    if((tok=gettoken(ps, es, &q, &eq)) == 0)
      break;
    if(tok != 'a')
     5d2:	06100c93          	li	s9,97
      panic("syntax");
    cmd->argv[argc] = q;
    cmd->eargv[argc] = eq;
    argc++;
    if(argc >= MAXARGS)
     5d6:	4ba9                	li	s7,10
  while(!peek(ps, es, "|)&;")){
     5d8:	a815                	j	60c <parseexec+0x84>
    return parseblock(ps, es);
     5da:	85d6                	mv	a1,s5
     5dc:	8552                	mv	a0,s4
     5de:	170000ef          	jal	74e <parseblock>
     5e2:	84aa                	mv	s1,a0
    ret = parseredirs(ret, ps, es);
  }
  cmd->argv[argc] = 0;
  cmd->eargv[argc] = 0;
  return ret;
}
     5e4:	8526                	mv	a0,s1
     5e6:	70a6                	ld	ra,104(sp)
     5e8:	7406                	ld	s0,96(sp)
     5ea:	64e6                	ld	s1,88(sp)
     5ec:	6a06                	ld	s4,64(sp)
     5ee:	7ae2                	ld	s5,56(sp)
     5f0:	6165                	addi	sp,sp,112
     5f2:	8082                	ret
      panic("syntax");
     5f4:	00001517          	auipc	a0,0x1
     5f8:	c6c50513          	addi	a0,a0,-916 # 1260 <malloc+0x17e>
     5fc:	a4fff0ef          	jal	4a <panic>
    ret = parseredirs(ret, ps, es);
     600:	8656                	mv	a2,s5
     602:	85d2                	mv	a1,s4
     604:	8526                	mv	a0,s1
     606:	eabff0ef          	jal	4b0 <parseredirs>
     60a:	84aa                	mv	s1,a0
  while(!peek(ps, es, "|)&;")){
     60c:	865a                	mv	a2,s6
     60e:	85d6                	mv	a1,s5
     610:	8552                	mv	a0,s4
     612:	e3bff0ef          	jal	44c <peek>
     616:	ed15                	bnez	a0,652 <parseexec+0xca>
    if((tok=gettoken(ps, es, &q, &eq)) == 0)
     618:	f9040693          	addi	a3,s0,-112
     61c:	f9840613          	addi	a2,s0,-104
     620:	85d6                	mv	a1,s5
     622:	8552                	mv	a0,s4
     624:	cedff0ef          	jal	310 <gettoken>
     628:	c50d                	beqz	a0,652 <parseexec+0xca>
    if(tok != 'a')
     62a:	fd9515e3          	bne	a0,s9,5f4 <parseexec+0x6c>
    cmd->argv[argc] = q;
     62e:	f9843783          	ld	a5,-104(s0)
     632:	00f93023          	sd	a5,0(s2)
    cmd->eargv[argc] = eq;
     636:	f9043783          	ld	a5,-112(s0)
     63a:	04f93823          	sd	a5,80(s2)
    argc++;
     63e:	2985                	addiw	s3,s3,1
    if(argc >= MAXARGS)
     640:	0921                	addi	s2,s2,8
     642:	fb799fe3          	bne	s3,s7,600 <parseexec+0x78>
      panic("too many args");
     646:	00001517          	auipc	a0,0x1
     64a:	c2250513          	addi	a0,a0,-990 # 1268 <malloc+0x186>
     64e:	9fdff0ef          	jal	4a <panic>
  cmd->argv[argc] = 0;
     652:	098e                	slli	s3,s3,0x3
     654:	9c4e                	add	s8,s8,s3
     656:	000c3423          	sd	zero,8(s8)
  cmd->eargv[argc] = 0;
     65a:	040c3c23          	sd	zero,88(s8)
     65e:	6946                	ld	s2,80(sp)
     660:	69a6                	ld	s3,72(sp)
     662:	7b42                	ld	s6,48(sp)
     664:	7ba2                	ld	s7,40(sp)
     666:	7c02                	ld	s8,32(sp)
     668:	6ce2                	ld	s9,24(sp)
  return ret;
     66a:	bfad                	j	5e4 <parseexec+0x5c>

000000000000066c <parsepipe>:
{
     66c:	7179                	addi	sp,sp,-48
     66e:	f406                	sd	ra,40(sp)
     670:	f022                	sd	s0,32(sp)
     672:	ec26                	sd	s1,24(sp)
     674:	e84a                	sd	s2,16(sp)
     676:	e44e                	sd	s3,8(sp)
     678:	1800                	addi	s0,sp,48
     67a:	892a                	mv	s2,a0
     67c:	89ae                	mv	s3,a1
  cmd = parseexec(ps, es);
     67e:	f0bff0ef          	jal	588 <parseexec>
     682:	84aa                	mv	s1,a0
  if(peek(ps, es, "|")){
     684:	00001617          	auipc	a2,0x1
     688:	bfc60613          	addi	a2,a2,-1028 # 1280 <malloc+0x19e>
     68c:	85ce                	mv	a1,s3
     68e:	854a                	mv	a0,s2
     690:	dbdff0ef          	jal	44c <peek>
     694:	e909                	bnez	a0,6a6 <parsepipe+0x3a>
}
     696:	8526                	mv	a0,s1
     698:	70a2                	ld	ra,40(sp)
     69a:	7402                	ld	s0,32(sp)
     69c:	64e2                	ld	s1,24(sp)
     69e:	6942                	ld	s2,16(sp)
     6a0:	69a2                	ld	s3,8(sp)
     6a2:	6145                	addi	sp,sp,48
     6a4:	8082                	ret
    gettoken(ps, es, 0, 0);
     6a6:	4681                	li	a3,0
     6a8:	4601                	li	a2,0
     6aa:	85ce                	mv	a1,s3
     6ac:	854a                	mv	a0,s2
     6ae:	c63ff0ef          	jal	310 <gettoken>
    cmd = pipecmd(cmd, parsepipe(ps, es));
     6b2:	85ce                	mv	a1,s3
     6b4:	854a                	mv	a0,s2
     6b6:	fb7ff0ef          	jal	66c <parsepipe>
     6ba:	85aa                	mv	a1,a0
     6bc:	8526                	mv	a0,s1
     6be:	ba3ff0ef          	jal	260 <pipecmd>
     6c2:	84aa                	mv	s1,a0
  return cmd;
     6c4:	bfc9                	j	696 <parsepipe+0x2a>

00000000000006c6 <parseline>:
{
     6c6:	7179                	addi	sp,sp,-48
     6c8:	f406                	sd	ra,40(sp)
     6ca:	f022                	sd	s0,32(sp)
     6cc:	ec26                	sd	s1,24(sp)
     6ce:	e84a                	sd	s2,16(sp)
     6d0:	e44e                	sd	s3,8(sp)
     6d2:	e052                	sd	s4,0(sp)
     6d4:	1800                	addi	s0,sp,48
     6d6:	892a                	mv	s2,a0
     6d8:	89ae                	mv	s3,a1
  cmd = parsepipe(ps, es);
     6da:	f93ff0ef          	jal	66c <parsepipe>
     6de:	84aa                	mv	s1,a0
  while(peek(ps, es, "&")){
     6e0:	00001a17          	auipc	s4,0x1
     6e4:	ba8a0a13          	addi	s4,s4,-1112 # 1288 <malloc+0x1a6>
     6e8:	a819                	j	6fe <parseline+0x38>
    gettoken(ps, es, 0, 0);
     6ea:	4681                	li	a3,0
     6ec:	4601                	li	a2,0
     6ee:	85ce                	mv	a1,s3
     6f0:	854a                	mv	a0,s2
     6f2:	c1fff0ef          	jal	310 <gettoken>
    cmd = backcmd(cmd);
     6f6:	8526                	mv	a0,s1
     6f8:	be5ff0ef          	jal	2dc <backcmd>
     6fc:	84aa                	mv	s1,a0
  while(peek(ps, es, "&")){
     6fe:	8652                	mv	a2,s4
     700:	85ce                	mv	a1,s3
     702:	854a                	mv	a0,s2
     704:	d49ff0ef          	jal	44c <peek>
     708:	f16d                	bnez	a0,6ea <parseline+0x24>
  if(peek(ps, es, ";")){
     70a:	00001617          	auipc	a2,0x1
     70e:	b8660613          	addi	a2,a2,-1146 # 1290 <malloc+0x1ae>
     712:	85ce                	mv	a1,s3
     714:	854a                	mv	a0,s2
     716:	d37ff0ef          	jal	44c <peek>
     71a:	e911                	bnez	a0,72e <parseline+0x68>
}
     71c:	8526                	mv	a0,s1
     71e:	70a2                	ld	ra,40(sp)
     720:	7402                	ld	s0,32(sp)
     722:	64e2                	ld	s1,24(sp)
     724:	6942                	ld	s2,16(sp)
     726:	69a2                	ld	s3,8(sp)
     728:	6a02                	ld	s4,0(sp)
     72a:	6145                	addi	sp,sp,48
     72c:	8082                	ret
    gettoken(ps, es, 0, 0);
     72e:	4681                	li	a3,0
     730:	4601                	li	a2,0
     732:	85ce                	mv	a1,s3
     734:	854a                	mv	a0,s2
     736:	bdbff0ef          	jal	310 <gettoken>
    cmd = listcmd(cmd, parseline(ps, es));
     73a:	85ce                	mv	a1,s3
     73c:	854a                	mv	a0,s2
     73e:	f89ff0ef          	jal	6c6 <parseline>
     742:	85aa                	mv	a1,a0
     744:	8526                	mv	a0,s1
     746:	b59ff0ef          	jal	29e <listcmd>
     74a:	84aa                	mv	s1,a0
  return cmd;
     74c:	bfc1                	j	71c <parseline+0x56>

000000000000074e <parseblock>:
{
     74e:	7179                	addi	sp,sp,-48
     750:	f406                	sd	ra,40(sp)
     752:	f022                	sd	s0,32(sp)
     754:	ec26                	sd	s1,24(sp)
     756:	e84a                	sd	s2,16(sp)
     758:	e44e                	sd	s3,8(sp)
     75a:	1800                	addi	s0,sp,48
     75c:	84aa                	mv	s1,a0
     75e:	892e                	mv	s2,a1
  if(!peek(ps, es, "("))
     760:	00001617          	auipc	a2,0x1
     764:	af860613          	addi	a2,a2,-1288 # 1258 <malloc+0x176>
     768:	ce5ff0ef          	jal	44c <peek>
     76c:	c539                	beqz	a0,7ba <parseblock+0x6c>
  gettoken(ps, es, 0, 0);
     76e:	4681                	li	a3,0
     770:	4601                	li	a2,0
     772:	85ca                	mv	a1,s2
     774:	8526                	mv	a0,s1
     776:	b9bff0ef          	jal	310 <gettoken>
  cmd = parseline(ps, es);
     77a:	85ca                	mv	a1,s2
     77c:	8526                	mv	a0,s1
     77e:	f49ff0ef          	jal	6c6 <parseline>
     782:	89aa                	mv	s3,a0
  if(!peek(ps, es, ")"))
     784:	00001617          	auipc	a2,0x1
     788:	b2460613          	addi	a2,a2,-1244 # 12a8 <malloc+0x1c6>
     78c:	85ca                	mv	a1,s2
     78e:	8526                	mv	a0,s1
     790:	cbdff0ef          	jal	44c <peek>
     794:	c90d                	beqz	a0,7c6 <parseblock+0x78>
  gettoken(ps, es, 0, 0);
     796:	4681                	li	a3,0
     798:	4601                	li	a2,0
     79a:	85ca                	mv	a1,s2
     79c:	8526                	mv	a0,s1
     79e:	b73ff0ef          	jal	310 <gettoken>
  cmd = parseredirs(cmd, ps, es);
     7a2:	864a                	mv	a2,s2
     7a4:	85a6                	mv	a1,s1
     7a6:	854e                	mv	a0,s3
     7a8:	d09ff0ef          	jal	4b0 <parseredirs>
}
     7ac:	70a2                	ld	ra,40(sp)
     7ae:	7402                	ld	s0,32(sp)
     7b0:	64e2                	ld	s1,24(sp)
     7b2:	6942                	ld	s2,16(sp)
     7b4:	69a2                	ld	s3,8(sp)
     7b6:	6145                	addi	sp,sp,48
     7b8:	8082                	ret
    panic("parseblock");
     7ba:	00001517          	auipc	a0,0x1
     7be:	ade50513          	addi	a0,a0,-1314 # 1298 <malloc+0x1b6>
     7c2:	889ff0ef          	jal	4a <panic>
    panic("syntax - missing )");
     7c6:	00001517          	auipc	a0,0x1
     7ca:	aea50513          	addi	a0,a0,-1302 # 12b0 <malloc+0x1ce>
     7ce:	87dff0ef          	jal	4a <panic>

00000000000007d2 <nulterminate>:

// NUL-terminate all the counted strings.
struct cmd*
nulterminate(struct cmd *cmd)
{
     7d2:	1101                	addi	sp,sp,-32
     7d4:	ec06                	sd	ra,24(sp)
     7d6:	e822                	sd	s0,16(sp)
     7d8:	e426                	sd	s1,8(sp)
     7da:	1000                	addi	s0,sp,32
     7dc:	84aa                	mv	s1,a0
  struct execcmd *ecmd;
  struct listcmd *lcmd;
  struct pipecmd *pcmd;
  struct redircmd *rcmd;

  if(cmd == 0)
     7de:	c131                	beqz	a0,822 <nulterminate+0x50>
    return 0;

  switch(cmd->type){
     7e0:	4118                	lw	a4,0(a0)
     7e2:	4795                	li	a5,5
     7e4:	02e7ef63          	bltu	a5,a4,822 <nulterminate+0x50>
     7e8:	00056783          	lwu	a5,0(a0)
     7ec:	078a                	slli	a5,a5,0x2
     7ee:	00001717          	auipc	a4,0x1
     7f2:	b4a70713          	addi	a4,a4,-1206 # 1338 <malloc+0x256>
     7f6:	97ba                	add	a5,a5,a4
     7f8:	439c                	lw	a5,0(a5)
     7fa:	97ba                	add	a5,a5,a4
     7fc:	8782                	jr	a5
  case EXEC:
    ecmd = (struct execcmd*)cmd;
    for(i=0; ecmd->argv[i]; i++)
     7fe:	651c                	ld	a5,8(a0)
     800:	c38d                	beqz	a5,822 <nulterminate+0x50>
     802:	01050793          	addi	a5,a0,16
      *ecmd->eargv[i] = 0;
     806:	67b8                	ld	a4,72(a5)
     808:	00070023          	sb	zero,0(a4)
    for(i=0; ecmd->argv[i]; i++)
     80c:	07a1                	addi	a5,a5,8
     80e:	ff87b703          	ld	a4,-8(a5)
     812:	fb75                	bnez	a4,806 <nulterminate+0x34>
     814:	a039                	j	822 <nulterminate+0x50>
    break;

  case REDIR:
    rcmd = (struct redircmd*)cmd;
    nulterminate(rcmd->cmd);
     816:	6508                	ld	a0,8(a0)
     818:	fbbff0ef          	jal	7d2 <nulterminate>
    *rcmd->efile = 0;
     81c:	6c9c                	ld	a5,24(s1)
     81e:	00078023          	sb	zero,0(a5)
    bcmd = (struct backcmd*)cmd;
    nulterminate(bcmd->cmd);
    break;
  }
  return cmd;
}
     822:	8526                	mv	a0,s1
     824:	60e2                	ld	ra,24(sp)
     826:	6442                	ld	s0,16(sp)
     828:	64a2                	ld	s1,8(sp)
     82a:	6105                	addi	sp,sp,32
     82c:	8082                	ret
    nulterminate(pcmd->left);
     82e:	6508                	ld	a0,8(a0)
     830:	fa3ff0ef          	jal	7d2 <nulterminate>
    nulterminate(pcmd->right);
     834:	6888                	ld	a0,16(s1)
     836:	f9dff0ef          	jal	7d2 <nulterminate>
    break;
     83a:	b7e5                	j	822 <nulterminate+0x50>
    nulterminate(lcmd->left);
     83c:	6508                	ld	a0,8(a0)
     83e:	f95ff0ef          	jal	7d2 <nulterminate>
    nulterminate(lcmd->right);
     842:	6888                	ld	a0,16(s1)
     844:	f8fff0ef          	jal	7d2 <nulterminate>
    break;
     848:	bfe9                	j	822 <nulterminate+0x50>
    nulterminate(bcmd->cmd);
     84a:	6508                	ld	a0,8(a0)
     84c:	f87ff0ef          	jal	7d2 <nulterminate>
    break;
     850:	bfc9                	j	822 <nulterminate+0x50>

0000000000000852 <parsecmd>:
{
     852:	7179                	addi	sp,sp,-48
     854:	f406                	sd	ra,40(sp)
     856:	f022                	sd	s0,32(sp)
     858:	ec26                	sd	s1,24(sp)
     85a:	e84a                	sd	s2,16(sp)
     85c:	1800                	addi	s0,sp,48
     85e:	fca43c23          	sd	a0,-40(s0)
  es = s + strlen(s);
     862:	84aa                	mv	s1,a0
     864:	19a000ef          	jal	9fe <strlen>
     868:	1502                	slli	a0,a0,0x20
     86a:	9101                	srli	a0,a0,0x20
     86c:	94aa                	add	s1,s1,a0
  cmd = parseline(&s, es);
     86e:	85a6                	mv	a1,s1
     870:	fd840513          	addi	a0,s0,-40
     874:	e53ff0ef          	jal	6c6 <parseline>
     878:	892a                	mv	s2,a0
  peek(&s, es, "");
     87a:	00001617          	auipc	a2,0x1
     87e:	96e60613          	addi	a2,a2,-1682 # 11e8 <malloc+0x106>
     882:	85a6                	mv	a1,s1
     884:	fd840513          	addi	a0,s0,-40
     888:	bc5ff0ef          	jal	44c <peek>
  if(s != es){
     88c:	fd843603          	ld	a2,-40(s0)
     890:	00961c63          	bne	a2,s1,8a8 <parsecmd+0x56>
  nulterminate(cmd);
     894:	854a                	mv	a0,s2
     896:	f3dff0ef          	jal	7d2 <nulterminate>
}
     89a:	854a                	mv	a0,s2
     89c:	70a2                	ld	ra,40(sp)
     89e:	7402                	ld	s0,32(sp)
     8a0:	64e2                	ld	s1,24(sp)
     8a2:	6942                	ld	s2,16(sp)
     8a4:	6145                	addi	sp,sp,48
     8a6:	8082                	ret
    fprintf(2, "leftovers: %s\n", s);
     8a8:	00001597          	auipc	a1,0x1
     8ac:	a2058593          	addi	a1,a1,-1504 # 12c8 <malloc+0x1e6>
     8b0:	4509                	li	a0,2
     8b2:	752000ef          	jal	1004 <fprintf>
    panic("syntax");
     8b6:	00001517          	auipc	a0,0x1
     8ba:	9aa50513          	addi	a0,a0,-1622 # 1260 <malloc+0x17e>
     8be:	f8cff0ef          	jal	4a <panic>

00000000000008c2 <main>:
{
     8c2:	7179                	addi	sp,sp,-48
     8c4:	f406                	sd	ra,40(sp)
     8c6:	f022                	sd	s0,32(sp)
     8c8:	ec26                	sd	s1,24(sp)
     8ca:	e84a                	sd	s2,16(sp)
     8cc:	e44e                	sd	s3,8(sp)
     8ce:	e052                	sd	s4,0(sp)
     8d0:	1800                	addi	s0,sp,48
  int ppid = getppid();
     8d2:	3dc000ef          	jal	cae <getppid>
     8d6:	85aa                	mv	a1,a0
  printf("ID del parent del proceso actual: %d\n", ppid);
     8d8:	00001517          	auipc	a0,0x1
     8dc:	a0050513          	addi	a0,a0,-1536 # 12d8 <malloc+0x1f6>
     8e0:	74e000ef          	jal	102e <printf>
  while((fd = open("console", O_RDWR)) >= 0){
     8e4:	00001497          	auipc	s1,0x1
     8e8:	a1c48493          	addi	s1,s1,-1508 # 1300 <malloc+0x21e>
     8ec:	4589                	li	a1,2
     8ee:	8526                	mv	a0,s1
     8f0:	35e000ef          	jal	c4e <open>
     8f4:	00054763          	bltz	a0,902 <main+0x40>
    if(fd >= 3){
     8f8:	4789                	li	a5,2
     8fa:	fea7d9e3          	bge	a5,a0,8ec <main+0x2a>
      close(fd);
     8fe:	338000ef          	jal	c36 <close>
  while(getcmd(buf, sizeof(buf)) >= 0){
     902:	00001497          	auipc	s1,0x1
     906:	71e48493          	addi	s1,s1,1822 # 2020 <buf.0>
    if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
     90a:	06300913          	li	s2,99
     90e:	02000993          	li	s3,32
     912:	a039                	j	920 <main+0x5e>
    if(fork1() == 0)
     914:	f54ff0ef          	jal	68 <fork1>
     918:	c93d                	beqz	a0,98e <main+0xcc>
    wait(0);
     91a:	4501                	li	a0,0
     91c:	2fa000ef          	jal	c16 <wait>
  while(getcmd(buf, sizeof(buf)) >= 0){
     920:	06400593          	li	a1,100
     924:	8526                	mv	a0,s1
     926:	edaff0ef          	jal	0 <getcmd>
     92a:	06054a63          	bltz	a0,99e <main+0xdc>
    if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
     92e:	0004c783          	lbu	a5,0(s1)
     932:	ff2791e3          	bne	a5,s2,914 <main+0x52>
     936:	0014c703          	lbu	a4,1(s1)
     93a:	06400793          	li	a5,100
     93e:	fcf71be3          	bne	a4,a5,914 <main+0x52>
     942:	0024c783          	lbu	a5,2(s1)
     946:	fd3797e3          	bne	a5,s3,914 <main+0x52>
      buf[strlen(buf)-1] = 0;  // chop \n
     94a:	00001a17          	auipc	s4,0x1
     94e:	6d6a0a13          	addi	s4,s4,1750 # 2020 <buf.0>
     952:	8552                	mv	a0,s4
     954:	0aa000ef          	jal	9fe <strlen>
     958:	fff5079b          	addiw	a5,a0,-1
     95c:	1782                	slli	a5,a5,0x20
     95e:	9381                	srli	a5,a5,0x20
     960:	9a3e                	add	s4,s4,a5
     962:	000a0023          	sb	zero,0(s4)
      if(chdir(buf+3) < 0)
     966:	00001517          	auipc	a0,0x1
     96a:	6bd50513          	addi	a0,a0,1725 # 2023 <buf.0+0x3>
     96e:	310000ef          	jal	c7e <chdir>
     972:	fa0557e3          	bgez	a0,920 <main+0x5e>
        fprintf(2, "cannot cd %s\n", buf+3);
     976:	00001617          	auipc	a2,0x1
     97a:	6ad60613          	addi	a2,a2,1709 # 2023 <buf.0+0x3>
     97e:	00001597          	auipc	a1,0x1
     982:	98a58593          	addi	a1,a1,-1654 # 1308 <malloc+0x226>
     986:	4509                	li	a0,2
     988:	67c000ef          	jal	1004 <fprintf>
     98c:	bf51                	j	920 <main+0x5e>
      runcmd(parsecmd(buf));
     98e:	00001517          	auipc	a0,0x1
     992:	69250513          	addi	a0,a0,1682 # 2020 <buf.0>
     996:	ebdff0ef          	jal	852 <parsecmd>
     99a:	ef4ff0ef          	jal	8e <runcmd>
  exit(0);
     99e:	4501                	li	a0,0
     9a0:	26e000ef          	jal	c0e <exit>

00000000000009a4 <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start()
{
     9a4:	1141                	addi	sp,sp,-16
     9a6:	e406                	sd	ra,8(sp)
     9a8:	e022                	sd	s0,0(sp)
     9aa:	0800                	addi	s0,sp,16
  extern int main();
  main();
     9ac:	f17ff0ef          	jal	8c2 <main>
  exit(0);
     9b0:	4501                	li	a0,0
     9b2:	25c000ef          	jal	c0e <exit>

00000000000009b6 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
     9b6:	1141                	addi	sp,sp,-16
     9b8:	e422                	sd	s0,8(sp)
     9ba:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
     9bc:	87aa                	mv	a5,a0
     9be:	0585                	addi	a1,a1,1
     9c0:	0785                	addi	a5,a5,1
     9c2:	fff5c703          	lbu	a4,-1(a1)
     9c6:	fee78fa3          	sb	a4,-1(a5)
     9ca:	fb75                	bnez	a4,9be <strcpy+0x8>
    ;
  return os;
}
     9cc:	6422                	ld	s0,8(sp)
     9ce:	0141                	addi	sp,sp,16
     9d0:	8082                	ret

00000000000009d2 <strcmp>:

int
strcmp(const char *p, const char *q)
{
     9d2:	1141                	addi	sp,sp,-16
     9d4:	e422                	sd	s0,8(sp)
     9d6:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
     9d8:	00054783          	lbu	a5,0(a0)
     9dc:	cb91                	beqz	a5,9f0 <strcmp+0x1e>
     9de:	0005c703          	lbu	a4,0(a1)
     9e2:	00f71763          	bne	a4,a5,9f0 <strcmp+0x1e>
    p++, q++;
     9e6:	0505                	addi	a0,a0,1
     9e8:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
     9ea:	00054783          	lbu	a5,0(a0)
     9ee:	fbe5                	bnez	a5,9de <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
     9f0:	0005c503          	lbu	a0,0(a1)
}
     9f4:	40a7853b          	subw	a0,a5,a0
     9f8:	6422                	ld	s0,8(sp)
     9fa:	0141                	addi	sp,sp,16
     9fc:	8082                	ret

00000000000009fe <strlen>:

uint
strlen(const char *s)
{
     9fe:	1141                	addi	sp,sp,-16
     a00:	e422                	sd	s0,8(sp)
     a02:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
     a04:	00054783          	lbu	a5,0(a0)
     a08:	cf91                	beqz	a5,a24 <strlen+0x26>
     a0a:	0505                	addi	a0,a0,1
     a0c:	87aa                	mv	a5,a0
     a0e:	86be                	mv	a3,a5
     a10:	0785                	addi	a5,a5,1
     a12:	fff7c703          	lbu	a4,-1(a5)
     a16:	ff65                	bnez	a4,a0e <strlen+0x10>
     a18:	40a6853b          	subw	a0,a3,a0
     a1c:	2505                	addiw	a0,a0,1
    ;
  return n;
}
     a1e:	6422                	ld	s0,8(sp)
     a20:	0141                	addi	sp,sp,16
     a22:	8082                	ret
  for(n = 0; s[n]; n++)
     a24:	4501                	li	a0,0
     a26:	bfe5                	j	a1e <strlen+0x20>

0000000000000a28 <memset>:

void*
memset(void *dst, int c, uint n)
{
     a28:	1141                	addi	sp,sp,-16
     a2a:	e422                	sd	s0,8(sp)
     a2c:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
     a2e:	ca19                	beqz	a2,a44 <memset+0x1c>
     a30:	87aa                	mv	a5,a0
     a32:	1602                	slli	a2,a2,0x20
     a34:	9201                	srli	a2,a2,0x20
     a36:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
     a3a:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
     a3e:	0785                	addi	a5,a5,1
     a40:	fee79de3          	bne	a5,a4,a3a <memset+0x12>
  }
  return dst;
}
     a44:	6422                	ld	s0,8(sp)
     a46:	0141                	addi	sp,sp,16
     a48:	8082                	ret

0000000000000a4a <strchr>:

char*
strchr(const char *s, char c)
{
     a4a:	1141                	addi	sp,sp,-16
     a4c:	e422                	sd	s0,8(sp)
     a4e:	0800                	addi	s0,sp,16
  for(; *s; s++)
     a50:	00054783          	lbu	a5,0(a0)
     a54:	cb99                	beqz	a5,a6a <strchr+0x20>
    if(*s == c)
     a56:	00f58763          	beq	a1,a5,a64 <strchr+0x1a>
  for(; *s; s++)
     a5a:	0505                	addi	a0,a0,1
     a5c:	00054783          	lbu	a5,0(a0)
     a60:	fbfd                	bnez	a5,a56 <strchr+0xc>
      return (char*)s;
  return 0;
     a62:	4501                	li	a0,0
}
     a64:	6422                	ld	s0,8(sp)
     a66:	0141                	addi	sp,sp,16
     a68:	8082                	ret
  return 0;
     a6a:	4501                	li	a0,0
     a6c:	bfe5                	j	a64 <strchr+0x1a>

0000000000000a6e <gets>:

char*
gets(char *buf, int max)
{
     a6e:	711d                	addi	sp,sp,-96
     a70:	ec86                	sd	ra,88(sp)
     a72:	e8a2                	sd	s0,80(sp)
     a74:	e4a6                	sd	s1,72(sp)
     a76:	e0ca                	sd	s2,64(sp)
     a78:	fc4e                	sd	s3,56(sp)
     a7a:	f852                	sd	s4,48(sp)
     a7c:	f456                	sd	s5,40(sp)
     a7e:	f05a                	sd	s6,32(sp)
     a80:	ec5e                	sd	s7,24(sp)
     a82:	1080                	addi	s0,sp,96
     a84:	8baa                	mv	s7,a0
     a86:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     a88:	892a                	mv	s2,a0
     a8a:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
     a8c:	4aa9                	li	s5,10
     a8e:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
     a90:	89a6                	mv	s3,s1
     a92:	2485                	addiw	s1,s1,1
     a94:	0344d663          	bge	s1,s4,ac0 <gets+0x52>
    cc = read(0, &c, 1);
     a98:	4605                	li	a2,1
     a9a:	faf40593          	addi	a1,s0,-81
     a9e:	4501                	li	a0,0
     aa0:	186000ef          	jal	c26 <read>
    if(cc < 1)
     aa4:	00a05e63          	blez	a0,ac0 <gets+0x52>
    buf[i++] = c;
     aa8:	faf44783          	lbu	a5,-81(s0)
     aac:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
     ab0:	01578763          	beq	a5,s5,abe <gets+0x50>
     ab4:	0905                	addi	s2,s2,1
     ab6:	fd679de3          	bne	a5,s6,a90 <gets+0x22>
    buf[i++] = c;
     aba:	89a6                	mv	s3,s1
     abc:	a011                	j	ac0 <gets+0x52>
     abe:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
     ac0:	99de                	add	s3,s3,s7
     ac2:	00098023          	sb	zero,0(s3)
  return buf;
}
     ac6:	855e                	mv	a0,s7
     ac8:	60e6                	ld	ra,88(sp)
     aca:	6446                	ld	s0,80(sp)
     acc:	64a6                	ld	s1,72(sp)
     ace:	6906                	ld	s2,64(sp)
     ad0:	79e2                	ld	s3,56(sp)
     ad2:	7a42                	ld	s4,48(sp)
     ad4:	7aa2                	ld	s5,40(sp)
     ad6:	7b02                	ld	s6,32(sp)
     ad8:	6be2                	ld	s7,24(sp)
     ada:	6125                	addi	sp,sp,96
     adc:	8082                	ret

0000000000000ade <stat>:

int
stat(const char *n, struct stat *st)
{
     ade:	1101                	addi	sp,sp,-32
     ae0:	ec06                	sd	ra,24(sp)
     ae2:	e822                	sd	s0,16(sp)
     ae4:	e04a                	sd	s2,0(sp)
     ae6:	1000                	addi	s0,sp,32
     ae8:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     aea:	4581                	li	a1,0
     aec:	162000ef          	jal	c4e <open>
  if(fd < 0)
     af0:	02054263          	bltz	a0,b14 <stat+0x36>
     af4:	e426                	sd	s1,8(sp)
     af6:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
     af8:	85ca                	mv	a1,s2
     afa:	16c000ef          	jal	c66 <fstat>
     afe:	892a                	mv	s2,a0
  close(fd);
     b00:	8526                	mv	a0,s1
     b02:	134000ef          	jal	c36 <close>
  return r;
     b06:	64a2                	ld	s1,8(sp)
}
     b08:	854a                	mv	a0,s2
     b0a:	60e2                	ld	ra,24(sp)
     b0c:	6442                	ld	s0,16(sp)
     b0e:	6902                	ld	s2,0(sp)
     b10:	6105                	addi	sp,sp,32
     b12:	8082                	ret
    return -1;
     b14:	597d                	li	s2,-1
     b16:	bfcd                	j	b08 <stat+0x2a>

0000000000000b18 <atoi>:

int
atoi(const char *s)
{
     b18:	1141                	addi	sp,sp,-16
     b1a:	e422                	sd	s0,8(sp)
     b1c:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
     b1e:	00054683          	lbu	a3,0(a0)
     b22:	fd06879b          	addiw	a5,a3,-48
     b26:	0ff7f793          	zext.b	a5,a5
     b2a:	4625                	li	a2,9
     b2c:	02f66863          	bltu	a2,a5,b5c <atoi+0x44>
     b30:	872a                	mv	a4,a0
  n = 0;
     b32:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
     b34:	0705                	addi	a4,a4,1
     b36:	0025179b          	slliw	a5,a0,0x2
     b3a:	9fa9                	addw	a5,a5,a0
     b3c:	0017979b          	slliw	a5,a5,0x1
     b40:	9fb5                	addw	a5,a5,a3
     b42:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
     b46:	00074683          	lbu	a3,0(a4)
     b4a:	fd06879b          	addiw	a5,a3,-48
     b4e:	0ff7f793          	zext.b	a5,a5
     b52:	fef671e3          	bgeu	a2,a5,b34 <atoi+0x1c>
  return n;
}
     b56:	6422                	ld	s0,8(sp)
     b58:	0141                	addi	sp,sp,16
     b5a:	8082                	ret
  n = 0;
     b5c:	4501                	li	a0,0
     b5e:	bfe5                	j	b56 <atoi+0x3e>

0000000000000b60 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
     b60:	1141                	addi	sp,sp,-16
     b62:	e422                	sd	s0,8(sp)
     b64:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
     b66:	02b57463          	bgeu	a0,a1,b8e <memmove+0x2e>
    while(n-- > 0)
     b6a:	00c05f63          	blez	a2,b88 <memmove+0x28>
     b6e:	1602                	slli	a2,a2,0x20
     b70:	9201                	srli	a2,a2,0x20
     b72:	00c507b3          	add	a5,a0,a2
  dst = vdst;
     b76:	872a                	mv	a4,a0
      *dst++ = *src++;
     b78:	0585                	addi	a1,a1,1
     b7a:	0705                	addi	a4,a4,1
     b7c:	fff5c683          	lbu	a3,-1(a1)
     b80:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
     b84:	fef71ae3          	bne	a4,a5,b78 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
     b88:	6422                	ld	s0,8(sp)
     b8a:	0141                	addi	sp,sp,16
     b8c:	8082                	ret
    dst += n;
     b8e:	00c50733          	add	a4,a0,a2
    src += n;
     b92:	95b2                	add	a1,a1,a2
    while(n-- > 0)
     b94:	fec05ae3          	blez	a2,b88 <memmove+0x28>
     b98:	fff6079b          	addiw	a5,a2,-1
     b9c:	1782                	slli	a5,a5,0x20
     b9e:	9381                	srli	a5,a5,0x20
     ba0:	fff7c793          	not	a5,a5
     ba4:	97ba                	add	a5,a5,a4
      *--dst = *--src;
     ba6:	15fd                	addi	a1,a1,-1
     ba8:	177d                	addi	a4,a4,-1
     baa:	0005c683          	lbu	a3,0(a1)
     bae:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
     bb2:	fee79ae3          	bne	a5,a4,ba6 <memmove+0x46>
     bb6:	bfc9                	j	b88 <memmove+0x28>

0000000000000bb8 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
     bb8:	1141                	addi	sp,sp,-16
     bba:	e422                	sd	s0,8(sp)
     bbc:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
     bbe:	ca05                	beqz	a2,bee <memcmp+0x36>
     bc0:	fff6069b          	addiw	a3,a2,-1
     bc4:	1682                	slli	a3,a3,0x20
     bc6:	9281                	srli	a3,a3,0x20
     bc8:	0685                	addi	a3,a3,1
     bca:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
     bcc:	00054783          	lbu	a5,0(a0)
     bd0:	0005c703          	lbu	a4,0(a1)
     bd4:	00e79863          	bne	a5,a4,be4 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
     bd8:	0505                	addi	a0,a0,1
    p2++;
     bda:	0585                	addi	a1,a1,1
  while (n-- > 0) {
     bdc:	fed518e3          	bne	a0,a3,bcc <memcmp+0x14>
  }
  return 0;
     be0:	4501                	li	a0,0
     be2:	a019                	j	be8 <memcmp+0x30>
      return *p1 - *p2;
     be4:	40e7853b          	subw	a0,a5,a4
}
     be8:	6422                	ld	s0,8(sp)
     bea:	0141                	addi	sp,sp,16
     bec:	8082                	ret
  return 0;
     bee:	4501                	li	a0,0
     bf0:	bfe5                	j	be8 <memcmp+0x30>

0000000000000bf2 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
     bf2:	1141                	addi	sp,sp,-16
     bf4:	e406                	sd	ra,8(sp)
     bf6:	e022                	sd	s0,0(sp)
     bf8:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
     bfa:	f67ff0ef          	jal	b60 <memmove>
}
     bfe:	60a2                	ld	ra,8(sp)
     c00:	6402                	ld	s0,0(sp)
     c02:	0141                	addi	sp,sp,16
     c04:	8082                	ret

0000000000000c06 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
     c06:	4885                	li	a7,1
 ecall
     c08:	00000073          	ecall
 ret
     c0c:	8082                	ret

0000000000000c0e <exit>:
.global exit
exit:
 li a7, SYS_exit
     c0e:	4889                	li	a7,2
 ecall
     c10:	00000073          	ecall
 ret
     c14:	8082                	ret

0000000000000c16 <wait>:
.global wait
wait:
 li a7, SYS_wait
     c16:	488d                	li	a7,3
 ecall
     c18:	00000073          	ecall
 ret
     c1c:	8082                	ret

0000000000000c1e <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
     c1e:	4891                	li	a7,4
 ecall
     c20:	00000073          	ecall
 ret
     c24:	8082                	ret

0000000000000c26 <read>:
.global read
read:
 li a7, SYS_read
     c26:	4895                	li	a7,5
 ecall
     c28:	00000073          	ecall
 ret
     c2c:	8082                	ret

0000000000000c2e <write>:
.global write
write:
 li a7, SYS_write
     c2e:	48c1                	li	a7,16
 ecall
     c30:	00000073          	ecall
 ret
     c34:	8082                	ret

0000000000000c36 <close>:
.global close
close:
 li a7, SYS_close
     c36:	48d5                	li	a7,21
 ecall
     c38:	00000073          	ecall
 ret
     c3c:	8082                	ret

0000000000000c3e <kill>:
.global kill
kill:
 li a7, SYS_kill
     c3e:	4899                	li	a7,6
 ecall
     c40:	00000073          	ecall
 ret
     c44:	8082                	ret

0000000000000c46 <exec>:
.global exec
exec:
 li a7, SYS_exec
     c46:	489d                	li	a7,7
 ecall
     c48:	00000073          	ecall
 ret
     c4c:	8082                	ret

0000000000000c4e <open>:
.global open
open:
 li a7, SYS_open
     c4e:	48bd                	li	a7,15
 ecall
     c50:	00000073          	ecall
 ret
     c54:	8082                	ret

0000000000000c56 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
     c56:	48c5                	li	a7,17
 ecall
     c58:	00000073          	ecall
 ret
     c5c:	8082                	ret

0000000000000c5e <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
     c5e:	48c9                	li	a7,18
 ecall
     c60:	00000073          	ecall
 ret
     c64:	8082                	ret

0000000000000c66 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
     c66:	48a1                	li	a7,8
 ecall
     c68:	00000073          	ecall
 ret
     c6c:	8082                	ret

0000000000000c6e <link>:
.global link
link:
 li a7, SYS_link
     c6e:	48cd                	li	a7,19
 ecall
     c70:	00000073          	ecall
 ret
     c74:	8082                	ret

0000000000000c76 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
     c76:	48d1                	li	a7,20
 ecall
     c78:	00000073          	ecall
 ret
     c7c:	8082                	ret

0000000000000c7e <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
     c7e:	48a5                	li	a7,9
 ecall
     c80:	00000073          	ecall
 ret
     c84:	8082                	ret

0000000000000c86 <dup>:
.global dup
dup:
 li a7, SYS_dup
     c86:	48a9                	li	a7,10
 ecall
     c88:	00000073          	ecall
 ret
     c8c:	8082                	ret

0000000000000c8e <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
     c8e:	48ad                	li	a7,11
 ecall
     c90:	00000073          	ecall
 ret
     c94:	8082                	ret

0000000000000c96 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
     c96:	48b1                	li	a7,12
 ecall
     c98:	00000073          	ecall
 ret
     c9c:	8082                	ret

0000000000000c9e <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
     c9e:	48b5                	li	a7,13
 ecall
     ca0:	00000073          	ecall
 ret
     ca4:	8082                	ret

0000000000000ca6 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
     ca6:	48b9                	li	a7,14
 ecall
     ca8:	00000073          	ecall
 ret
     cac:	8082                	ret

0000000000000cae <getppid>:
.global getppid
getppid:
 li a7, SYS_getppid
     cae:	48d9                	li	a7,22
 ecall
     cb0:	00000073          	ecall
 ret
     cb4:	8082                	ret

0000000000000cb6 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
     cb6:	1101                	addi	sp,sp,-32
     cb8:	ec06                	sd	ra,24(sp)
     cba:	e822                	sd	s0,16(sp)
     cbc:	1000                	addi	s0,sp,32
     cbe:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
     cc2:	4605                	li	a2,1
     cc4:	fef40593          	addi	a1,s0,-17
     cc8:	f67ff0ef          	jal	c2e <write>
}
     ccc:	60e2                	ld	ra,24(sp)
     cce:	6442                	ld	s0,16(sp)
     cd0:	6105                	addi	sp,sp,32
     cd2:	8082                	ret

0000000000000cd4 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     cd4:	7139                	addi	sp,sp,-64
     cd6:	fc06                	sd	ra,56(sp)
     cd8:	f822                	sd	s0,48(sp)
     cda:	f426                	sd	s1,40(sp)
     cdc:	0080                	addi	s0,sp,64
     cde:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
     ce0:	c299                	beqz	a3,ce6 <printint+0x12>
     ce2:	0805c963          	bltz	a1,d74 <printint+0xa0>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
     ce6:	2581                	sext.w	a1,a1
  neg = 0;
     ce8:	4881                	li	a7,0
     cea:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
     cee:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
     cf0:	2601                	sext.w	a2,a2
     cf2:	00000517          	auipc	a0,0x0
     cf6:	65e50513          	addi	a0,a0,1630 # 1350 <digits>
     cfa:	883a                	mv	a6,a4
     cfc:	2705                	addiw	a4,a4,1
     cfe:	02c5f7bb          	remuw	a5,a1,a2
     d02:	1782                	slli	a5,a5,0x20
     d04:	9381                	srli	a5,a5,0x20
     d06:	97aa                	add	a5,a5,a0
     d08:	0007c783          	lbu	a5,0(a5)
     d0c:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
     d10:	0005879b          	sext.w	a5,a1
     d14:	02c5d5bb          	divuw	a1,a1,a2
     d18:	0685                	addi	a3,a3,1
     d1a:	fec7f0e3          	bgeu	a5,a2,cfa <printint+0x26>
  if(neg)
     d1e:	00088c63          	beqz	a7,d36 <printint+0x62>
    buf[i++] = '-';
     d22:	fd070793          	addi	a5,a4,-48
     d26:	00878733          	add	a4,a5,s0
     d2a:	02d00793          	li	a5,45
     d2e:	fef70823          	sb	a5,-16(a4)
     d32:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
     d36:	02e05a63          	blez	a4,d6a <printint+0x96>
     d3a:	f04a                	sd	s2,32(sp)
     d3c:	ec4e                	sd	s3,24(sp)
     d3e:	fc040793          	addi	a5,s0,-64
     d42:	00e78933          	add	s2,a5,a4
     d46:	fff78993          	addi	s3,a5,-1
     d4a:	99ba                	add	s3,s3,a4
     d4c:	377d                	addiw	a4,a4,-1
     d4e:	1702                	slli	a4,a4,0x20
     d50:	9301                	srli	a4,a4,0x20
     d52:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
     d56:	fff94583          	lbu	a1,-1(s2)
     d5a:	8526                	mv	a0,s1
     d5c:	f5bff0ef          	jal	cb6 <putc>
  while(--i >= 0)
     d60:	197d                	addi	s2,s2,-1
     d62:	ff391ae3          	bne	s2,s3,d56 <printint+0x82>
     d66:	7902                	ld	s2,32(sp)
     d68:	69e2                	ld	s3,24(sp)
}
     d6a:	70e2                	ld	ra,56(sp)
     d6c:	7442                	ld	s0,48(sp)
     d6e:	74a2                	ld	s1,40(sp)
     d70:	6121                	addi	sp,sp,64
     d72:	8082                	ret
    x = -xx;
     d74:	40b005bb          	negw	a1,a1
    neg = 1;
     d78:	4885                	li	a7,1
    x = -xx;
     d7a:	bf85                	j	cea <printint+0x16>

0000000000000d7c <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
     d7c:	711d                	addi	sp,sp,-96
     d7e:	ec86                	sd	ra,88(sp)
     d80:	e8a2                	sd	s0,80(sp)
     d82:	e0ca                	sd	s2,64(sp)
     d84:	1080                	addi	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
     d86:	0005c903          	lbu	s2,0(a1)
     d8a:	26090863          	beqz	s2,ffa <vprintf+0x27e>
     d8e:	e4a6                	sd	s1,72(sp)
     d90:	fc4e                	sd	s3,56(sp)
     d92:	f852                	sd	s4,48(sp)
     d94:	f456                	sd	s5,40(sp)
     d96:	f05a                	sd	s6,32(sp)
     d98:	ec5e                	sd	s7,24(sp)
     d9a:	e862                	sd	s8,16(sp)
     d9c:	e466                	sd	s9,8(sp)
     d9e:	8b2a                	mv	s6,a0
     da0:	8a2e                	mv	s4,a1
     da2:	8bb2                	mv	s7,a2
  state = 0;
     da4:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
     da6:	4481                	li	s1,0
     da8:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
     daa:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
     dae:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
     db2:	06c00c93          	li	s9,108
     db6:	a005                	j	dd6 <vprintf+0x5a>
        putc(fd, c0);
     db8:	85ca                	mv	a1,s2
     dba:	855a                	mv	a0,s6
     dbc:	efbff0ef          	jal	cb6 <putc>
     dc0:	a019                	j	dc6 <vprintf+0x4a>
    } else if(state == '%'){
     dc2:	03598263          	beq	s3,s5,de6 <vprintf+0x6a>
  for(i = 0; fmt[i]; i++){
     dc6:	2485                	addiw	s1,s1,1
     dc8:	8726                	mv	a4,s1
     dca:	009a07b3          	add	a5,s4,s1
     dce:	0007c903          	lbu	s2,0(a5)
     dd2:	20090c63          	beqz	s2,fea <vprintf+0x26e>
    c0 = fmt[i] & 0xff;
     dd6:	0009079b          	sext.w	a5,s2
    if(state == 0){
     dda:	fe0994e3          	bnez	s3,dc2 <vprintf+0x46>
      if(c0 == '%'){
     dde:	fd579de3          	bne	a5,s5,db8 <vprintf+0x3c>
        state = '%';
     de2:	89be                	mv	s3,a5
     de4:	b7cd                	j	dc6 <vprintf+0x4a>
      if(c0) c1 = fmt[i+1] & 0xff;
     de6:	00ea06b3          	add	a3,s4,a4
     dea:	0016c683          	lbu	a3,1(a3)
      c1 = c2 = 0;
     dee:	8636                	mv	a2,a3
      if(c1) c2 = fmt[i+2] & 0xff;
     df0:	c681                	beqz	a3,df8 <vprintf+0x7c>
     df2:	9752                	add	a4,a4,s4
     df4:	00274603          	lbu	a2,2(a4)
      if(c0 == 'd'){
     df8:	03878f63          	beq	a5,s8,e36 <vprintf+0xba>
      } else if(c0 == 'l' && c1 == 'd'){
     dfc:	05978963          	beq	a5,s9,e4e <vprintf+0xd2>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
     e00:	07500713          	li	a4,117
     e04:	0ee78363          	beq	a5,a4,eea <vprintf+0x16e>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
     e08:	07800713          	li	a4,120
     e0c:	12e78563          	beq	a5,a4,f36 <vprintf+0x1ba>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
     e10:	07000713          	li	a4,112
     e14:	14e78a63          	beq	a5,a4,f68 <vprintf+0x1ec>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 's'){
     e18:	07300713          	li	a4,115
     e1c:	18e78a63          	beq	a5,a4,fb0 <vprintf+0x234>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
     e20:	02500713          	li	a4,37
     e24:	04e79563          	bne	a5,a4,e6e <vprintf+0xf2>
        putc(fd, '%');
     e28:	02500593          	li	a1,37
     e2c:	855a                	mv	a0,s6
     e2e:	e89ff0ef          	jal	cb6 <putc>
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
#endif
      state = 0;
     e32:	4981                	li	s3,0
     e34:	bf49                	j	dc6 <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 1);
     e36:	008b8913          	addi	s2,s7,8
     e3a:	4685                	li	a3,1
     e3c:	4629                	li	a2,10
     e3e:	000ba583          	lw	a1,0(s7)
     e42:	855a                	mv	a0,s6
     e44:	e91ff0ef          	jal	cd4 <printint>
     e48:	8bca                	mv	s7,s2
      state = 0;
     e4a:	4981                	li	s3,0
     e4c:	bfad                	j	dc6 <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'd'){
     e4e:	06400793          	li	a5,100
     e52:	02f68963          	beq	a3,a5,e84 <vprintf+0x108>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
     e56:	06c00793          	li	a5,108
     e5a:	04f68263          	beq	a3,a5,e9e <vprintf+0x122>
      } else if(c0 == 'l' && c1 == 'u'){
     e5e:	07500793          	li	a5,117
     e62:	0af68063          	beq	a3,a5,f02 <vprintf+0x186>
      } else if(c0 == 'l' && c1 == 'x'){
     e66:	07800793          	li	a5,120
     e6a:	0ef68263          	beq	a3,a5,f4e <vprintf+0x1d2>
        putc(fd, '%');
     e6e:	02500593          	li	a1,37
     e72:	855a                	mv	a0,s6
     e74:	e43ff0ef          	jal	cb6 <putc>
        putc(fd, c0);
     e78:	85ca                	mv	a1,s2
     e7a:	855a                	mv	a0,s6
     e7c:	e3bff0ef          	jal	cb6 <putc>
      state = 0;
     e80:	4981                	li	s3,0
     e82:	b791                	j	dc6 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
     e84:	008b8913          	addi	s2,s7,8
     e88:	4685                	li	a3,1
     e8a:	4629                	li	a2,10
     e8c:	000ba583          	lw	a1,0(s7)
     e90:	855a                	mv	a0,s6
     e92:	e43ff0ef          	jal	cd4 <printint>
        i += 1;
     e96:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 1);
     e98:	8bca                	mv	s7,s2
      state = 0;
     e9a:	4981                	li	s3,0
        i += 1;
     e9c:	b72d                	j	dc6 <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
     e9e:	06400793          	li	a5,100
     ea2:	02f60763          	beq	a2,a5,ed0 <vprintf+0x154>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
     ea6:	07500793          	li	a5,117
     eaa:	06f60963          	beq	a2,a5,f1c <vprintf+0x1a0>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
     eae:	07800793          	li	a5,120
     eb2:	faf61ee3          	bne	a2,a5,e6e <vprintf+0xf2>
        printint(fd, va_arg(ap, uint64), 16, 0);
     eb6:	008b8913          	addi	s2,s7,8
     eba:	4681                	li	a3,0
     ebc:	4641                	li	a2,16
     ebe:	000ba583          	lw	a1,0(s7)
     ec2:	855a                	mv	a0,s6
     ec4:	e11ff0ef          	jal	cd4 <printint>
        i += 2;
     ec8:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 16, 0);
     eca:	8bca                	mv	s7,s2
      state = 0;
     ecc:	4981                	li	s3,0
        i += 2;
     ece:	bde5                	j	dc6 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
     ed0:	008b8913          	addi	s2,s7,8
     ed4:	4685                	li	a3,1
     ed6:	4629                	li	a2,10
     ed8:	000ba583          	lw	a1,0(s7)
     edc:	855a                	mv	a0,s6
     ede:	df7ff0ef          	jal	cd4 <printint>
        i += 2;
     ee2:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 1);
     ee4:	8bca                	mv	s7,s2
      state = 0;
     ee6:	4981                	li	s3,0
        i += 2;
     ee8:	bdf9                	j	dc6 <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 0);
     eea:	008b8913          	addi	s2,s7,8
     eee:	4681                	li	a3,0
     ef0:	4629                	li	a2,10
     ef2:	000ba583          	lw	a1,0(s7)
     ef6:	855a                	mv	a0,s6
     ef8:	dddff0ef          	jal	cd4 <printint>
     efc:	8bca                	mv	s7,s2
      state = 0;
     efe:	4981                	li	s3,0
     f00:	b5d9                	j	dc6 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
     f02:	008b8913          	addi	s2,s7,8
     f06:	4681                	li	a3,0
     f08:	4629                	li	a2,10
     f0a:	000ba583          	lw	a1,0(s7)
     f0e:	855a                	mv	a0,s6
     f10:	dc5ff0ef          	jal	cd4 <printint>
        i += 1;
     f14:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 0);
     f16:	8bca                	mv	s7,s2
      state = 0;
     f18:	4981                	li	s3,0
        i += 1;
     f1a:	b575                	j	dc6 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
     f1c:	008b8913          	addi	s2,s7,8
     f20:	4681                	li	a3,0
     f22:	4629                	li	a2,10
     f24:	000ba583          	lw	a1,0(s7)
     f28:	855a                	mv	a0,s6
     f2a:	dabff0ef          	jal	cd4 <printint>
        i += 2;
     f2e:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 0);
     f30:	8bca                	mv	s7,s2
      state = 0;
     f32:	4981                	li	s3,0
        i += 2;
     f34:	bd49                	j	dc6 <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 16, 0);
     f36:	008b8913          	addi	s2,s7,8
     f3a:	4681                	li	a3,0
     f3c:	4641                	li	a2,16
     f3e:	000ba583          	lw	a1,0(s7)
     f42:	855a                	mv	a0,s6
     f44:	d91ff0ef          	jal	cd4 <printint>
     f48:	8bca                	mv	s7,s2
      state = 0;
     f4a:	4981                	li	s3,0
     f4c:	bdad                	j	dc6 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 16, 0);
     f4e:	008b8913          	addi	s2,s7,8
     f52:	4681                	li	a3,0
     f54:	4641                	li	a2,16
     f56:	000ba583          	lw	a1,0(s7)
     f5a:	855a                	mv	a0,s6
     f5c:	d79ff0ef          	jal	cd4 <printint>
        i += 1;
     f60:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 16, 0);
     f62:	8bca                	mv	s7,s2
      state = 0;
     f64:	4981                	li	s3,0
        i += 1;
     f66:	b585                	j	dc6 <vprintf+0x4a>
     f68:	e06a                	sd	s10,0(sp)
        printptr(fd, va_arg(ap, uint64));
     f6a:	008b8d13          	addi	s10,s7,8
     f6e:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
     f72:	03000593          	li	a1,48
     f76:	855a                	mv	a0,s6
     f78:	d3fff0ef          	jal	cb6 <putc>
  putc(fd, 'x');
     f7c:	07800593          	li	a1,120
     f80:	855a                	mv	a0,s6
     f82:	d35ff0ef          	jal	cb6 <putc>
     f86:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
     f88:	00000b97          	auipc	s7,0x0
     f8c:	3c8b8b93          	addi	s7,s7,968 # 1350 <digits>
     f90:	03c9d793          	srli	a5,s3,0x3c
     f94:	97de                	add	a5,a5,s7
     f96:	0007c583          	lbu	a1,0(a5)
     f9a:	855a                	mv	a0,s6
     f9c:	d1bff0ef          	jal	cb6 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
     fa0:	0992                	slli	s3,s3,0x4
     fa2:	397d                	addiw	s2,s2,-1
     fa4:	fe0916e3          	bnez	s2,f90 <vprintf+0x214>
        printptr(fd, va_arg(ap, uint64));
     fa8:	8bea                	mv	s7,s10
      state = 0;
     faa:	4981                	li	s3,0
     fac:	6d02                	ld	s10,0(sp)
     fae:	bd21                	j	dc6 <vprintf+0x4a>
        if((s = va_arg(ap, char*)) == 0)
     fb0:	008b8993          	addi	s3,s7,8
     fb4:	000bb903          	ld	s2,0(s7)
     fb8:	00090f63          	beqz	s2,fd6 <vprintf+0x25a>
        for(; *s; s++)
     fbc:	00094583          	lbu	a1,0(s2)
     fc0:	c195                	beqz	a1,fe4 <vprintf+0x268>
          putc(fd, *s);
     fc2:	855a                	mv	a0,s6
     fc4:	cf3ff0ef          	jal	cb6 <putc>
        for(; *s; s++)
     fc8:	0905                	addi	s2,s2,1
     fca:	00094583          	lbu	a1,0(s2)
     fce:	f9f5                	bnez	a1,fc2 <vprintf+0x246>
        if((s = va_arg(ap, char*)) == 0)
     fd0:	8bce                	mv	s7,s3
      state = 0;
     fd2:	4981                	li	s3,0
     fd4:	bbcd                	j	dc6 <vprintf+0x4a>
          s = "(null)";
     fd6:	00000917          	auipc	s2,0x0
     fda:	34290913          	addi	s2,s2,834 # 1318 <malloc+0x236>
        for(; *s; s++)
     fde:	02800593          	li	a1,40
     fe2:	b7c5                	j	fc2 <vprintf+0x246>
        if((s = va_arg(ap, char*)) == 0)
     fe4:	8bce                	mv	s7,s3
      state = 0;
     fe6:	4981                	li	s3,0
     fe8:	bbf9                	j	dc6 <vprintf+0x4a>
     fea:	64a6                	ld	s1,72(sp)
     fec:	79e2                	ld	s3,56(sp)
     fee:	7a42                	ld	s4,48(sp)
     ff0:	7aa2                	ld	s5,40(sp)
     ff2:	7b02                	ld	s6,32(sp)
     ff4:	6be2                	ld	s7,24(sp)
     ff6:	6c42                	ld	s8,16(sp)
     ff8:	6ca2                	ld	s9,8(sp)
    }
  }
}
     ffa:	60e6                	ld	ra,88(sp)
     ffc:	6446                	ld	s0,80(sp)
     ffe:	6906                	ld	s2,64(sp)
    1000:	6125                	addi	sp,sp,96
    1002:	8082                	ret

0000000000001004 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
    1004:	715d                	addi	sp,sp,-80
    1006:	ec06                	sd	ra,24(sp)
    1008:	e822                	sd	s0,16(sp)
    100a:	1000                	addi	s0,sp,32
    100c:	e010                	sd	a2,0(s0)
    100e:	e414                	sd	a3,8(s0)
    1010:	e818                	sd	a4,16(s0)
    1012:	ec1c                	sd	a5,24(s0)
    1014:	03043023          	sd	a6,32(s0)
    1018:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
    101c:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
    1020:	8622                	mv	a2,s0
    1022:	d5bff0ef          	jal	d7c <vprintf>
}
    1026:	60e2                	ld	ra,24(sp)
    1028:	6442                	ld	s0,16(sp)
    102a:	6161                	addi	sp,sp,80
    102c:	8082                	ret

000000000000102e <printf>:

void
printf(const char *fmt, ...)
{
    102e:	711d                	addi	sp,sp,-96
    1030:	ec06                	sd	ra,24(sp)
    1032:	e822                	sd	s0,16(sp)
    1034:	1000                	addi	s0,sp,32
    1036:	e40c                	sd	a1,8(s0)
    1038:	e810                	sd	a2,16(s0)
    103a:	ec14                	sd	a3,24(s0)
    103c:	f018                	sd	a4,32(s0)
    103e:	f41c                	sd	a5,40(s0)
    1040:	03043823          	sd	a6,48(s0)
    1044:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
    1048:	00840613          	addi	a2,s0,8
    104c:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
    1050:	85aa                	mv	a1,a0
    1052:	4505                	li	a0,1
    1054:	d29ff0ef          	jal	d7c <vprintf>
}
    1058:	60e2                	ld	ra,24(sp)
    105a:	6442                	ld	s0,16(sp)
    105c:	6125                	addi	sp,sp,96
    105e:	8082                	ret

0000000000001060 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    1060:	1141                	addi	sp,sp,-16
    1062:	e422                	sd	s0,8(sp)
    1064:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
    1066:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    106a:	00001797          	auipc	a5,0x1
    106e:	fa67b783          	ld	a5,-90(a5) # 2010 <freep>
    1072:	a02d                	j	109c <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
    1074:	4618                	lw	a4,8(a2)
    1076:	9f2d                	addw	a4,a4,a1
    1078:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
    107c:	6398                	ld	a4,0(a5)
    107e:	6310                	ld	a2,0(a4)
    1080:	a83d                	j	10be <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    1082:	ff852703          	lw	a4,-8(a0)
    1086:	9f31                	addw	a4,a4,a2
    1088:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
    108a:	ff053683          	ld	a3,-16(a0)
    108e:	a091                	j	10d2 <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1090:	6398                	ld	a4,0(a5)
    1092:	00e7e463          	bltu	a5,a4,109a <free+0x3a>
    1096:	00e6ea63          	bltu	a3,a4,10aa <free+0x4a>
{
    109a:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    109c:	fed7fae3          	bgeu	a5,a3,1090 <free+0x30>
    10a0:	6398                	ld	a4,0(a5)
    10a2:	00e6e463          	bltu	a3,a4,10aa <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    10a6:	fee7eae3          	bltu	a5,a4,109a <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
    10aa:	ff852583          	lw	a1,-8(a0)
    10ae:	6390                	ld	a2,0(a5)
    10b0:	02059813          	slli	a6,a1,0x20
    10b4:	01c85713          	srli	a4,a6,0x1c
    10b8:	9736                	add	a4,a4,a3
    10ba:	fae60de3          	beq	a2,a4,1074 <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
    10be:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
    10c2:	4790                	lw	a2,8(a5)
    10c4:	02061593          	slli	a1,a2,0x20
    10c8:	01c5d713          	srli	a4,a1,0x1c
    10cc:	973e                	add	a4,a4,a5
    10ce:	fae68ae3          	beq	a3,a4,1082 <free+0x22>
    p->s.ptr = bp->s.ptr;
    10d2:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
    10d4:	00001717          	auipc	a4,0x1
    10d8:	f2f73e23          	sd	a5,-196(a4) # 2010 <freep>
}
    10dc:	6422                	ld	s0,8(sp)
    10de:	0141                	addi	sp,sp,16
    10e0:	8082                	ret

00000000000010e2 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    10e2:	7139                	addi	sp,sp,-64
    10e4:	fc06                	sd	ra,56(sp)
    10e6:	f822                	sd	s0,48(sp)
    10e8:	f426                	sd	s1,40(sp)
    10ea:	ec4e                	sd	s3,24(sp)
    10ec:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    10ee:	02051493          	slli	s1,a0,0x20
    10f2:	9081                	srli	s1,s1,0x20
    10f4:	04bd                	addi	s1,s1,15
    10f6:	8091                	srli	s1,s1,0x4
    10f8:	0014899b          	addiw	s3,s1,1
    10fc:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
    10fe:	00001517          	auipc	a0,0x1
    1102:	f1253503          	ld	a0,-238(a0) # 2010 <freep>
    1106:	c915                	beqz	a0,113a <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1108:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    110a:	4798                	lw	a4,8(a5)
    110c:	08977a63          	bgeu	a4,s1,11a0 <malloc+0xbe>
    1110:	f04a                	sd	s2,32(sp)
    1112:	e852                	sd	s4,16(sp)
    1114:	e456                	sd	s5,8(sp)
    1116:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
    1118:	8a4e                	mv	s4,s3
    111a:	0009871b          	sext.w	a4,s3
    111e:	6685                	lui	a3,0x1
    1120:	00d77363          	bgeu	a4,a3,1126 <malloc+0x44>
    1124:	6a05                	lui	s4,0x1
    1126:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
    112a:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    112e:	00001917          	auipc	s2,0x1
    1132:	ee290913          	addi	s2,s2,-286 # 2010 <freep>
  if(p == (char*)-1)
    1136:	5afd                	li	s5,-1
    1138:	a081                	j	1178 <malloc+0x96>
    113a:	f04a                	sd	s2,32(sp)
    113c:	e852                	sd	s4,16(sp)
    113e:	e456                	sd	s5,8(sp)
    1140:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
    1142:	00001797          	auipc	a5,0x1
    1146:	f4678793          	addi	a5,a5,-186 # 2088 <base>
    114a:	00001717          	auipc	a4,0x1
    114e:	ecf73323          	sd	a5,-314(a4) # 2010 <freep>
    1152:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
    1154:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
    1158:	b7c1                	j	1118 <malloc+0x36>
        prevp->s.ptr = p->s.ptr;
    115a:	6398                	ld	a4,0(a5)
    115c:	e118                	sd	a4,0(a0)
    115e:	a8a9                	j	11b8 <malloc+0xd6>
  hp->s.size = nu;
    1160:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
    1164:	0541                	addi	a0,a0,16
    1166:	efbff0ef          	jal	1060 <free>
  return freep;
    116a:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
    116e:	c12d                	beqz	a0,11d0 <malloc+0xee>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1170:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    1172:	4798                	lw	a4,8(a5)
    1174:	02977263          	bgeu	a4,s1,1198 <malloc+0xb6>
    if(p == freep)
    1178:	00093703          	ld	a4,0(s2)
    117c:	853e                	mv	a0,a5
    117e:	fef719e3          	bne	a4,a5,1170 <malloc+0x8e>
  p = sbrk(nu * sizeof(Header));
    1182:	8552                	mv	a0,s4
    1184:	b13ff0ef          	jal	c96 <sbrk>
  if(p == (char*)-1)
    1188:	fd551ce3          	bne	a0,s5,1160 <malloc+0x7e>
        return 0;
    118c:	4501                	li	a0,0
    118e:	7902                	ld	s2,32(sp)
    1190:	6a42                	ld	s4,16(sp)
    1192:	6aa2                	ld	s5,8(sp)
    1194:	6b02                	ld	s6,0(sp)
    1196:	a03d                	j	11c4 <malloc+0xe2>
    1198:	7902                	ld	s2,32(sp)
    119a:	6a42                	ld	s4,16(sp)
    119c:	6aa2                	ld	s5,8(sp)
    119e:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
    11a0:	fae48de3          	beq	s1,a4,115a <malloc+0x78>
        p->s.size -= nunits;
    11a4:	4137073b          	subw	a4,a4,s3
    11a8:	c798                	sw	a4,8(a5)
        p += p->s.size;
    11aa:	02071693          	slli	a3,a4,0x20
    11ae:	01c6d713          	srli	a4,a3,0x1c
    11b2:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
    11b4:	0137a423          	sw	s3,8(a5)
      freep = prevp;
    11b8:	00001717          	auipc	a4,0x1
    11bc:	e4a73c23          	sd	a0,-424(a4) # 2010 <freep>
      return (void*)(p + 1);
    11c0:	01078513          	addi	a0,a5,16
  }
}
    11c4:	70e2                	ld	ra,56(sp)
    11c6:	7442                	ld	s0,48(sp)
    11c8:	74a2                	ld	s1,40(sp)
    11ca:	69e2                	ld	s3,24(sp)
    11cc:	6121                	addi	sp,sp,64
    11ce:	8082                	ret
    11d0:	7902                	ld	s2,32(sp)
    11d2:	6a42                	ld	s4,16(sp)
    11d4:	6aa2                	ld	s5,8(sp)
    11d6:	6b02                	ld	s6,0(sp)
    11d8:	b7f5                	j	11c4 <malloc+0xe2>
