#include<stdio.h>

void base_print(const char*);
void d1_print(const char*);

static
void
__attribute__ ((constructor))
d2_init(void)
{
  printf("d2> init\n");
}

static
void
__attribute__ ((destructor))
d2_fini(void)
{
  printf("d2> fini\n");
}

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
  d1_print("d2");
}


