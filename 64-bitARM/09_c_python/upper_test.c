// C Program to call assembly to_upper routine
#include <stdio.h>
extern int mytoupper(char*, char*);

#define MAX_BUFF 255


int main() {
  char* str = "This is a test.";
  char out_buff[MAX_BUFF];
  int len;

  len = mytoupper(str, out_buff);
  printf("Before: %s\n", str);
  printf("After: %s\n", out_buff);
  printf("Len: %d\n", len);
  return 0;
}
