// Convert a string to upper case

// X0: addr of instr
// X1: addr of outstr
// X4: orig outstr for len calc
// W5: current char being processed

.global to_upper
.align 2

to_upper:
  mov  x4, x1

// loop until byte pointe at by X1 is non-zero
loop:
  ldrb w5, [x0], #1          // load char and ptr++
  cmp  w5, #'z'              // w5:'z'
  b.gt cont                  // if > go to cont
  cmp  w5, #'a'              // w5:'a'
  b.lt cont                  // if < go to cont
  // else is lower case letter
  sub  w5, w5, #('a' - 'A')  // convert to upper

cont:
  strb w5, [x1], #1          // store char to outstr
  cmp  w5, #0                // w5:0
  b.ne loop                  // if not 0 ('\0'), repeat
  sub  x0, x1, x4            // get len by subtracting pointers
  ret                        // return to caller
