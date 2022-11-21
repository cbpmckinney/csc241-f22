#include<stdio.h>
#include<string.h>

int main(void)
{
    int number = 7;
    double number2 = 3.14;
    char mystring[] = "Hello!\0";
    int myarray[] = {3,1,4,1,5};

    int *ptr1 = &number;
    double *ptr2 = &number2;
    char *ptr3 = mystring;
    int *ptr4 = myarray;
    int (*ptr5)[5] =&myarray;

    //printf("The character located at %p is %c\n", ptr3, *(ptr3));
    //printf("The character located at %p is %c\n", ptr3+1, *(ptr3+1));

    //printf("The integer located at %p is %i\n", ptr4, *(ptr4));
    //printf("The integer located at %p is %i\n", ptr4+1, *(ptr4+1));

    printf("ptr4 is %p\n",ptr4);
    printf("ptr4 + 1 is %p\n",ptr4+1);
    printf("ptr5 is %p\n",ptr5);
    printf("ptr5 + 1 is %p\n",ptr5+1);

    return 0;
}