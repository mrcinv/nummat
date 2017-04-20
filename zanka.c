#include <stdlib.h>
#include <stdio.h>
void main()
{
  long j = 0;
  for(long i=0; i<(1e9); i++){
    j++;
  }
  printf("%ld\n",j);
}
