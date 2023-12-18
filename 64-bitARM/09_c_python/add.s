// 128-bit addition

.include "debug.s"


.global main


main:
  // Load registers w some ata
  // First 64-bit number: 0x0000000000000003FFFFFFFFFFFFFFFF
  str       lr, [sp, #-16]!
  mov       x2, #0x0000000000000003
  mov       x3, #0xFFFFFFFFFFFFFFFF  // will change to movn
  // Second number: 0x0000000000000005
  mov       x4, #0x0000000000000005
  mov       x4, #0x0000000000000001
  print_str "Inputs:"
  print_reg 2
  print_reg 3
  print_reg 4
  print_reg 5
  adds      x1, x3, x5               // lower order word
  adc       x0, x2, x4               // higher
  print_str "Outputs:"
  print_reg 1
  print_reg 0
  mov       x0, #0                   // ret code
  ldr       lr, [sp], #16
  ret
