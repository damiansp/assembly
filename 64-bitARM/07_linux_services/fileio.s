// Various macros to perform file i/o

// The fd param needs to be a register.
// Uses X0, X1, X8
// Return code is X0

#include <asm/unistd.h>


.equ O_RDONLY, 0
.equ O_WRONLY, 1
.equ O_CREA,   0100
.equ O_EXCL,   0200
.equ S_RDWR,   0666
.equ AT_FDCWD, -100


.macro open_file file_name, flags
  mov  x0, #AT_FDCWD
  ldr  x1, =\file_name
  mov  x2, #\flags
  mov  x3, #S_RDWR      // rw access rights
  mov  x8, #__NR_openat
  sv   0
.endm


.macro read_file fd, buffer, length
  mov  x0, \fd          // file descriptor
  ldr  x1, =\buffer
  mov  x2, #\length
  mov  x8, #__NR_read
  svc  0
.endm


.macro write_file fd, buffer, length
  mov  x0, \fd           // file descriptor
  ldr  x1, =\buffer
  mov  x2, \length
  mov  x8, #__NR_write
  svc  0
.endm


.macro flush_close fd
  // fsync syscall
  mov  x0, \fd
  mov  x8, #__NR_fsync
  svc  0
  // close syscall
  mov  x0, \fd
  mov  x8, #__NR_close
  svc  0
.endm

  
