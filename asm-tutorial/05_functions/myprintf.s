  // call printf from ARM64 assembly
  .global _start
  .align  2


  .section __DATA,__data
  
fmt_hello:
  .asciz "Hello from printf!\n"


  .section __TEXT,__text

_start: 
  stp  x29, x30, [sp, #-16]!
  mov  x29, sp

  adrp x0, fmt_hello@PAGE
  add  x0, x0, fmt_hello@PAGEOFF  // x0 = format string (first arg)
  bl   _printf                    // call printf(fmt_hello)

  mov  x0, #0                     // return(0)
  mov  x16, #1                    // syscall exit
  svc  #0x80

  ldp  x29, x30, [sp], #16        // unreachable but good hygiene
  ret

  
