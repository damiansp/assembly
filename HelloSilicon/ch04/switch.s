// AArch64 Assembly Code
// Programming with 64-Bit ARM Assembly Language
// Ch 4: Exercise 2
// Jeff Rosengarden 2020-08-27
// Source: github.com/below/HelloSilicon/blob/main/Chapter 04/case.s

// Emulate a switch/case statement

// x0 - x2: params for kernel sys calls
// x0:      file device (FD) for output (stdout)
// x1:      address of msg
// x2:      len(msg)
// x9:      calculated len of msg
// w11:     switch value (1 - 3 inclusive)
// w12:     return value (Note: transferred to w0 just before exit)
// w13:     work register used during calculation of msg len
// x16:     syscall id

.global _start
.align 2

_start:
  // switch portion of case statement - branches to case1/2/3 or default,
  // depending on value in w11
  // set "case" value (1 -3 ) in w11
  mov  w12, 0xff       // prep for error case
  cmp  x0,  #2         // make sure exactly 2 args
  bne  end             // end if not
  ldr  x11, [x1, #8]   // get pointer ad x1 + 8
  ldrb w11, [x11]      // load byte at pointer into w11
  sub  w11, w11, #'0'  // subtract ascii val for '0'
  cmp  w11, #1         // if w1 - 1 == 0: set Z flag to 1
  b.eq case1           // if Z flag == 1
  cmp  w11, #2         // if w1 - 2 == 0: set Z flag to 1
  b.eq case2           // if Z flag == 1
  cmp  w11, #3         // if w1 - 3 == 0: set Z flag to 1
  b.eq case3           // if Z flag == 1
  // if w11 contains value other than 1 - 3, will fall through to <default>
  // branch

default:
  mov  w12, #99         // use 99 return code
  b    break

case1:
  mov  w12, #1          // return code 1
  b    break

case2:
  mov  w12, #2          // return code 2
  b    break

case3:
  mov  w12, #3          // return code 3 (break redundant here)

break:
  nop                   // (for debugging); code after switch/case goes here
  adrp x1, msg@PAGE     // start of msg
  add  x1, x1, msg@PAGEOFF
  // calculate msg len, store in x9
  mov x9, #0            // zero out x9 before each iter

cloop:
  ldrb w13, [x1, x9]    // get next digit in msg
  cmp  w13, #255        // if == 255? (0xFF)
  b.eq cend             // ...go to cend
  add  x9, x9, #1       // else x9++
  b    cloop            // ...and repeat

cend:
  // print str
  mov  x0,  #1          // 1: stdout
  mov  x2,  x9          // str len
  mov  x16, #4          // 4: sys write
  svc  #0x80            // execute

end:
  // exit program
  mov  w0,  w12         // move return code to x0
  mov  x16, #1          // 1: terminate
  svc  #0x80            // exec


.data
msg:
  .byte  0x1b           // clear screen
  .byte  0              // start msg at top of screen
  .asciz " Emulate switch/case in assembly\n\n"
  .asciz "   Use `echo $?` to see result of program"
  .asciz "\n\n\n"
  .byte  255
