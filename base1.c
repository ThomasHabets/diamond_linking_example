#include<stdio.h>

static
void
__attribute__ ((constructor))
base_init(void)
{
  printf("base version 1> init\n");
}

static
void
__attribute__ ((destructor))
base_fini(void)
{
  printf("base version 1> fini\n");
}

void
base_print(const char* s)
{
  printf("  base version 1> %s\n", s);
}
