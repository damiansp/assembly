// Convert str to uppercase

// X0: addr of instr
// X1: addr of outstr
// X4: orig input str (for len calc)
// W5: current char being processed

.global to_upper
.align 4


to_upper:
  mov  x4, x1

// loop until byte pointed at by x1 is non-zero
loop:
  ldrb w5, [X0], #1          // load char and ptr++
  cmp  w5, #'z'
  b.gt cont                  // if char > 'z' go to cont
  cmp  w5, #'a'
  b.lt cont                  // if char < 'a' go to cont
  sub  w5, w5, #('a' - 'A')  // else char on [a-z]: to lower

cont:
  strb w5, [x1], #1          // store char to outstr
  cmp  w5, #0
  b.ne loop                  // if char not '\0' (null terminator), continue
  sub  x0, x1, x4            // get len by pointer subtraction
  ret                        // return to caller
