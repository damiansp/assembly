// Example of 128-bit addition with carry flag

.global _start
.align 2  

_start:
  // Carry out 0x0000000000000003FFFFFFFFFFFFFFFF
  //         + 0x000000000000005000000000000001
  // Load 64-bit number into registers
  MOV  X2, #0x0000000000000003
  MOV  X3, #0xFFFFFFFFFFFFFFFF
  MOV  X4, #0x0000000000000005
  MOV  X5, #0x0000000000000001
  // Add
  ADDS X1, X3, X5  // add lower bits; (maybe) set carry flag
  ADC  X0, X2, X4  // higher bits + (potential) carry bit

  // Exit
  MOV  X16, #1  // terminate
  SVC  #0x80    // kernel call

  // echo $? to see W0 (return code)

  //                1                   (carry bit)
  // 0000000000000003 FFFFFFFFFFFFFFFF
  // 0000000000000005 0000000000000001
  // ---------------- ----------------
  // 0000000000000009 0000000000000000   (W0 = 9)
