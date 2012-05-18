#include<stdio.h>

void base_print(const char*);

void
d2_print(const char* s)
{
  printf(" d2_print()\n");
  base_print(s);
}

void
d2()
{
  printf("d2()\n");
  d2_print("d2");
}


