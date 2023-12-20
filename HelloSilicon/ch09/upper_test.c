// C program to call assembly to_upper routine
#include <stdio.h>
extern int my_to_upper(char*, char*);

#define MAX_BUFF 255


int main() {
  char* str = "This is only a test.";
  char out_buff[MAX_BUFF];
  int len = my_to_upper(str, out_buff);
  printf("Before: %s\n", str);
  printf("After: %s\n", out_buff);
  printf("Len: %d\n", len);
  return 0;
}
