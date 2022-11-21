#include<stdio.h>
#include<string.h>

void uppercasify(char inputstring[])
{
    int count = 0;
    while(inputstring[count] != '\0')
    {
        if((inputstring[count] >= 0x61) && (inputstring[count] <= 0x7a))
        {
            inputstring[count] = inputstring[count] - 0x20;
        }
        count++;
    }
}

void uppercasify2(char *inputstr)
{
    while(*inputstr != '\0')
        {
            if((*inputstr >= 0x61) && (*inputstr <= 0x7a))
            {
                *inputstr = *inputstr - 0x20;
            }
            inputstr++;
        }
    
}

// package is in mailbox #7
// package *mailboxnumber;
// mailboxnumber = 7;
// *mailboxnumber = your package
// &yourpackage = 7;

int main(void)
{
    char mystring[] = "Hello, world!";

    printf("The string \"%s\" has %i characters\n",mystring,strlen(mystring));
    printf("The string is located at %p\n",mystring);
    uppercasify2(mystring);
    printf("The uppercasified string is \"%s\"\n",mystring);

    return 0;




}