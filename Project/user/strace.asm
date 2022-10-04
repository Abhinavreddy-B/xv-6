
user/_strace:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/types.h"
#include "user/user.h"

int main(int argc,char* argv[]){
   0:	1101                	addi	sp,sp,-32
   2:	ec06                	sd	ra,24(sp)
   4:	e822                	sd	s0,16(sp)
   6:	e426                	sd	s1,8(sp)
   8:	1000                	addi	s0,sp,32
    if(argc<=2){
   a:	4789                	li	a5,2
   c:	02a7c063          	blt	a5,a0,2c <main+0x2c>
        fprintf(2,"strace: invalid number of arguments");
  10:	00001597          	auipc	a1,0x1
  14:	83058593          	addi	a1,a1,-2000 # 840 <malloc+0xee>
  18:	4509                	li	a0,2
  1a:	00000097          	auipc	ra,0x0
  1e:	64c080e7          	jalr	1612(ra) # 666 <fprintf>
        exit(1);
  22:	4505                	li	a0,1
  24:	00000097          	auipc	ra,0x0
  28:	2e0080e7          	jalr	736(ra) # 304 <exit>
  2c:	84ae                	mv	s1,a1
    }
    trace(atoi(argv[1]));
  2e:	6588                	ld	a0,8(a1)
  30:	00000097          	auipc	ra,0x0
  34:	1d8080e7          	jalr	472(ra) # 208 <atoi>
  38:	00000097          	auipc	ra,0x0
  3c:	36c080e7          	jalr	876(ra) # 3a4 <trace>
    if(exec(argv[2],&argv[2]) == -1){
  40:	01048593          	addi	a1,s1,16
  44:	6888                	ld	a0,16(s1)
  46:	00000097          	auipc	ra,0x0
  4a:	2f6080e7          	jalr	758(ra) # 33c <exec>
  4e:	57fd                	li	a5,-1
  50:	00f50763          	beq	a0,a5,5e <main+0x5e>
        fprintf(2,"exec: unable to find %s\n",argv[2]);
        exit(1);
    };
    exit(0);
  54:	4501                	li	a0,0
  56:	00000097          	auipc	ra,0x0
  5a:	2ae080e7          	jalr	686(ra) # 304 <exit>
        fprintf(2,"exec: unable to find %s\n",argv[2]);
  5e:	6890                	ld	a2,16(s1)
  60:	00001597          	auipc	a1,0x1
  64:	80858593          	addi	a1,a1,-2040 # 868 <malloc+0x116>
  68:	4509                	li	a0,2
  6a:	00000097          	auipc	ra,0x0
  6e:	5fc080e7          	jalr	1532(ra) # 666 <fprintf>
        exit(1);
  72:	4505                	li	a0,1
  74:	00000097          	auipc	ra,0x0
  78:	290080e7          	jalr	656(ra) # 304 <exit>

000000000000007c <_main>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
_main()
{
  7c:	1141                	addi	sp,sp,-16
  7e:	e406                	sd	ra,8(sp)
  80:	e022                	sd	s0,0(sp)
  82:	0800                	addi	s0,sp,16
  extern int main();
  main();
  84:	00000097          	auipc	ra,0x0
  88:	f7c080e7          	jalr	-132(ra) # 0 <main>
  exit(0);
  8c:	4501                	li	a0,0
  8e:	00000097          	auipc	ra,0x0
  92:	276080e7          	jalr	630(ra) # 304 <exit>

0000000000000096 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
  96:	1141                	addi	sp,sp,-16
  98:	e422                	sd	s0,8(sp)
  9a:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  9c:	87aa                	mv	a5,a0
  9e:	0585                	addi	a1,a1,1
  a0:	0785                	addi	a5,a5,1
  a2:	fff5c703          	lbu	a4,-1(a1)
  a6:	fee78fa3          	sb	a4,-1(a5)
  aa:	fb75                	bnez	a4,9e <strcpy+0x8>
    ;
  return os;
}
  ac:	6422                	ld	s0,8(sp)
  ae:	0141                	addi	sp,sp,16
  b0:	8082                	ret

00000000000000b2 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  b2:	1141                	addi	sp,sp,-16
  b4:	e422                	sd	s0,8(sp)
  b6:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
  b8:	00054783          	lbu	a5,0(a0)
  bc:	cb91                	beqz	a5,d0 <strcmp+0x1e>
  be:	0005c703          	lbu	a4,0(a1)
  c2:	00f71763          	bne	a4,a5,d0 <strcmp+0x1e>
    p++, q++;
  c6:	0505                	addi	a0,a0,1
  c8:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
  ca:	00054783          	lbu	a5,0(a0)
  ce:	fbe5                	bnez	a5,be <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
  d0:	0005c503          	lbu	a0,0(a1)
}
  d4:	40a7853b          	subw	a0,a5,a0
  d8:	6422                	ld	s0,8(sp)
  da:	0141                	addi	sp,sp,16
  dc:	8082                	ret

00000000000000de <strlen>:

uint
strlen(const char *s)
{
  de:	1141                	addi	sp,sp,-16
  e0:	e422                	sd	s0,8(sp)
  e2:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
  e4:	00054783          	lbu	a5,0(a0)
  e8:	cf91                	beqz	a5,104 <strlen+0x26>
  ea:	0505                	addi	a0,a0,1
  ec:	87aa                	mv	a5,a0
  ee:	4685                	li	a3,1
  f0:	9e89                	subw	a3,a3,a0
  f2:	00f6853b          	addw	a0,a3,a5
  f6:	0785                	addi	a5,a5,1
  f8:	fff7c703          	lbu	a4,-1(a5)
  fc:	fb7d                	bnez	a4,f2 <strlen+0x14>
    ;
  return n;
}
  fe:	6422                	ld	s0,8(sp)
 100:	0141                	addi	sp,sp,16
 102:	8082                	ret
  for(n = 0; s[n]; n++)
 104:	4501                	li	a0,0
 106:	bfe5                	j	fe <strlen+0x20>

