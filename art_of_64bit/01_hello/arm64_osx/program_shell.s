// ".text" tells the assembler the following statements go into memory
// reserved for machine instructions
  .text

// Here is the "main" function (assumes this is a stand alone prog w/ is own
// main func).
  .global _main
_main:
  // whatever here
  ret                           // returns to caller
