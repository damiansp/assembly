// Macros to access GPIO pins on a Raspberry Pi
// X9: file descriptor
#include "fileio.S"

// Macro nano_sleep to sleep 0.1 s
// Calls Linux nanosleep entry point.
// Pass a ref to a timespec in both X0 and X1  
// First is input time to sleep in seconds and nanoseconds
// Second is time left to sleep if interrupted (ignored here)
.macro nano_sleep
  ldr  x0, =time_spec_sec
  ldr  x1, =time_spec_sec
  mov  x8, #__NR_nanosleep
  svc  0
.endm
  
.macro GPIO_export pin
  open_file   gpio_exp, 0_WRONLY
  mov         x9, x0              // save file descriptor
  write_file  x9, \pin, #2
  flush_close x9
.endm

.macro GPIO_direction_out pin
  // copy pin into filename pattern
  ldr         x1, =\pin
  ldr         x2, =gpio_pin_file
  add         x2, x2, #20
  ldrb        w3, [x1], #1        // load pin and post incr
  strb        w3, [x2], #1        // store to file name and post incr
  ldrb        w3, [x1]
  strb        w3, [x2]
  open_file   gpio_pin_file, 0_WRONLY
  mov         x9, x0              // save file descriptor
  write_file  x9, out_str, #3
  flush_close x9
.endm

.macro GPIO_write pin, value
  // copy pint into filename pattern
  ldr         x1, =\pin
  ldr         x2, =gpio_value_file
  add         x2, x2, #20
  ldrb        w3, [x1], #1        // load pin and post incr
  strb        w3, [x2], #1        // store to file and post incr
  open_file   gpio_value_file, 0_WRONLY
  mov         x9, x0              // save file descr
  write_file  x9, \value, #1
  flush_close x9
.endm

.data
time_spec_sec:   .dword 0
time_spec_nano:  .dword 100000000
gpio_exp:        .asciz "sys/class/gpio/export"
gpio_pin_file:   .asciz "sys/class/gpio/gpioxx/direction"
gpio_value_file: .asciz "sys/class/gpio/gpioxx/value"
out_str:         .asciz "out"
                 .align 4
.text
