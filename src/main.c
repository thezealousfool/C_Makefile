#include <stdio.h>

#ifdef DEBUG
#define INFO(str) printf("INFO:%s:%d: %s\n", __FILE__, __LINE__, str);
#else
#define INFO(str)
#endif

int main(void) {
  INFO("Starting main");
  printf("Hello World!\n");
}
