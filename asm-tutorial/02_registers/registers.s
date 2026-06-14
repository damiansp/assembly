  // Each register has two views: x0 is the full 64-bit register; w0 is the
  // lower 32 bits of the same register.  Writing w0 zero-extendes into x0.
  .global _start
  .align  2

  .section __TEXT,__text
_start:
  // Load immediate vals
  mov  x0, #42   // x0 = 42
  mov  x1, #100  // x1 = 100

  // Copy between registers
  mov  x2, x0    // x2 = x0 = 42
  mov  x3, xzr   // x3 = 0

  // w-registers
  mov  w4, #7    // w4 = 7; x4 = 0x0000000000000007

  // movz / movk for larger constants
  movz x5, #0xABCD, lsl #16
  movk x5, #0x1234           // x5 = 0x00000000ABCD1234

  // Exit with x2 as exit code (42)
  // Does nothing since already equal, but makes clear the computed result in
  // x2 should be ther return result (hence moved to x0)
  mov  x0,  x2               
  mov  x16, #1
  svc  #0x80
