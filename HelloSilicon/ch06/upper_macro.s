// Convert str to upper case

// x0: addr of instr
// x1: addr of outstr
// x2: orig outstr for len calc
// w3: current char being processed

// labels
//   1: loop
//   2: cont

  
.macro to_upper instr, outstr

  adrp x0, \instr@PAGE
  add  x0, x0, \instr@PAGEOFF
  adrp x1, \outstr@PAGE
  add  x1, x1, \outstr@PAGEOFF
  mov  x2, x1

1:  // loop until byte pointed at by x1 is non-zero
  ldrb w3, [x0], #1          // load char and ptr++
  cmp  w3, #'z'
  b.gt 2f                    // if w3 > 'z' -> 2
  cmp  w3, #'a'
  b.lt 2f                    // elif w3 < 'a' -> 2
  sub  w3, w3, #('a' - 'A')  // else is lowercase on [a-z]; convert

2:  // end if
  strb w3, [x1], #1          // store char to outstr
  cmp  w3, #0
  b.ne 1b                    // if w3 != 0 (null terminator) -> 1
  sub  x0, x1, x2            // get len by ptr subtraction
  
.endm
  
