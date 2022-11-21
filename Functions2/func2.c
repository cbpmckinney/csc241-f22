#include<stdio.h>

extern int addfunc(int a, int b);

int main(void)
{
    int a = 2;
    int b = 3;
    int c = addfunc(a,b);
    printf("The sum of %i and %i is %i\n",a,b,c);

}

