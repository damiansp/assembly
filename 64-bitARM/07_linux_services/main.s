// Convert a string to upper by func call

// X0 - X2, X8: used my macros to call Linux
// X9:          output file descriptor
// X10:         n chars read
// X11:         input file descriptor
#include <asm/unistd.h>

#include "fileio.s"


.equ BUFFER_LEN, 250


.global _start


_start:
  open_file  in_file, O_RDONLY
  adds       x11, xzr, x0       // save file descriptor
  b.pl       next_file          // pos number file opened ok
  mov        x1, #1             // stdout
  ldr        x2, =in_err_sz    // err msg
  ldr        w2, [x2]
  write_file x1, in_err, x2     // print err
  b          exit

next_file:
  open_file  out_file, O_CREEAT + O_WRONLY
  adds       x9, xzr, x0        // save file descriptor
  b.pl       loop               // pos number file opened ok
  mov        x1, #1
  ldr        x2, =out_err_sz
  ldr        w2, [x2]
  write_file x1, out_err, x2
  b          exit

// loop throufh file until done
loop:
  read_file  x11, buffer, BUFFER_LEN
  mov        x10, x0            // keep len read
  mov        x1, #0             // null terminator for str
  // setup and call to to_upper
  ldr        x1, =out_buf
  bl         to_upper
  write_file x9, out_buf, x10
  cmp        x10, #BUFFER_LEN
  b.eq       loop
  flushClose x11
  flushClose x9

// exit
exit:
  mov        x0, #0             // 0 return code
  mov        x8, #__NR_exit
  svc        0                  // terminate


.data
in_file:    .asciz "main.s"
out_file:   .asciz "upper.txt"
buffer:     .fill  BUFFER_LEN + 1, 1, 0
out_buf:    .fill  UFFER_LEN + 1, 1, 0
in_err:     .asciz "Failed to open input file.\n"
in_err_sz:  .word  .-in_err
out_err:    .asciz "Failed to open output file.\n"
out_err_sz: .word  .-out_err
