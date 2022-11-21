#include<stdio.h>
#include<string.h>

int main(void)
{
    int mynumber;
    char mystring[16];
    int success1, success2;

    printf("The number is located at %p\n",&mynumber);
    printf("The string is located at %p\n",mystring);

    printf("Please type a number: \n");
    success1 = scanf("%i",&mynumber);
    printf("The input value is %i and scanf returned %i\n",mynumber,success1);
    

    printf("Please type a string: \n");
    success2 = scanf("%s",mystring);
    printf("The input string was \"%s\" and scanf returned %i\n",mystring,success2);



}