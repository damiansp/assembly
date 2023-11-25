// Convert a str to upper case by calling a function
// X0-X2: params to linux func services
// X0:    addr of instr
// X1:    addr of outstr
// X2:    orig addr of instr
// X8:    Linux func number

.include "upper_macro.s"

.global _start


_start:
  // Convert tststr ro upper case
  toupper tststr, buffer

  // Print
  mov  x2, x0       // return code is len(str)
  mov  x0, #1       // 1: stdout
  ldr  x1, =buffer  // str to print
  mov  x8, #64      // linux write syscall
  svc  0            // execute

  // Convert 2nd str
  toupper tststr2, buffer

  // Print
  mov  x2, x0       // return code is len(str)
  mov  x0, #1       // 1: stdout
  ldr  x1, =buffer  // str to print
  mov  x8, #64      // linux write syscall
  svc  0            // execute

  // Exit
  mov  x0, #0       // 0 return code
  mov  x8, #93      // 93: terminate
  svc  0            // execute


.data
tststr: .asciz "This is our Test String that we will convert\n"
tststr2: .asciz "A second string to upper case!!\n"
buffer: .fill 255, 1, 0
