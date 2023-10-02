// Convert string to uppercase
// x0-x2: params to linux kernel
// x3:    address of out str
// x4:    address of in str
// w5:    current char being processed
// x8:    linux function number

.global _start
.p2align 2

_start:
  adrp x4, instr@PAGE          // start of in str
  add  x4, x4, instr@PAGEOFF
  adrp x3, outstr@PAGE         // addr of out str
  add  x3, x3, outstr@PAGEOFF

loop: 
// Loop until byte pointed at by x1 is not 0
  ldrb w5, [x4], #1            // load char and incr pointer
  // if w5 > 'z' -> cont
  cmp  w5, #'z'                // char > 'z'?
  b.gt cont
  // elif < 'a' -> cont
  cmp  w5, #'a'
  b.lt cont
  // else char is lower case [a-z]
  sub  w5, w5, #('a' - 'A')

cont:
  strb w5, [x3], #1            // store char in w5 to outstr
  cmp  w5, #0                  // reached null terminator ('\0')?
  b.ne loop                    // onto next char
  // print hex number
  mov  x0, #1                  // 1: stdout
  adrp x1, outstr@PAGE         // str to print
  add  x1, x1, outstr@PAGEOFF
  sub  x2, x3, x1              // get len(str) by subtracting pointers
  mov  x16, #4                 // 4: Unix write sys call
  svc  #0x80                   // execute
  // exit
  mov  x0, #0                  // 0: return code
  mov  x16, #1                 // 1: terminate
  svc  #0x80                   // execute

.data
instr:   .asciz "This is the Test string to convert.\n"
outstr:  .fill 255, 1, 0