0000000000000108 <memset>:

void*
memset(void *dst, int c, uint n)
{
 108:	1141                	addi	sp,sp,-16
 10a:	e422                	sd	s0,8(sp)
 10c:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 10e:	ca19                	beqz	a2,124 <memset+0x1c>
 110:	87aa                	mv	a5,a0
 112:	1602                	slli	a2,a2,0x20
 114:	9201                	srli	a2,a2,0x20
 116:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 11a:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 11e:	0785                	addi	a5,a5,1
 120:	fee79de3          	bne	a5,a4,11a <memset+0x12>
  }
  return dst;
}
 124:	6422                	ld	s0,8(sp)
 126:	0141                	addi	sp,sp,16
 128:	8082                	ret

000000000000012a <strchr>:

char*
strchr(const char *s, char c)
{
 12a:	1141                	addi	sp,sp,-16
 12c:	e422                	sd	s0,8(sp)
 12e:	0800                	addi	s0,sp,16
  for(; *s; s++)
 130:	00054783          	lbu	a5,0(a0)
 134:	cb99                	beqz	a5,14a <strchr+0x20>
    if(*s == c)
 136:	00f58763          	beq	a1,a5,144 <strchr+0x1a>
  for(; *s; s++)
 13a:	0505                	addi	a0,a0,1
 13c:	00054783          	lbu	a5,0(a0)
 140:	fbfd                	bnez	a5,136 <strchr+0xc>
      return (char*)s;
  return 0;
 142:	4501                	li	a0,0
}
 144:	6422                	ld	s0,8(sp)
 146:	0141                	addi	sp,sp,16
 148:	8082                	ret
  return 0;
 14a:	4501                	li	a0,0
 14c:	bfe5                	j	144 <strchr+0x1a>

000000000000014e <gets>:

