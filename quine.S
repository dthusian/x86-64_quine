# x86_64 machine code quine, no reading instruction memory
.intel_syntax noprefix

.section .text
.global _start
_start:
  # List following bytecode in reverse order
  push 0x050f
  push 0xffffffffff31583c
  push 0x6a050f5a
  push 0x586ac789
  push 0x58016af2
  push 0xffffffffe2014689
  push 0x6806c605
  push 0xffffffffee8348ab
  push 0x585f545e
  push 0x54590a6a

code_start:  
  # rsp: read ptr, rsi: write ptr (push instrs), rdi: write ptr, rdx: number of pushes
  # using rsp for read ptr has the advantage that we can use pop
  # everything should fit in the red zone, so signals shouldn't mess this up
  push 10
  pop rcx
  push rsp
  pop rsi
  push rsp
  pop rdi
br0:
  pop rax
  stosd
  sub rsi,5
  mov byte ptr[rsi],0x68
  mov [rsi+1],eax
  loop br0

  // write output and exit
  push 1
  pop rax
  mov edi,eax
  push 88
  pop rdx
  syscall

  push 60
  pop rax
  xor edi,edi
  syscall