// A simple C++ prog that calls ans assembly language function
#include <stdio.h>

// extern "C" namespace prevents name mangling by C++ compiler
extern "C" {
  // external assembly func
  void asm_func(void);
};


int main() {
  printf("Calling asm_main:\n");
  asm_Func();
  printf("Returned from asm_main\n");
}
