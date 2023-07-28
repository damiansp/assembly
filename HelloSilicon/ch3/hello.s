// Assembler program to print "Hello, World!" to stdout
// X0-X2: pams to Unix sys calls
// X16 - Mach sys call function number

.global _start  // start addr for linker
.align 4        // make sure everything is properly aligned

// Set up params to print, call kernel to do it
_start:
  mov  X0, #1   // 1 = stdout
  adr  X1, msg  // str to print
  mov  X2, #14  // len of string
  mov  X16, #4  // unix write sys call
  svc  #0x80    // call kernel to output str

// Set up params to exit, call kernel to do it
  mov  X0, #0   // Use 0 return code
  mov  X16, #1  // syscall 1 terminates program
  svc  #0x80

msg:  .ascii "Hello, World!\n"
  
