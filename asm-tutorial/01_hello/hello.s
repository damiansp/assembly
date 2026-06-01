// ARM64 Assembly - Hello World for MacOS

.global _start  // expose _start as entry point
.align  2       // align to 2^2 =  4-byte boundary (required)

  
.section __DATA,__data
msg:
  .asciz "Hello, World!\n"
msg_len = . - msg  // assembler calculates length

  
.section __TEXT,__text
_start:
  // syscall: write(1, msg, msg_len)
  mov  x0, #1               // fd: 1 = stdout
  adrp x1, msg@PAGE         // x1 = page containing msg
  add  x1, x1, msg@PAGEOFF  // x1 += offset within that page
  mov  x2, #msg_len         // count = length
  mov  x16, #4              // syscall #4 = write
  svc  #0x80                // invoke kernel

  // syscall: exit(0)
  mov  x0, #0        // exit code
  mov  x16, #1       // syscall #1 = exit
  svc  #0x80         // invoke kernel









  
