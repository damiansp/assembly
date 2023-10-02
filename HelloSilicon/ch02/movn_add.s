// To display result, run then:
// echo $? 
.global _start
.align 2


_start:
  MOVN W0, #2  // -3 (ones(2)): 2: 0010 !2: 1101
  // Add 1 to W0 and put res back in W0
  ADD  W0, W0, #1  // -2: 1101 + 1 = 1110 (-2)


  // Exit with W0 as return code
  MOV  X16, #1  // teminate code
  SVC  #0x80    // exec
