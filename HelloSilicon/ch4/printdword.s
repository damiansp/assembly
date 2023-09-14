// Print a register in hex to stdout

// X0 - X2: linux function sevice params
// X1:      (also) addreess of byte to write
// X4:      register to print
// W5:      loop index
// W6:      current char
// X8:      linux func number

.global _start
.align 2

_start:
  MOV  X4, #0x6E3A
  MOVK X4, #0x4F5D, LSL #16
  MOVK X4, #0xFEDC, LSL #32
  MOVK X4, #0x1234, LSL #48

  ADRP X1, hexstr@PAGE  // start of string
  ADD  X1, X1, hexstr@PAGEOFF
  ADD  X1, X1, #17      // start of least sig digit

  // Loop: for W5 = 16..1
  MOV  W5, #16          // 16 digits to print
loop:
  AND  W6, W4, #0xF     // mask off least sig digit
  // if W6 >= 10: goto letter
  CMP  W6, #10          // 0-9 or A-F
  B.GE letter
  // else number: convert to ASCII digit
  ADD  W6, W6, #'0'
  B    cont             // end if
letter:
  ADD  W6, W6, #('A' - 10)
cont: // end if
  STRB W6, [X1]         // store ascii digit
  SUB  X1, X1, #1       // decr addr for next digit
  LSR  X4, X4, #4       // shift off digit we just processed
  // Next iteration of for loop
  SUBS W5, W5, #1       // W5--
  B.NE loop             // next iter if not done

  // print hex number
  MOV  X0, #1           // 1: stdout
  ADRP X1, hexstr@PAGE  // str start
  ADD  X1, X1, hexstr@PAGEOFF
  MOV  X2, #19          // len(str)
  MOV  X16, #4          // linux write sys
  SVC  #0x80            // execute

  // exit
  MOV  X0, #0           // 0: return code
  MOV  X16, #1          // 1: terminate
  SVC  #0x80            // execute

.data
hexstr:  .ascii "0x123456789ABCDEFG\n"
