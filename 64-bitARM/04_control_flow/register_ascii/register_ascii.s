// Print a register in hex to stdout

// X0-X2: params to linux function services
// X1:    (also) address of byte we are writing
// X4:    register to print
// W5:    loop index
// W6:    current char
// X8:    linux function number


.global _start

_start:
  MOV  X4, #0x6E3A
  MOVK X4, #0x4F5D, LSL #16
  MOVK X4, #0xFEDC, LSL #32
  MOVK X4, #0x1234, LSL #48

  LDR  X1, =hexstr  // start of string
  ADD  X1, X1, #17  // start of least sig digit

  // Loop: for W5 = 16 ... 1
  MOV  W5, #16       // 16 digits to print
loop:
  AND  W6, W4, #0xF  // mask least sif digit
  // if W6 >= 10 -> goto letter
  CMP  W6, #10       // is 0-9 or A-F
  B.GE letter
  // else it's a number: convert to ASCII digit
  ADD  W6, W6, #'0'
  B    cont          // end if
letter:              // handle A-F
  ADD  W6, W6, #('A' - 10)
cont:                // end if
  STRB W6, [X1]      // store ASCII digit
  SUB  X1, X1, #1    // decr address for next digit
  LSR  X4, X4, #4    // shift off the digit
  // next W5
  SUBS W5, W5, #1    // W5--
  B.NE loop          // loop again if not done


  // Set up params to print out hex number; call Linux kernel to executen
  MOV  X0, #1        // 1: stdout
  LDR  X1, =hexstr   // string to print
  MOV  X2, #19       // len(string)
  MOV  X8, #64       // linux write sys call
  SVC  0             // execute

  // Exit
  MOV X0, #0         // 0 return code
  MOV X8, #93        // 93: terminate
  SVC 0              // execute


.data
hexstr: .ascii "Ox123456789ABCDEFG\n"
