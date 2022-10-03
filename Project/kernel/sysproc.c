#include "types.h"
#include "riscv.h"
#include "defs.h"
#include "param.h"
#include "memlayout.h"
#include "spinlock.h"
#include "proc.h"

uint64
sys_exit(void)
{
  int n;
  argint(0, &n);
  exit(n);
  return 0;  // not reached
}

uint64
sys_getpid(void)
{
  return myproc()->pid;
}

uint64
sys_fork(void)
{
  return fork();
}

uint64
sys_wait(void)
{
  uint64 p;
  argaddr(0, &p);
  return wait(p);
}

uint64
sys_sbrk(void)
{
  uint64 addr;
  int n;

  argint(0, &n);
  addr = myproc()->sz;
  if(growproc(n) < 0)
    return -1;
  return addr;
}

uint64
sys_sleep(void)
{
  int n;
  uint ticks0;

  argint(0, &n);
  acquire(&tickslock);
  ticks0 = ticks;
  while(ticks - ticks0 < n){
    if(killed(myproc())){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
  return 0;
}

uint64
sys_kill(void)
{
  int pid;

  argint(0, &pid);
  return kill(pid);
}

// return how many clock tick interrupts have occurred
// since start.
uint64
sys_uptime(void)
{
  uint xticks;

  acquire(&tickslock);
  xticks = ticks;
  release(&tickslock);
  return xticks;
}

uint64
sys_trace(void)
{
  struct proc *p = myproc();
  acquire(&p->lock);
  argint(0, &(p->syscall_tracebits));
  release(&p->lock);
  if (p->syscall_tracebits < 0)
    return -1;
  return 0;
}

uint64
sys_sigalarm()
{
  struct proc *p = myproc();
  acquire(&p->lock);
  argint(0,&(p->alarmdata.nticks));
  if(p->alarmdata.nticks < 0){
    release(&p->lock);
    return -1;
  }
  argaddr(1,&(p->alarmdata.handlerfn));
  release(&p->lock);
  // if(p->alarmdata.handlerfn )
  return 0;
}

uint64
sys_sigreturn()
{
  struct proc *p = myproc();
  memmove(p->trapframe,p->alarmdata.trapframe_cpy,PGSIZE);

  kfree(p->alarmdata.trapframe_cpy);
  p->alarmdata.trapframe_cpy=0;
  return 0;
}