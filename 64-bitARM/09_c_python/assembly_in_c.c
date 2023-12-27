// to_upper assembly routine embedded in C
#include <stdio.h>

extern int my_to_upper(char*, char*);

#define MAX_BUFF 255


int main() {
  char* str = "This is a test.";
  char out_buff[MAX_BUFF];
  int len;

  asm (
    "  mov  x4, %2\n"
    
    "loop:\n"
    "  ldrb w5, [%1], #1\n"
    "  cmp  w5, #'z'\n"
    "  bgt  cont\n"
    "  cmp  w5, #'a'\n"
    "  blt  cont\n"
    "  sub  w5, w5, #('a' - 'A')\n"

    "cont:\n"
    "  strb w5, [%2], #1\n"
    "  cmp  w5, #0\n"
    "  b.ne loop\n"
    "  sub  %0, %2, x4\n"
    : "=r" (len)
    : "r" (str), "r" (out_buff)
    : "r4", "r5"
  );

  printf("Before: %s\n", str);
  printf("After: %s\n", out_buff);
  printf("Len: %d\n", len);
  return 0;
}
