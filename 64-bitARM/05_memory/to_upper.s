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
  // if w5 > 'z' -> cont
  cmp  w5, #'z'
  b.gt cont
  // elif < 'a' -> cont
  cmp  w5, #'a'
  b.lt cont
  // else char is lower case [a-z]
  sub  w5, w5, #('a' - 'A')  // to upper

cont:
  strb w5, [x3], #1  // store char in w5 to outstr
  cmp  w5, #0        // reached null terminator? ('\0')
  b.ne loop          // onto next char
  // print hex number
  mov  x0, #1        // 1: stdout
  ldr  x1, =outstr   // str to print
  sub  x2, x3, x1    // get len(str) by subrtracting pointers
  mov  x8, #64       // linux write call
  svc  0             // execute
  // exit
  mov  x0, #0        // 0: return code
  mov  x8, #93       // 93: terminate
  svc  0             // execute

.data
instr:   .asciz "This is the Test String to convert.\n"
outstr:  .fill 255, 1, 0
