# x86-64 Quine

A quine for x86-64 machine code on Linux that doesn't read from program memory.
Program memory is defined as anything in the .text or .data segments. Since this only
read/writes from stack and uses raw syscalls,
I suppose you could use it as shellcode, not that it would
do anything useful in such a setting.

```
quine:     file format elf64-x86-64


Disassembly of section .text:

000000000040017c <_start>:
  40017c:       68 0f 05 00 00          push   0x50f
  400181:       68 3c 58 31 ff          push   0xffffffffff31583c
  400186:       68 5a 0f 05 6a          push   0x6a050f5a
  40018b:       68 89 c7 6a 58          push   0x586ac789
  400190:       68 f2 6a 01 58          push   0x58016af2
  400195:       68 89 46 01 e2          push   0xffffffffe2014689
  40019a:       68 05 c6 06 68          push   0x6806c605
  40019f:       68 ab 48 83 ee          push   0xffffffffee8348ab
  4001a4:       68 5e 54 5f 58          push   0x585f545e
  4001a9:       68 6a 0a 59 54          push   0x54590a6a

00000000004001ae <code_start>:
  4001ae:       6a 0a                   push   0xa
  4001b0:       59                      pop    rcx
  4001b1:       54                      push   rsp
  4001b2:       5e                      pop    rsi
  4001b3:       54                      push   rsp
  4001b4:       5f                      pop    rdi

00000000004001b5 <br0>:
  4001b5:       58                      pop    rax
  4001b6:       ab                      stos   DWORD PTR [rdi],eax
  4001b7:       48 83 ee 05             sub    rsi,0x5
  4001bb:       c6 06 68                mov    BYTE PTR [rsi],0x68
  4001be:       89 46 01                mov    DWORD PTR [rsi+0x1],eax
  4001c1:       e2 f2                   loop   4001b5 <br0>
  4001c3:       6a 01                   push   0x1
  4001c5:       58                      pop    rax
  4001c6:       89 c7                   mov    edi,eax
  4001c8:       6a 58                   push   0x58
  4001ca:       5a                      pop    rdx
  4001cb:       0f 05                   syscall
  4001cd:       6a 3c                   push   0x3c
  4001cf:       58                      pop    rax
  4001d0:       31 ff                   xor    edi,edi
  4001d2:       0f 05                   syscall
```

```
Code hexdump:
00000000: 680f 0500 0068 3c58 31ff 685a 0f05 6a68  h....h<X1.hZ..jh
00000010: 89c7 6a58 68f2 6a01 5868 8946 01e2 6805  ..jXh.j.Xh.F..h.
00000020: c606 6868 ab48 83ee 685e 545f 5868 6a0a  ..hh.H..h^T_Xhj.
00000030: 5954 6a0a 5954 5e54 5f58 ab48 83ee 05c6  YTj.YT^T_X.H....
00000040: 0668 8946 01e2 f26a 0158 89c7 6a58 5a0f  .h.F...j.X..jXZ.
00000050: 056a 3c58 31ff 0f05                      .j<X1...

Output hexdump:
00000000: 680f 0500 0068 3c58 31ff 685a 0f05 6a68  h....h<X1.hZ..jh
00000010: 89c7 6a58 68f2 6a01 5868 8946 01e2 6805  ..jXh.j.Xh.F..h.
00000020: c606 6868 ab48 83ee 685e 545f 5868 6a0a  ..hh.H..h^T_Xhj.
00000030: 5954 6a0a 5954 5e54 5f58 ab48 83ee 05c6  YTj.YT^T_X.H....
00000040: 0668 8946 01e2 f26a 0158 89c7 6a58 5a0f  .h.F...j.X..jXZ.
00000050: 056a 3c58 31ff 0f05                      .j<X1...
```