  .global _start
  .align  2


  .section __TEXT,__text


// square(n): returns n * n in x0
// Args: x0 = n
square:
  // Leaf function - no bl calls, no callee-saved regs used, so we don't need
  // to set up a stack frame here
  mul  x0, x0, x0  // x0 *= x0 (n *= n)
  ret


// sum_of_squares(a, b): returns a^2 + b^2 in x0
// Args: x0 = a, x1 = b
sum_of_squares:
  // non-leaf: calls square(), so must save lr and callee regs
  stp  x29, x30, [sp, #-32]!  // push fp, lr; allocate 32 bytes
  mov  x29, sp                // set frame pointer
  str  x19, [sp, #16]         // save x19 (callee-saved)
  mov  x19, x1                // save b in x19 (x1 gets clobbered by bl)

  bl   square                 // x0 = a^2
  mov  x20, x0                // x20 = a^2

  mov  x0, x19                // x0 = b
  bl   square                 // x0 = b^2

  add  x0, x20, x0            // x0 += x20 (= a^2 + b^2)

  ldr  x19, [sp, #16]         // restore x19
  ldp  x29, x30, [sp], #32    // pop fp, lr
  ret


_start:
  mov  x0, #3          // a = 3
  mov  x1, #4          // b = 4
  bl   sum_of_squares  // x0 = 3^2 + 4^2 = 9 + 16 = 25

  mov  x16, #1
  svc  #0x80           // exit(25)
