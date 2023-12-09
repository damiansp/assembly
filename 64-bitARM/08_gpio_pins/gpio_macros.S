// Macros to access GPIO pins on a Raspberry Pi
// X9: file descriptor
#include "fileio.S"

// Macro nano_sleep to sleep 0.1 s
// Calls Linux nanosleep entry point.
// Pass a ref to a timespec in both X0 and X1  
// First is input time to sleep in seconds and nanoseconds
// Second is time left to sleep if interrupted (ignored here)
.macro nano_sleep
  ldr  x0, =timespecsec
  ldr  x1, =timespecsec
  mov  x8, #__NR_nanosleep
  svc  0
.endm
  
.macro GPIO_export pin
  open_file   gpio_exp, 0_WRONLY
  mov         x9, x0              // save file descriptor
  write_file  x9, \pin, #2
  flush_close x9
.endm

  
  
