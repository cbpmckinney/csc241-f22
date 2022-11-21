#include<stdio.h>
#include<string.h>

int main(void){

/*
int is a 32 bit signed integer
long int is a 64 bit integer
short is a 16 bit integer
char is an 8 bit integer
float is a 32 bit floating point number
double is a 64 bit floating point number
*/


    int a = 274;
    int new = 5;
    float b = 3.5;

    float c = a+b;
    double bigfloat = 7.9;

    printf("The number is %f\n",c);

    return 0;
}