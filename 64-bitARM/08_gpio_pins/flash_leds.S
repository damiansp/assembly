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
  
