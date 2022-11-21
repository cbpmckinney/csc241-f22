#include<stdio.h>
#include<string.h>

int square(int num)
{
    num = num*num;
    return num;
}

int mult(int a, int b)
{
    return a*b;
}


int main(void)
{

    int number = 5;
    int answer = square(number);

    printf("The square of %i is %i\n",number,answer);

    int a = 3;
    int b = 7;
    int ans2 = mult(a,b);
    printf("The product of %i and %i is %i\n",a,b,ans2);

    return 0;
}