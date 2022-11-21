#include<stdio.h>
#include<string.h>

int fact(int n) // n! = n*(n-1)!
{
    int ans = 0;
    if(n<=1)
        {
            ans = 1;
            return ans;
        }
    else
    {
        ans = n*fact(n-1);
        return ans;
    }

}


int main(void)
{
    int inputval;
    printf("Please type an integer\n");
    scanf("%i",&inputval);
    int factvalue = fact(inputval);
    printf("%i! is %i\n",inputval,factvalue);
    return 0;

}