  .global _start
  .align  2

  .section __TEXT,__text

_start:
  mov  x0, #0   // x0 = sum = 0
  mov  x1, #1   // x1 = counter = 1
  mov  x2, #10  // x2 = limit = 10

loop:
  add  x0, x0, x1  // sum += counter
  add  x1, x1, #1  // counter++
  cmp  x1, x2      // compare counter to limit
  b.le loop        // if counter <= 10 go to loop:

  // x0 = 55 (sum(1, 2, ..., 10))
  // Exit with sum as exit code (contents of x0)
  mov  x16, #1
  svc  #0x80
