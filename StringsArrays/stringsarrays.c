#include<stdio.h>
#include<string.h>

int main(void)
{

    char mychar = 'A';
    char myString[] = "Hello!";

    int myarray[] = {3,1,4,1,5,9};
    
    printf("%i\n",myarray[0]);
    printf("%c\n",mychar);
    printf("%s\n",myString);
    printf("The string is located at 0x%lx\n",&myString);
    printf("The array is located at 0x%lx\n",&myarray);



    return 0;

}