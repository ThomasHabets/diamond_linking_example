#include<stdio.h>

void base_print(const char*);
void d2_print(const char*);

static
void
__attribute__ ((constructor))
d1_init(void)
{
  printf("d1> init\n");
}

static
void
__attribute__ ((destructor))
d1_fini(void)
{
  printf("d1> fini\n");
}

void
d1_print(const char* s)
{
  printf(" d1_print()\n");
  base_print(s);
}

void
d1()
{
  printf("d1()\n");
  d1_print("d1");
}