char*
gets(char *buf, int max)
{
 14e:	711d                	addi	sp,sp,-96
 150:	ec86                	sd	ra,88(sp)
 152:	e8a2                	sd	s0,80(sp)
 154:	e4a6                	sd	s1,72(sp)
 156:	e0ca                	sd	s2,64(sp)
 158:	fc4e                	sd	s3,56(sp)
 15a:	f852                	sd	s4,48(sp)
 15c:	f456                	sd	s5,40(sp)
 15e:	f05a                	sd	s6,32(sp)
 160:	ec5e                	sd	s7,24(sp)
 162:	1080                	addi	s0,sp,96
 164:	8baa                	mv	s7,a0
 166:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 168:	892a                	mv	s2,a0
 16a:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 16c:	4aa9                	li	s5,10
 16e:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 170:	89a6                	mv	s3,s1
 172:	2485                	addiw	s1,s1,1
 174:	0344d863          	bge	s1,s4,1a4 <gets+0x56>
    cc = read(0, &c, 1);
 178:	4605                	li	a2,1
 17a:	faf40593          	addi	a1,s0,-81
 17e:	4501                	li	a0,0
 180:	00000097          	auipc	ra,0x0
 184:	19c080e7          	jalr	412(ra) # 31c <read>
    if(cc < 1)
 188:	00a05e63          	blez	a0,1a4 <gets+0x56>
    buf[i++] = c;
 18c:	faf44783          	lbu	a5,-81(s0)
 190:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 194:	01578763          	beq	a5,s5,1a2 <gets+0x54>
 198:	0905                	addi	s2,s2,1
 19a:	fd679be3          	bne	a5,s6,170 <gets+0x22>
  for(i=0; i+1 < max; ){
 19e:	89a6                	mv	s3,s1
 1a0:	a011                	j	1a4 <gets+0x56>
 1a2:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 1a4:	99de                	add	s3,s3,s7
 1a6:	00098023          	sb	zero,0(s3)
  return buf;
}
 1aa:	855e                	mv	a0,s7
 1ac:	60e6                	ld	ra,88(sp)
 1ae:	6446                	ld	s0,80(sp)
 1b0:	64a6                	ld	s1,72(sp)
 1b2:	6906                	ld	s2,64(sp)
 1b4:	79e2                	ld	s3,56(sp)
 1b6:	7a42                	ld	s4,48(sp)
 1b8:	7aa2                	ld	s5,40(sp)
 1ba:	7b02                	ld	s6,32(sp)
 1bc:	6be2                	ld	s7,24(sp)
 1be:	6125                	addi	sp,sp,96
 1c0:	8082                	ret

00000000000001c2 <stat>:

int
stat(const char *n, struct stat *st)
{
 1c2:	1101                	addi	sp,sp,-32
 1c4:	ec06                	sd	ra,24(sp)
 1c6:	e822                	sd	s0,16(sp)
 1c8:	e426                	sd	s1,8(sp)
 1ca:	e04a                	sd	s2,0(sp)
 1cc:	1000                	addi	s0,sp,32
 1ce:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1d0:	4581                	li	a1,0
 1d2:	00000097          	auipc	ra,0x0
 1d6:	172080e7          	jalr	370(ra) # 344 <open>
  if(fd < 0)
 1da:	02054563          	bltz	a0,204 <stat+0x42>
 1de:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 1e0:	85ca                	mv	a1,s2
 1e2:	00000097          	auipc	ra,0x0
 1e6:	17a080e7          	jalr	378(ra) # 35c <fstat>
 1ea:	892a                	mv	s2,a0
  close(fd);
 1ec:	8526                	mv	a0,s1
 1ee:	00000097          	auipc	ra,0x0
 1f2:	13e080e7          	jalr	318(ra) # 32c <close>
  return r;
}
 1f6:	854a                	mv	a0,s2
 1f8:	60e2                	ld	ra,24(sp)
 1fa:	6442                	ld	s0,16(sp)
 1fc:	64a2                	ld	s1,8(sp)
 1fe:	6902                	ld	s2,0(sp)
 200:	6105                	addi	sp,sp,32
 202:	8082                	ret
    return -1;
 204:	597d                	li	s2,-1
 206:	bfc5                	j	1f6 <stat+0x34>

0000000000000208 <atoi>:

int
atoi(const char *s)
{
 208:	1141                	addi	sp,sp,-16
 20a:	e422                	sd	s0,8(sp)
 20c:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 20e:	00054603          	lbu	a2,0(a0)
 212:	fd06079b          	addiw	a5,a2,-48
 216:	0ff7f793          	andi	a5,a5,255
 21a:	4725                	li	a4,9
 21c:	02f76963          	bltu	a4,a5,24e <atoi+0x46>
 220:	86aa                	mv	a3,a0
  n = 0;
 222:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
 224:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
 226:	0685                	addi	a3,a3,1
 228:	0025179b          	slliw	a5,a0,0x2
 22c:	9fa9                	addw	a5,a5,a0
 22e:	0017979b          	slliw	a5,a5,0x1
 232:	9fb1                	addw	a5,a5,a2
 234:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 238:	0006c603          	lbu	a2,0(a3)
 23c:	fd06071b          	addiw	a4,a2,-48
 240:	0ff77713          	andi	a4,a4,255
 244:	fee5f1e3          	bgeu	a1,a4,226 <atoi+0x1e>
  return n;
}
 248:	6422                	ld	s0,8(sp)
 24a:	0141                	addi	sp,sp,16
 24c:	8082                	ret
  n = 0;
 24e:	4501                	li	a0,0
 250:	bfe5                	j	248 <atoi+0x40>

0000000000000252 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 252:	1141                	addi	sp,sp,-16
 254:	e422                	sd	s0,8(sp)
 256:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 258:	02b57463          	bgeu	a0,a1,280 <memmove+0x2e>
    while(n-- > 0)
 25c:	00c05f63          	blez	a2,27a <memmove+0x28>
 260:	1602                	slli	a2,a2,0x20
 262:	9201                	srli	a2,a2,0x20
 264:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 268:	872a                	mv	a4,a0
      *dst++ = *src++;
 26a:	0585                	addi	a1,a1,1
 26c:	0705                	addi	a4,a4,1
 26e:	fff5c683          	lbu	a3,-1(a1)
 272:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 276:	fee79ae3          	bne	a5,a4,26a <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 27a:	6422                	ld	s0,8(sp)
 27c:	0141                	addi	sp,sp,16
 27e:	8082                	ret
    dst += n;
 280:	00c50733          	add	a4,a0,a2
    src += n;
 284:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 286:	fec05ae3          	blez	a2,27a <memmove+0x28>
 28a:	fff6079b          	addiw	a5,a2,-1
 28e:	1782                	slli	a5,a5,0x20
 290:	9381                	srli	a5,a5,0x20
 292:	fff7c793          	not	a5,a5
 296:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 298:	15fd                	addi	a1,a1,-1
 29a:	177d                	addi	a4,a4,-1
 29c:	0005c683          	lbu	a3,0(a1)
 2a0:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 2a4:	fee79ae3          	bne	a5,a4,298 <memmove+0x46>
 2a8:	bfc9                	j	27a <memmove+0x28>

00000000000002aa <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 2aa:	1141                	addi	sp,sp,-16
 2ac:	e422                	sd	s0,8(sp)
 2ae:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 2b0:	ca05                	beqz	a2,2e0 <memcmp+0x36>
 2b2:	fff6069b          	addiw	a3,a2,-1
 2b6:	1682                	slli	a3,a3,0x20
 2b8:	9281                	srli	a3,a3,0x20
 2ba:	0685                	addi	a3,a3,1
 2bc:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 2be:	00054783          	lbu	a5,0(a0)
 2c2:	0005c703          	lbu	a4,0(a1)
 2c6:	00e79863          	bne	a5,a4,2d6 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 2ca:	0505                	addi	a0,a0,1
    p2++;
 2cc:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 2ce:	fed518e3          	bne	a0,a3,2be <memcmp+0x14>
  }
  return 0;
 2d2:	4501                	li	a0,0
 2d4:	a019                	j	2da <memcmp+0x30>
      return *p1 - *p2;
 2d6:	40e7853b          	subw	a0,a5,a4
}
 2da:	6422                	ld	s0,8(sp)
 2dc:	0141                	addi	sp,sp,16
 2de:	8082                	ret
  return 0;
 2e0:	4501                	li	a0,0
 2e2:	bfe5                	j	2da <memcmp+0x30>

00000000000002e4 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 2e4:	1141                	addi	sp,sp,-16
 2e6:	e406                	sd	ra,8(sp)
 2e8:	e022                	sd	s0,0(sp)
 2ea:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 2ec:	00000097          	auipc	ra,0x0
 2f0:	f66080e7          	jalr	-154(ra) # 252 <memmove>
}
 2f4:	60a2                	ld	ra,8(sp)
 2f6:	6402                	ld	s0,0(sp)
 2f8:	0141                	addi	sp,sp,16
 2fa:	8082                	ret

