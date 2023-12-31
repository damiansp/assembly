// Macros for debugging
// Macros preserve all registers.
// Caution: they will change condition flags.
  

.macro print_reg reg
  stp  x0, x1, [SP, #-16]!
  stp  x2, x3, [SP, #-16]!
  stp  x4, x5, [SP, #-16]!
  stp  x6, x7, [SP, #-16]!
  stp  x8, x9, [SP, #-16]!
  stp  x10, x11, [SP, #-16]!
  stp  x12, x13, [SP, #-16]!
  stp  x14, x15, [SP, #-16]!
  stp  x16, x17, [SP, #-16]!
  stp  x18, lr, [SP, #-16]!
  mov  x2, X\reg     // for the %d
  mov  x3, X\reg     // for the %x
  mov  x1, #\reg
  add  x1, x1, #'0'  // for the %c
  ldr  x0, =ptf_str  // printf format str
  bl   printf        // call C's printf
  ldp  x18, lr, [SP], #16
  ldp  x16, x17, [SP], #16
  ldp  x14, x15, [SP], #16
  ldp  x12, x13, [SP], #16
  ldp  x10, x11, [SP], #16
  ldp  x8, x9, [SP], #16
  ldp  x6, x7, [SP], #16
  ldp  x4, x5, [SP], #16
  ldp  x2, x3, [SP], #16
  ldp  x0, x1, [SP], #16
.endm


.macro print_str str
  stp  x0, x1, [sp
  stp  x2, x3, [sp, #-16]!
  stp  x4, x5, [sp, #-16]!
  stp  x6, x7, [sp, #-16]!
  stp  x8, x9, [sp, #-16]!
  stp  x10, x11, [sp, #-16]!
  stp  x12, x13, [sp, #-16]!
  stp  x14, x15, [sp, #-16]!
  stp  x16, x17, [sp, #-16]!
  stp  x18, lr, [sp, #-16]!
  ldr  x0, =1f  // load print str
  bl   printf   // call printf
  ldp  x18, lr, [sp], #16
  ldp  x16, x17, [sp], #16
  ldp  x14, x15, [sp], #16
  ldp  x12, x13, [sp], #16
  ldp  x10, x11, [sp], #16
  ldp  x8, x9, [sp], #16
  ldp  x6, x7, [sp], #16
  ldp  x4, x5, [sp], #16
  ldp  x2, x3, [sp], #16
  ldp  x0, x1, [sp], #16
  b    2f  // branch around str
1:
  .asciz "\str\n"
  .align 4
2:
.endm
  

.data
ptf_str:   .asciz "X%c = %32ld, 0x%016lx\n"
.align 4
.text
