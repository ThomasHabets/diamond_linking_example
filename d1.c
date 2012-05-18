#include<stdio.h>

void d1_print(const char *s)
{
  printf(" d1_print()\n");
  base_print(s);
}

int d1()
{
  printf("d1()\n");
  d1_print("d1");
}

