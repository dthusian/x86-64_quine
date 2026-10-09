# x86_64 machine code quine, no reading instruction memory
.intel_syntax noprefix

.section .text
.global _start
_start:
  # List following bytecode in reverse order
  push 0x050fff31
  push 0x583c6a05
  push 0x0fd2148d
  push 0x67c78958
  push 0x016aede2
  push 0x01468968
  push 0x06c605ee
  push 0xffffffff834804c7
  push 0xffffffff83480789
  push 0x58d189e7
  push 0xffffffff8948e689
  push 0x485a0c6a

code_start:  
  # number of pushes
  push 12
  pop rdx
  # rsp: read ptr, rsi: write ptr (push instrs), rdi: write ptr
  # using rsp for read ptr has the advantage that we can use pop
  # everything should fit in the red zone, so signals shouldn't mess this up
  mov rsi,rsp
  mov rdi,rsp
  mov ecx,edx
br0:
  pop rax
  mov [rdi],eax
  add rdi,4
  sub rsi,5
  mov byte ptr[rsi],0x68
  mov [rsi+1],eax
  loop br0

  // write output and exit
  push 1
  pop rax
  mov edi,eax
  lea edx,[edx+edx*8]
  syscall

  push 60
  pop rax
  xor edi,edi
  syscall