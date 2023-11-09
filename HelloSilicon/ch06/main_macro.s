// Convert str ot upper case by calling a function

// x0-x2: params to os func services
// x0:    addr of instr
// x1:    addr of outstr
// x2:    orig addr of instr
// x16:   os func number

.include "upper_macro.s"

.global _start
.align 2

_start:
  to_upper tststr, buffer      // convert tststr to uppercase

  // print
  mov  x2, x0                  // len(str) is return code
  mov  x0, #1                  // 1: stdout
  adrp x1, buffer@PAGE         // str to print
  add  x1, x1, buffer@PAGEOFF
  mov  x16, #4                 // unix write syscall
  svc  #0x80                   // execute

  to_upper tststr2, buffer     // convert tststr2

  // print
  mov  x2, x0                  // len(str) is return code
  mov  x0, #1                  // 1: stdout
  adrp x1, buffer@PAGE         // str to print
  add  x1, x1, buffer@PAGEOFF
  mov  x16, #4                 // unix write syscall
  svc  #0x80                   // execute

  // exit
  mov  x0, #0                  // 0: return code
  mov  x16, #1                 // 1: terminate
  svc  #0x80                   // exec

.data
tststr:  .asciz "This is our Test String that we will convert.\n"
tststr2: .asciz "A second string to upper case!!\n"
buffer:  .fill 255, 1, 0
