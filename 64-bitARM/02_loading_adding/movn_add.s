.global _start

_start: 
  // 2 * -1
  MOVN W0, #2      // W0 = 2? -2?
  ADD  W0, W0, #1  // W0 = W0 + 1 ( -3?  5?)

  // Exit: W0 is return code
  MOV X8, #93  // terminate
  SVC 0        // execute