00000000000002fc <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 2fc:	4885                	li	a7,1
 ecall
 2fe:	00000073          	ecall
 ret
 302:	8082                	ret

0000000000000304 <exit>:
.global exit
exit:
 li a7, SYS_exit
 304:	4889                	li	a7,2
 ecall
 306:	00000073          	ecall
 ret
 30a:	8082                	ret

000000000000030c <wait>:
.global wait
wait:
 li a7, SYS_wait
 30c:	488d                	li	a7,3
 ecall
 30e:	00000073          	ecall
 ret
 312:	8082                	ret

0000000000000314 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 314:	4891                	li	a7,4
 ecall
 316:	00000073          	ecall
 ret
 31a:	8082                	ret

000000000000031c <read>:
.global read
read:
 li a7, SYS_read
 31c:	4895                	li	a7,5
 ecall
 31e:	00000073          	ecall
 ret
 322:	8082                	ret

0000000000000324 <write>:
.global write
write:
 li a7, SYS_write
 324:	48c1                	li	a7,16
 ecall
 326:	00000073          	ecall
 ret
 32a:	8082                	ret

000000000000032c <close>:
.global close
close:
 li a7, SYS_close
 32c:	48d5                	li	a7,21
 ecall
 32e:	00000073          	ecall
 ret
 332:	8082                	ret

0000000000000334 <kill>:
.global kill
kill:
 li a7, SYS_kill
 334:	4899                	li	a7,6
 ecall
 336:	00000073          	ecall
 ret
 33a:	8082                	ret

000000000000033c <exec>:
.global exec
exec:
 li a7, SYS_exec
 33c:	489d                	li	a7,7
 ecall
 33e:	00000073          	ecall
 ret
 342:	8082                	ret

0000000000000344 <open>:
.global open
open:
 li a7, SYS_open
 344:	48bd                	li	a7,15
 ecall
 346:	00000073          	ecall
 ret
 34a:	8082                	ret

000000000000034c <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 34c:	48c5                	li	a7,17
 ecall
 34e:	00000073          	ecall
 ret
 352:	8082                	ret

0000000000000354 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 354:	48c9                	li	a7,18
 ecall
 356:	00000073          	ecall
 ret
 35a:	8082                	ret

000000000000035c <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 35c:	48a1                	li	a7,8
 ecall
 35e:	00000073          	ecall
 ret
 362:	8082                	ret

0000000000000364 <link>:
.global link
link:
 li a7, SYS_link
 364:	48cd                	li	a7,19
 ecall
 366:	00000073          	ecall
 ret
 36a:	8082                	ret

000000000000036c <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 36c:	48d1                	li	a7,20
 ecall
 36e:	00000073          	ecall
 ret
 372:	8082                	ret

0000000000000374 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 374:	48a5                	li	a7,9
 ecall
 376:	00000073          	ecall
 ret
 37a:	8082                	ret

000000000000037c <dup>:
.global dup
dup:
 li a7, SYS_dup
 37c:	48a9                	li	a7,10
 ecall
 37e:	00000073          	ecall
 ret
 382:	8082                	ret

0000000000000384 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 384:	48ad                	li	a7,11
 ecall
 386:	00000073          	ecall
 ret
 38a:	8082                	ret

000000000000038c <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 38c:	48b1                	li	a7,12
 ecall
 38e:	00000073          	ecall
 ret
 392:	8082                	ret

0000000000000394 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 394:	48b5                	li	a7,13
 ecall
 396:	00000073          	ecall
 ret
 39a:	8082                	ret

000000000000039c <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 39c:	48b9                	li	a7,14
 ecall
 39e:	00000073          	ecall
 ret
 3a2:	8082                	ret

00000000000003a4 <trace>:
.global trace
trace:
 li a7, SYS_trace
 3a4:	48d9                	li	a7,22
 ecall
 3a6:	00000073          	ecall
 ret
 3aa:	8082                	ret

00000000000003ac <sigalarm>:
.global sigalarm
sigalarm:
 li a7, SYS_sigalarm
 3ac:	48dd                	li	a7,23
 ecall
 3ae:	00000073          	ecall
 ret
 3b2:	8082                	ret

00000000000003b4 <sigreturn>:
.global sigreturn
sigreturn:
 li a7, SYS_sigreturn
 3b4:	48e1                	li	a7,24
 ecall
 3b6:	00000073          	ecall
 ret
 3ba:	8082                	ret

00000000000003bc <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 3bc:	1101                	addi	sp,sp,-32
 3be:	ec06                	sd	ra,24(sp)
 3c0:	e822                	sd	s0,16(sp)
 3c2:	1000                	addi	s0,sp,32
 3c4:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 3c8:	4605                	li	a2,1
 3ca:	fef40593          	addi	a1,s0,-17
 3ce:	00000097          	auipc	ra,0x0
 3d2:	f56080e7          	jalr	-170(ra) # 324 <write>
}
 3d6:	60e2                	ld	ra,24(sp)
 3d8:	6442                	ld	s0,16(sp)
 3da:	6105                	addi	sp,sp,32
 3dc:	8082                	ret

