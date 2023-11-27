// Convert str to all upper case by calling a function.
//
// X0-X2, X16: used by macros to call kernel
// X9:         output file descriptor
// X10:        number of characters read
// X11:        input file descriptor

//#include <asm/unistd.h>
.equ	O_RDONLY, 0

#include "fileio.S"

.equ	BUFFER_LEN, 250


.global _start
.align 4


_start:
  MOV        X0, #-1
	open_file	 in_file, O_RDONLY
	MOV        X11, X0             // save file descriptor (or error)
	B.CC		   next_file           // carry clear, file opened ok
	MOV        X1, #1              // stdout
	ADRP       X2, in_err_sz@PAGE	 // Error msg
	ADD        X2, X2, in_err_sz@PAGEOFF	
	LDR        W2, [X2]
	write_file X1, in_err, X2      // print the error
	B          exit


next_file:
  open_file	  out_file, O_CREAT + O_WRONLY
	MOV         X9, X0	// save file descriptor (or error)
	B.CC        loop    // carry clear, file opened ok
	MOV         X1, #1
	ADRP        X2, out_err_sz@PAGE
	ADD         X2, X2, out_err_sz@PAGEOFF
	LDR         W2, [X2]
	write_file	X1, out_err, X2
	B           exit


// loop through file until done.
loop:
  read_file	  X11, buffer, BUFFER_LEN
	MOV         X10, X0	// Keep the length read
	MOV         X1, #0	// Null terminator for string
	// setup call to toupper and call function
	ADRP        X0, buffer@PAGE	// first param for toupper
	ADD         X0, X0, buffer@PAGEOFF
	STRB        W1, [X0, X10]	// put null at end of string.
	ADRP        X1, out_buf@PAGE
	ADD         X1, X1, out_buf@PAGEOFF
	BL          to_upper		
	write_file  X9, out_buf, X10
	CMP         X10, #BUFFER_LEN
	B.EQ        loop
	flush_close	X11
	flush_close	X9


exit:
  MOV X0, #0      // Use 0 return code
  MOV X16, #1
  SVC #0x80       // terminate


.data
in_file:    .asciz "main.S"
out_file:   .asciz "upper.txt"
buffer:	    .fill	 BUFFER_LEN + 1, 1, 0
out_buf:	  .fill	 BUFFER_LEN + 1, 1, 0
in_err:     .asciz "Failed to open input file.\n"
in_err_sz:  .word  .-in_err 
out_err:	  .asciz "Failed to open output file.\n"
out_err_sz: .word  .-out_err
