// Convert string to uppercase

// x0-x2: params to linux kernel
// x3:    address of out str
// x4:    address of in str
// w5:    current char being processed
// x8:    linux function number

.global _start

_start:
  ldr  x4, =instr   // start of in str
  ldr  x3, =outstr  // address of out str

// Loop until byte pointed to at x1 is not 0
loop:
  ldrb w5, [x4] #1  // load char and incr pointer
  
