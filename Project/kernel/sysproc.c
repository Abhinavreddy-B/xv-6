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
  acquire(&p->lock);                //aquire the lock.
  argint(0,&(p->alarmdata.nticks)); // p->alarmdata.nticks = n 
  if(p->alarmdata.nticks < 0){      // error handling
    release(&p->lock);
    return -1;
  }
  argaddr(1,&(p->alarmdata.handlerfn));   // p->alarmdata.handlerfn = fn
  if(p->alarmdata.handlerfn < 0){   // error handling
    release(&p->lock);
    return -1;
  }
  release(&p->lock);
  return 0;
}

uint64
sys_sigreturn()
{
  struct proc *p = myproc();
  acquire(&p->lock);    // aquire lock
  memmove(p->trapframe,p->alarmdata.trapframe_cpy,PGSIZE); // restore original state

  kfree(p->alarmdata.trapframe_cpy);    // remove the copy
  p->alarmdata.trapframe_cpy=0;
  p->alarmdata.currticks=0;
  release(&p->lock);                    // release the lock

  // this return value was being stored in trapframe->a0 , so returned trapframe->a0 itself
  return p->trapframe->a0;  
}

uint64
sys_waitx(void)
{
  uint64 addr, addr1, addr2;
  uint wtime, rtime;
  argaddr(0, &addr);
  argaddr(1, &addr1); // user virtual memory
  argaddr(2, &addr2);
  int ret = waitx(addr, &wtime, &rtime);
  struct proc* p = myproc();
  if (copyout(p->pagetable, addr1,(char*)&wtime, sizeof(int)) < 0)
    return -1;
  if (copyout(p->pagetable, addr2,(char*)&rtime, sizeof(int)) < 0)
    return -1;
  return ret;
}

uint64
sys_settickets(void)
{
  struct proc *p = myproc();
  acquire(&p->lock);
  int tickets;
  argint(0, &tickets);
  if(tickets < 0){
    release(&p->lock);
    return -1;
  }
  p->tickets = tickets;
  release(&p->lock);

  return p->tickets;
}