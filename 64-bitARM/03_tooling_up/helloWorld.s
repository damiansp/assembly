// X0 - X2: params to Linux function services
// X8: Linux function number

.global _start // start address


_start:
  mov X0, #1    // 1: stdout
  ldr X1, =msg  // string to print
  mov X2, 14    // len of str
  mov X8, #64   // Linux write sys call
  svc 0         // call linux to output

  mov x0, #0    // use 0 return code
  mov X8, #93   // 93: terminate
  svc 0         // execute


.data
msg: .ascii "Hello, World!\n"
  
  
