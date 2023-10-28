// Call the upper function to convert str to uppercase
// X0-X2: params to linux functions
// X0:    addr of instr
// X1:    addr of outstr
// X8:    linux func no.

.global _start

_start:
  ldr  x0, =instr   // start of instr
  ldr  x1, =outstr  // addr of outstr
  bl   toupper

// print hex number
  mov  x2, x0       // return code is the length
  mov  x0, #1       // 1: stdout
  ldr  x1, =outstr  // str to print
  mov  x8, #64      // linux write
  svc  0            // exec

// exit
  mov  x0, #0       // 0 return code
  mov  x8, #93      // terminate
  svc  0            // exex

.data
instr: .asciz "This is our Test String that we will convert.\n"
outstr: .fill 255, 1, 0
