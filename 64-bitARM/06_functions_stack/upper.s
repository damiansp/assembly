// Convert a string to upper case
// X0: addr of instr
// X1: addr of outstr
// X4: original output str (for length calc)
// X5: current char being processed

.global toupper

toupper:
  mov  x4, x1

// loop until byte pointed at by X1 != 0
loop:
  ldrb w5, [X0], #1  // load char and ptr++
  cmp  w5, #'z'      // W5 ... 'z'
  b.gt cont          // if >: cont
  // else
  cmp  w5, #'a'      // W5 ... 'a'
  b.lt cont          // if <: cont
  // else is a lower case letter
  // convert
  sub  w5, w5, #('a' - 'A')

// exit loop
cont:
  strb w5, [x1], #1  // store char to outputstr
  cmp  w5, #0        // W5 ... 0 (null terminator)
  b.ne loop          // if not, back to loop
  sub  x0, x1, x4    // get len by ptr subtraction
  ret                // return to caller
