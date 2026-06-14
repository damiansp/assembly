  .global _start
  .align 2

  .section __TEXT,__text

_start:
  // 3(10 + 5)
  mov  x0, #10     // x0 = 10
  mov  x1, #5      // x1 = 5
  add  x0, x0, x1  // x0 = x0 + x1 = 10 + 5 = 15
  mov  x1, #3      // x1 = 3
  mul  x0, x0, x1  // x0 = x0 * x1 = 15 * 3 = 45

  // Modulo
  mov  x1, #7      // x1 = 7
  sdiv x2, x0, x1  // x2 = x0 / x1 = 45 / 7 = 6; int div
  msub x3, x2, x1, x0  // x3 = x0 - (x2 * x1) = 45 - (6 * 7) = 3


  // Bit manip
  mov  x4, #0b0011    // x4 = 3 (binary)
  orr  x4, x4, #8     // 0011 | 1000 = 1011
  and  x4, x4, #0xFE  // 0000 1011 & 1111 1110 = 0000 1010 (dec. 10)
  lsl  x4, x4, #1     // left shift 1: -> 0001 0100 (dec 20) (= 10*2)

  // Exit with x3 (remainder of 3)
  mov x0, x3
  mov x16, #1
  svc #0x80
