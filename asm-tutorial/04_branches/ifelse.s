  .global _start
  .align  2

  .section __TEXT,__text

_start:
  mov  x0, #0   // x0 = sum = 0
  mov  x1, #1   // x1 = counter = 1

  // max: x2 = max(x0, x1) = if x0 > x1 x0 else x1
  cmp  x0, x1
  b.le else_branch
  mov  x0, x0
  b    end_if

else_branch:
  mov  x2, x1

end_if:
  mov  x0, x2  // prep to output max
  mov  x16, #1
  svc  #0x80
