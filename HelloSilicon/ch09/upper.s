// Assembler program to convert a string to all upper case.
// X0: address of input string
// X1: address of output string
// X4: original output string for length calc.
// W5: current character being processed

.global _my_to_upper  // Allow other files to call this routine
.p2align 2

_my_to_upper:
	MOV	X4, X1

// The loop is until byte pointed to by X1 is non-zero
loop:
  LDRB	W5, [X0], #1  // load character and increment pointer
	CMP	  W5, #'z'      // if letter cf 'z'
	B.GT	cont          // >
	CMP	  W5, #'a'      // elif cf a
	B.LT	cont          // < 
  // else letter is lower case, so convert it.
	SUB	  W5, W5, #('a'-'A')

cont:
	STRB	W5, [X1], #1  // store character to output str
	CMP	  W5, #0        // stop on hitting a null character
	B.NE	loop          // loop if character isn't null
	SUB	  X0, X1, X4    // get the length by subtracting the pointers
	RET                 // Return to caller
  
