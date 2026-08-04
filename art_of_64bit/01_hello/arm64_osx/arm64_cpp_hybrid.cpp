// A simple C++ prog that calls ans assembly language function
#include <stdio.h>

// extern "C" namespace prevents name mangling by C++ compiler
extern "C" {
  // external assembly func
  void arm64_func(void);
};


int main() {
  printf("Calling arm64_main:\n");
  arm64_func();
  printf("Returned from arm64_main\n");
}
