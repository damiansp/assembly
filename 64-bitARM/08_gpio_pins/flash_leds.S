// Flash 3 LEDs connected to the rapspberry pi GPIO port
// w6: loop var to flash lights 10x
#include "gpio_macros.S"

.global _start
_start:
  GPIO_export        pin17
  GPIO_export        pin27
  GPIO_export        pin22
  nano_sleep
  GPIO_direction_out pin17
  GPIO_direction_out pin27
  GPIO_direction_out pin22
  // set up a loop counter for 10 iters
  mov                w6, #10
  
loop:
  GPIO_write pin17, high
  nano_sleep
  GPIO_write pin17, low
  GPIO_write pin27, high
  nano_sleep
  GPIO_write pin27, low
  GPIO_write pin22, high
  nano_sleep
  GPIO_write pin22, low
  // decr lpp counter and see if we loop again
  subs       w6, w6, #1
  // If not counted down to 0, loop
  b.ne       loop

_end:
  mov x0, #0  // 0: return code
  mov x8, #__NR_exit
  svc 0       // terminate


pin17: .asciz "17"
pin22: .asciz "22"
pin27: .asciz "27"
low:   .asciz "0"
hight: .asciz "1"
