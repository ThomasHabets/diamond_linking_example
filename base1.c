#include<stdio.h>

void base_printi(const char *s)
{
  printf("  base version 1> %s\n", s);
}

asm(".symver base_printi,base_print@@BASE1");
