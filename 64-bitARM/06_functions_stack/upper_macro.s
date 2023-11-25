// Convert a string to all upper case

// X0: addr of instr
// X1: addr of outstr
// X2: orig output str for len calc
// W3: current char being processed

// label 1: loop  
// label 2: cont

  
.MACRO toupper instr, outstr
  ldr  x0, =\instr
  ldr  x1, =\outstr
  mov  x2, x1

// loop until byte pointed at by x1 is non-zero
1:
  ldrb w3, [x0], #1  // load ahr and ptr++
  cmp  w3, #'z'
  b.gt 2f            // letter > 'z': go to cont
  cmp  w3, #'a'
  b.lt 2f            // elif letter < 'a': go to cont
  // else is lower case letter
  sub  w3, w3, #('a' - 'A')  // convert

// cont
2: 
  strb w3, [x1], #1  // store char in output str
  cmp  w3, #0
  b.ne 1b            // if char != 0 (null terminator); loop
  sub  x0, x1, x2    // get len by ptr subtraction

.ENDM
