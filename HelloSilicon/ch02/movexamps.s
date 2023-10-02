// Example MOV instructions
.global _start
.align 2

_start:
  // Load 0x1234FEDC4F5D6E3A into X2 using MOV and MOVK
  MOV  X2, #0x6E3A
  MOVK X2, #0x4F5D, LSL #16
  MOVK X2, #0xFEDC, LSL #32
  MOVK X2, #0x1234, LSL #48

  // Move (just) W2 to W1
  MOV W1, W2

  // MOV variants
  // Do not work with clang assembler
  //MOV X1, X2, LSL #1	// Logical shift left
  //MOV	X1, X2, LSR #1	// Logical shift right
  //MOV	X1, X2, ASR #1	//Arithmetic shift right
  //MOV	X1, X2, ROR #1	// Rotate right

  // Same as prev with mnemonics
  LSL X1, X2, #1
  LSR X1, X2, #1
  ASR X1, X2, #1
  ROR X1, X2, #1

  // 8-bit immediate and shift
  MOV X1, #0xAB000000  // too big for #imm16
  //MOV X1, #0xABCDF11 // top big for #imm16; can't be represented (err)

  // MOVN (move not: flip bits then move)
  MOVN W1, #45

  // MOV that assembler converts to MOVN
  MOV W1, #0xFFFFFFFE  // -2

  // Exit
  MOV X0, #0   // 0 return code
  MOV X16, #1  // Sys call 1 terminates
  SVC #0x80    // Call kernel to execute
