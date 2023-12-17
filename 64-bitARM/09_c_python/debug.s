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

.endm
  
  
