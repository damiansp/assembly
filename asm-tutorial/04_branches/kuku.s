  // print:
  // 1 2 3
  // 2 4 6
  // 3 6 9
  .global _start
  .align  2

  
  .section __TEXT,__text

// print_char: prints a single ASCII character
// Args: x0 = ASCII value of char to print
print_char:
  stp  x29, x30, [sp, #-32]!  // store pair (x29 is frame pointer-fp; x30 is
                              // link regiters-lr, addr of func calls, sp is
                              // stack pointer; [sp, #-32]! -- get addr at sp 
                              // -32, and store back (!) to sp; addr adj
                              // happens before the store
  mov  x29, sp
  str  x0,  [sp, #16]         // store char on stack so we can point at it;
                              // (store value at x0 to the addr of sp+16

  mov  x0,  #1                // fd = stdout
  add  x1,  sp, #16           // x1 = address of char on stack
  mov  x2,  #1                // count = 1 byte
  mov  x16, #4                // syscall write
  svc  #0x80

  ldp  x29, x30, [sp], #32    // load pair: x29 gets 8-bytes at sp; x30 gets
                              // the 8 bytes at sp + 8; THEN sp + 32 gets
                              // written back to sp
  ret


//print_digit: converts a single digit (0-9) to ASCII and prints it
// Args: x0 = integer digit (0-9)
print_digit:
  stp  x29, x30, [sp, #-16]!
  mov  x29, sp

  add  x0, x0, #48           // convert to ASCII: '0' = 48
  bl   print_char            // bl: branch with link

  ldp  x29, x30, [sp], #16
  ret


// print_newline: prints a newline char
print_newline:
  stp  x29, x30, [sp, #-16]!
  mov  x29, sp

  mov  x0, #10                // ASCII newline
  bl   print_char

  ldp  x29, x30, [sp], #16
  ret


// print_space: prints a space char
print_space:
  stp  x29, x30, [sp, #-16]!
  mov  x29, sp
  
  mov  x0,  #32               // ASCII space
  bl   print_char

  ldp  x29, x30, [sp], #16
  ret


_start:
  mov  x19, #1  // x19 = outer counter (row i) i = 1, ..., 3


outer_loop:
  mov  x20, #1  // x20 = inner counter (col j), j - 1, ..., 3


inner_loop:
  mul  x21, x19, x20  // x21 = i * j

  mov  x0, x21
  bl   print_digit

  cmp  x20, #3
  b.eq inner_done     // if last column, no trailing space
  bl   print_space    // else print space between cols


inner_done:
  add  x20, x20, #1   // j++
  cmp  x20, #3
  b.le inner_loop     // if j <= 3, continue inner loop

  bl   print_newline  // end of row

  add  x19, x19, #1   // i++
  cmp  x19, #3
  b.le outer_loop     // if i <= 3, continue outer loop

  mov  x0,  #0        // exit(0)
  mov  x16, #1
  svc  #0x80
