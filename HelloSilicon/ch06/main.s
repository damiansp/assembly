// Convert a string to all upper case by calling a function.
// X0-X2: parameters to linux function services
// X1:    address of output string
// X0:    address of input string
// X8:    linux function number

.global _start
.p2align 2

_start:
  adrp x0, instr@PAGE  // start instr
  add  x0, x0, instr@PAGEOFF
  adrp x1, outstr@PAGE // addr of outstr
  add  x1, x1, outstr@PAGEOFF
  bl   to_upper

  // print hex number
  mov  x2, x0          // return code is len(str)
  mov  x0, #1          // 1: stdout
  adrp x1, outstr@PAGE // str start
  add  x1, x1, outstr@PAGEOFF
  mov  x16, #4         // Unix write syscall
  svc  #0x80           // exec

  // exit
  mov  x0, #0          // 0: return code
  mov  x16, #1         // 1: terminate
  svc  #0x80           // exec

.data
instr:  .asciz "This is our Test String that we will convert.\n"
outstr: .fill 255, 1, 0