00000000000003de <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 3de:	7139                	addi	sp,sp,-64
 3e0:	fc06                	sd	ra,56(sp)
 3e2:	f822                	sd	s0,48(sp)
 3e4:	f426                	sd	s1,40(sp)
 3e6:	f04a                	sd	s2,32(sp)
 3e8:	ec4e                	sd	s3,24(sp)
 3ea:	0080                	addi	s0,sp,64
 3ec:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 3ee:	c299                	beqz	a3,3f4 <printint+0x16>
 3f0:	0805c863          	bltz	a1,480 <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 3f4:	2581                	sext.w	a1,a1
  neg = 0;
 3f6:	4881                	li	a7,0
 3f8:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 3fc:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 3fe:	2601                	sext.w	a2,a2
 400:	00000517          	auipc	a0,0x0
 404:	49050513          	addi	a0,a0,1168 # 890 <digits>
 408:	883a                	mv	a6,a4
 40a:	2705                	addiw	a4,a4,1
 40c:	02c5f7bb          	remuw	a5,a1,a2
 410:	1782                	slli	a5,a5,0x20
 412:	9381                	srli	a5,a5,0x20
 414:	97aa                	add	a5,a5,a0
 416:	0007c783          	lbu	a5,0(a5)
 41a:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 41e:	0005879b          	sext.w	a5,a1
 422:	02c5d5bb          	divuw	a1,a1,a2
 426:	0685                	addi	a3,a3,1
 428:	fec7f0e3          	bgeu	a5,a2,408 <printint+0x2a>
  if(neg)
 42c:	00088b63          	beqz	a7,442 <printint+0x64>
    buf[i++] = '-';
 430:	fd040793          	addi	a5,s0,-48
 434:	973e                	add	a4,a4,a5
 436:	02d00793          	li	a5,45
 43a:	fef70823          	sb	a5,-16(a4)
 43e:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 442:	02e05863          	blez	a4,472 <printint+0x94>
 446:	fc040793          	addi	a5,s0,-64
 44a:	00e78933          	add	s2,a5,a4
 44e:	fff78993          	addi	s3,a5,-1
 452:	99ba                	add	s3,s3,a4
 454:	377d                	addiw	a4,a4,-1
 456:	1702                	slli	a4,a4,0x20
 458:	9301                	srli	a4,a4,0x20
 45a:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 45e:	fff94583          	lbu	a1,-1(s2)
 462:	8526                	mv	a0,s1
 464:	00000097          	auipc	ra,0x0
 468:	f58080e7          	jalr	-168(ra) # 3bc <putc>
  while(--i >= 0)
 46c:	197d                	addi	s2,s2,-1
 46e:	ff3918e3          	bne	s2,s3,45e <printint+0x80>
}
 472:	70e2                	ld	ra,56(sp)
 474:	7442                	ld	s0,48(sp)
 476:	74a2                	ld	s1,40(sp)
 478:	7902                	ld	s2,32(sp)
 47a:	69e2                	ld	s3,24(sp)
 47c:	6121                	addi	sp,sp,64
 47e:	8082                	ret
    x = -xx;
 480:	40b005bb          	negw	a1,a1
    neg = 1;
 484:	4885                	li	a7,1
    x = -xx;
 486:	bf8d                	j	3f8 <printint+0x1a>

0000000000000488 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 488:	7119                	addi	sp,sp,-128
 48a:	fc86                	sd	ra,120(sp)
 48c:	f8a2                	sd	s0,112(sp)
 48e:	f4a6                	sd	s1,104(sp)
 490:	f0ca                	sd	s2,96(sp)
 492:	ecce                	sd	s3,88(sp)
 494:	e8d2                	sd	s4,80(sp)
 496:	e4d6                	sd	s5,72(sp)
 498:	e0da                	sd	s6,64(sp)
 49a:	fc5e                	sd	s7,56(sp)
 49c:	f862                	sd	s8,48(sp)
 49e:	f466                	sd	s9,40(sp)
 4a0:	f06a                	sd	s10,32(sp)
 4a2:	ec6e                	sd	s11,24(sp)
 4a4:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 4a6:	0005c903          	lbu	s2,0(a1)
 4aa:	18090f63          	beqz	s2,648 <vprintf+0x1c0>
 4ae:	8aaa                	mv	s5,a0
 4b0:	8b32                	mv	s6,a2
 4b2:	00158493          	addi	s1,a1,1
  state = 0;
 4b6:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 4b8:	02500a13          	li	s4,37
      if(c == 'd'){
 4bc:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
 4c0:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
 4c4:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
 4c8:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 4cc:	00000b97          	auipc	s7,0x0
 4d0:	3c4b8b93          	addi	s7,s7,964 # 890 <digits>
 4d4:	a839                	j	4f2 <vprintf+0x6a>
        putc(fd, c);
 4d6:	85ca                	mv	a1,s2
 4d8:	8556                	mv	a0,s5
 4da:	00000097          	auipc	ra,0x0
 4de:	ee2080e7          	jalr	-286(ra) # 3bc <putc>
 4e2:	a019                	j	4e8 <vprintf+0x60>
    } else if(state == '%'){
 4e4:	01498f63          	beq	s3,s4,502 <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
 4e8:	0485                	addi	s1,s1,1
 4ea:	fff4c903          	lbu	s2,-1(s1)
 4ee:	14090d63          	beqz	s2,648 <vprintf+0x1c0>
    c = fmt[i] & 0xff;
 4f2:	0009079b          	sext.w	a5,s2
    if(state == 0){
 4f6:	fe0997e3          	bnez	s3,4e4 <vprintf+0x5c>
      if(c == '%'){
 4fa:	fd479ee3          	bne	a5,s4,4d6 <vprintf+0x4e>
        state = '%';
 4fe:	89be                	mv	s3,a5
 500:	b7e5                	j	4e8 <vprintf+0x60>
      if(c == 'd'){
 502:	05878063          	beq	a5,s8,542 <vprintf+0xba>
      } else if(c == 'l') {
 506:	05978c63          	beq	a5,s9,55e <vprintf+0xd6>
      } else if(c == 'x') {
 50a:	07a78863          	beq	a5,s10,57a <vprintf+0xf2>
      } else if(c == 'p') {
 50e:	09b78463          	beq	a5,s11,596 <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
 512:	07300713          	li	a4,115
 516:	0ce78663          	beq	a5,a4,5e2 <vprintf+0x15a>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 51a:	06300713          	li	a4,99
 51e:	0ee78e63          	beq	a5,a4,61a <vprintf+0x192>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
 522:	11478863          	beq	a5,s4,632 <vprintf+0x1aa>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 526:	85d2                	mv	a1,s4
 528:	8556                	mv	a0,s5
 52a:	00000097          	auipc	ra,0x0
 52e:	e92080e7          	jalr	-366(ra) # 3bc <putc>
        putc(fd, c);
 532:	85ca                	mv	a1,s2
 534:	8556                	mv	a0,s5
 536:	00000097          	auipc	ra,0x0
 53a:	e86080e7          	jalr	-378(ra) # 3bc <putc>
      }
      state = 0;
 53e:	4981                	li	s3,0
 540:	b765                	j	4e8 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
 542:	008b0913          	addi	s2,s6,8
 546:	4685                	li	a3,1
 548:	4629                	li	a2,10
 54a:	000b2583          	lw	a1,0(s6)
 54e:	8556                	mv	a0,s5
 550:	00000097          	auipc	ra,0x0
 554:	e8e080e7          	jalr	-370(ra) # 3de <printint>
 558:	8b4a                	mv	s6,s2
      state = 0;
 55a:	4981                	li	s3,0
 55c:	b771                	j	4e8 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 55e:	008b0913          	addi	s2,s6,8
 562:	4681                	li	a3,0
 564:	4629                	li	a2,10
 566:	000b2583          	lw	a1,0(s6)
 56a:	8556                	mv	a0,s5
 56c:	00000097          	auipc	ra,0x0
 570:	e72080e7          	jalr	-398(ra) # 3de <printint>
 574:	8b4a                	mv	s6,s2
      state = 0;
 576:	4981                	li	s3,0
 578:	bf85                	j	4e8 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 57a:	008b0913          	addi	s2,s6,8
 57e:	4681                	li	a3,0
 580:	4641                	li	a2,16
 582:	000b2583          	lw	a1,0(s6)
 586:	8556                	mv	a0,s5
 588:	00000097          	auipc	ra,0x0
 58c:	e56080e7          	jalr	-426(ra) # 3de <printint>
 590:	8b4a                	mv	s6,s2
      state = 0;
 592:	4981                	li	s3,0
 594:	bf91                	j	4e8 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 596:	008b0793          	addi	a5,s6,8
 59a:	f8f43423          	sd	a5,-120(s0)
 59e:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 5a2:	03000593          	li	a1,48
 5a6:	8556                	mv	a0,s5
 5a8:	00000097          	auipc	ra,0x0
 5ac:	e14080e7          	jalr	-492(ra) # 3bc <putc>
  putc(fd, 'x');
 5b0:	85ea                	mv	a1,s10
 5b2:	8556                	mv	a0,s5
 5b4:	00000097          	auipc	ra,0x0
 5b8:	e08080e7          	jalr	-504(ra) # 3bc <putc>
 5bc:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 5be:	03c9d793          	srli	a5,s3,0x3c
 5c2:	97de                	add	a5,a5,s7
 5c4:	0007c583          	lbu	a1,0(a5)
 5c8:	8556                	mv	a0,s5
 5ca:	00000097          	auipc	ra,0x0
 5ce:	df2080e7          	jalr	-526(ra) # 3bc <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 5d2:	0992                	slli	s3,s3,0x4
 5d4:	397d                	addiw	s2,s2,-1
 5d6:	fe0914e3          	bnez	s2,5be <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
 5da:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 5de:	4981                	li	s3,0
 5e0:	b721                	j	4e8 <vprintf+0x60>
        s = va_arg(ap, char*);
 5e2:	008b0993          	addi	s3,s6,8
 5e6:	000b3903          	ld	s2,0(s6)
        if(s == 0)
 5ea:	02090163          	beqz	s2,60c <vprintf+0x184>
        while(*s != 0){
 5ee:	00094583          	lbu	a1,0(s2)
 5f2:	c9a1                	beqz	a1,642 <vprintf+0x1ba>
          putc(fd, *s);
 5f4:	8556                	mv	a0,s5
 5f6:	00000097          	auipc	ra,0x0
 5fa:	dc6080e7          	jalr	-570(ra) # 3bc <putc>
          s++;
 5fe:	0905                	addi	s2,s2,1
        while(*s != 0){
 600:	00094583          	lbu	a1,0(s2)
 604:	f9e5                	bnez	a1,5f4 <vprintf+0x16c>
        s = va_arg(ap, char*);
 606:	8b4e                	mv	s6,s3
      state = 0;
 608:	4981                	li	s3,0
 60a:	bdf9                	j	4e8 <vprintf+0x60>
          s = "(null)";
 60c:	00000917          	auipc	s2,0x0
 610:	27c90913          	addi	s2,s2,636 # 888 <malloc+0x136>
        while(*s != 0){
 614:	02800593          	li	a1,40
 618:	bff1                	j	5f4 <vprintf+0x16c>
        putc(fd, va_arg(ap, uint));
 61a:	008b0913          	addi	s2,s6,8
 61e:	000b4583          	lbu	a1,0(s6)
 622:	8556                	mv	a0,s5
 624:	00000097          	auipc	ra,0x0
 628:	d98080e7          	jalr	-616(ra) # 3bc <putc>
 62c:	8b4a                	mv	s6,s2
      state = 0;
 62e:	4981                	li	s3,0
 630:	bd65                	j	4e8 <vprintf+0x60>
        putc(fd, c);
 632:	85d2                	mv	a1,s4
 634:	8556                	mv	a0,s5
 636:	00000097          	auipc	ra,0x0
 63a:	d86080e7          	jalr	-634(ra) # 3bc <putc>
      state = 0;
 63e:	4981                	li	s3,0
 640:	b565                	j	4e8 <vprintf+0x60>
        s = va_arg(ap, char*);
 642:	8b4e                	mv	s6,s3
      state = 0;
 644:	4981                	li	s3,0
 646:	b54d                	j	4e8 <vprintf+0x60>
    }
  }
}
 648:	70e6                	ld	ra,120(sp)
 64a:	7446                	ld	s0,112(sp)
 64c:	74a6                	ld	s1,104(sp)
 64e:	7906                	ld	s2,96(sp)
 650:	69e6                	ld	s3,88(sp)
 652:	6a46                	ld	s4,80(sp)
 654:	6aa6                	ld	s5,72(sp)
 656:	6b06                	ld	s6,64(sp)
 658:	7be2                	ld	s7,56(sp)
 65a:	7c42                	ld	s8,48(sp)
 65c:	7ca2                	ld	s9,40(sp)
 65e:	7d02                	ld	s10,32(sp)
 660:	6de2                	ld	s11,24(sp)
 662:	6109                	addi	sp,sp,128
 664:	8082                	ret

0000000000000666 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 666:	715d                	addi	sp,sp,-80
 668:	ec06                	sd	ra,24(sp)
 66a:	e822                	sd	s0,16(sp)
 66c:	1000                	addi	s0,sp,32
 66e:	e010                	sd	a2,0(s0)
 670:	e414                	sd	a3,8(s0)
 672:	e818                	sd	a4,16(s0)
 674:	ec1c                	sd	a5,24(s0)
 676:	03043023          	sd	a6,32(s0)
 67a:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 67e:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 682:	8622                	mv	a2,s0
 684:	00000097          	auipc	ra,0x0
 688:	e04080e7          	jalr	-508(ra) # 488 <vprintf>
}
 68c:	60e2                	ld	ra,24(sp)
 68e:	6442                	ld	s0,16(sp)
 690:	6161                	addi	sp,sp,80
 692:	8082                	ret

0000000000000694 <printf>:

void
printf(const char *fmt, ...)
{
 694:	711d                	addi	sp,sp,-96
 696:	ec06                	sd	ra,24(sp)
 698:	e822                	sd	s0,16(sp)
 69a:	1000                	addi	s0,sp,32
 69c:	e40c                	sd	a1,8(s0)
 69e:	e810                	sd	a2,16(s0)
 6a0:	ec14                	sd	a3,24(s0)
 6a2:	f018                	sd	a4,32(s0)
 6a4:	f41c                	sd	a5,40(s0)
 6a6:	03043823          	sd	a6,48(s0)
 6aa:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 6ae:	00840613          	addi	a2,s0,8
 6b2:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 6b6:	85aa                	mv	a1,a0
 6b8:	4505                	li	a0,1
 6ba:	00000097          	auipc	ra,0x0
 6be:	dce080e7          	jalr	-562(ra) # 488 <vprintf>
}
 6c2:	60e2                	ld	ra,24(sp)
 6c4:	6442                	ld	s0,16(sp)
 6c6:	6125                	addi	sp,sp,96
 6c8:	8082                	ret

00000000000006ca <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 6ca:	1141                	addi	sp,sp,-16
 6cc:	e422                	sd	s0,8(sp)
 6ce:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 6d0:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6d4:	00001797          	auipc	a5,0x1
 6d8:	92c7b783          	ld	a5,-1748(a5) # 1000 <freep>
 6dc:	a805                	j	70c <free+0x42>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 6de:	4618                	lw	a4,8(a2)
 6e0:	9db9                	addw	a1,a1,a4
 6e2:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 6e6:	6398                	ld	a4,0(a5)
 6e8:	6318                	ld	a4,0(a4)
 6ea:	fee53823          	sd	a4,-16(a0)
 6ee:	a091                	j	732 <free+0x68>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 6f0:	ff852703          	lw	a4,-8(a0)
 6f4:	9e39                	addw	a2,a2,a4
 6f6:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
 6f8:	ff053703          	ld	a4,-16(a0)
 6fc:	e398                	sd	a4,0(a5)
 6fe:	a099                	j	744 <free+0x7a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 700:	6398                	ld	a4,0(a5)
 702:	00e7e463          	bltu	a5,a4,70a <free+0x40>
 706:	00e6ea63          	bltu	a3,a4,71a <free+0x50>
{
 70a:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 70c:	fed7fae3          	bgeu	a5,a3,700 <free+0x36>
 710:	6398                	ld	a4,0(a5)
 712:	00e6e463          	bltu	a3,a4,71a <free+0x50>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 716:	fee7eae3          	bltu	a5,a4,70a <free+0x40>
  if(bp + bp->s.size == p->s.ptr){
 71a:	ff852583          	lw	a1,-8(a0)
 71e:	6390                	ld	a2,0(a5)
 720:	02059713          	slli	a4,a1,0x20
 724:	9301                	srli	a4,a4,0x20
 726:	0712                	slli	a4,a4,0x4
 728:	9736                	add	a4,a4,a3
 72a:	fae60ae3          	beq	a2,a4,6de <free+0x14>
    bp->s.ptr = p->s.ptr;
 72e:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 732:	4790                	lw	a2,8(a5)
 734:	02061713          	slli	a4,a2,0x20
 738:	9301                	srli	a4,a4,0x20
 73a:	0712                	slli	a4,a4,0x4
 73c:	973e                	add	a4,a4,a5
 73e:	fae689e3          	beq	a3,a4,6f0 <free+0x26>
  } else
    p->s.ptr = bp;
 742:	e394                	sd	a3,0(a5)
  freep = p;
 744:	00001717          	auipc	a4,0x1
 748:	8af73e23          	sd	a5,-1860(a4) # 1000 <freep>
}
 74c:	6422                	ld	s0,8(sp)
 74e:	0141                	addi	sp,sp,16
 750:	8082                	ret

0000000000000752 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 752:	7139                	addi	sp,sp,-64
 754:	fc06                	sd	ra,56(sp)
 756:	f822                	sd	s0,48(sp)
 758:	f426                	sd	s1,40(sp)
 75a:	f04a                	sd	s2,32(sp)
 75c:	ec4e                	sd	s3,24(sp)
 75e:	e852                	sd	s4,16(sp)
 760:	e456                	sd	s5,8(sp)
 762:	e05a                	sd	s6,0(sp)
 764:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 766:	02051493          	slli	s1,a0,0x20
 76a:	9081                	srli	s1,s1,0x20
 76c:	04bd                	addi	s1,s1,15
 76e:	8091                	srli	s1,s1,0x4
 770:	0014899b          	addiw	s3,s1,1
 774:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 776:	00001517          	auipc	a0,0x1
 77a:	88a53503          	ld	a0,-1910(a0) # 1000 <freep>
 77e:	c515                	beqz	a0,7aa <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 780:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 782:	4798                	lw	a4,8(a5)
 784:	02977f63          	bgeu	a4,s1,7c2 <malloc+0x70>
 788:	8a4e                	mv	s4,s3
 78a:	0009871b          	sext.w	a4,s3
 78e:	6685                	lui	a3,0x1
 790:	00d77363          	bgeu	a4,a3,796 <malloc+0x44>
 794:	6a05                	lui	s4,0x1
 796:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 79a:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 79e:	00001917          	auipc	s2,0x1
 7a2:	86290913          	addi	s2,s2,-1950 # 1000 <freep>
  if(p == (char*)-1)
 7a6:	5afd                	li	s5,-1
 7a8:	a88d                	j	81a <malloc+0xc8>
    base.s.ptr = freep = prevp = &base;
 7aa:	00001797          	auipc	a5,0x1
 7ae:	86678793          	addi	a5,a5,-1946 # 1010 <base>
 7b2:	00001717          	auipc	a4,0x1
 7b6:	84f73723          	sd	a5,-1970(a4) # 1000 <freep>
 7ba:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 7bc:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 7c0:	b7e1                	j	788 <malloc+0x36>
      if(p->s.size == nunits)
 7c2:	02e48b63          	beq	s1,a4,7f8 <malloc+0xa6>
        p->s.size -= nunits;
 7c6:	4137073b          	subw	a4,a4,s3
 7ca:	c798                	sw	a4,8(a5)
        p += p->s.size;
 7cc:	1702                	slli	a4,a4,0x20
 7ce:	9301                	srli	a4,a4,0x20
 7d0:	0712                	slli	a4,a4,0x4
 7d2:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 7d4:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 7d8:	00001717          	auipc	a4,0x1
 7dc:	82a73423          	sd	a0,-2008(a4) # 1000 <freep>
      return (void*)(p + 1);
 7e0:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 7e4:	70e2                	ld	ra,56(sp)
 7e6:	7442                	ld	s0,48(sp)
 7e8:	74a2                	ld	s1,40(sp)
 7ea:	7902                	ld	s2,32(sp)
 7ec:	69e2                	ld	s3,24(sp)
 7ee:	6a42                	ld	s4,16(sp)
 7f0:	6aa2                	ld	s5,8(sp)
 7f2:	6b02                	ld	s6,0(sp)
 7f4:	6121                	addi	sp,sp,64
 7f6:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 7f8:	6398                	ld	a4,0(a5)
 7fa:	e118                	sd	a4,0(a0)
 7fc:	bff1                	j	7d8 <malloc+0x86>
  hp->s.size = nu;
 7fe:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 802:	0541                	addi	a0,a0,16
 804:	00000097          	auipc	ra,0x0
 808:	ec6080e7          	jalr	-314(ra) # 6ca <free>
  return freep;
 80c:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 810:	d971                	beqz	a0,7e4 <malloc+0x92>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 812:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 814:	4798                	lw	a4,8(a5)
 816:	fa9776e3          	bgeu	a4,s1,7c2 <malloc+0x70>
    if(p == freep)
 81a:	00093703          	ld	a4,0(s2)
 81e:	853e                	mv	a0,a5
 820:	fef719e3          	bne	a4,a5,812 <malloc+0xc0>
  p = sbrk(nu * sizeof(Header));
 824:	8552                	mv	a0,s4
 826:	00000097          	auipc	ra,0x0
 82a:	b66080e7          	jalr	-1178(ra) # 38c <sbrk>
  if(p == (char*)-1)
 82e:	fd5518e3          	bne	a0,s5,7fe <malloc+0xac>
        return 0;
 832:	4501                	li	a0,0
 834:	bf45                	j	7e4 <malloc+0x92>
