#include<stdio.h>
#include<string.h>

int main(void){

int a = 6;
int b = 9;

if((a<5) || (!(b > 7))){
    printf("a is less than five!\n");
}
else{
    printf("a is not less than five!\n");
}


for(int i = 1; i>5; i++){
    printf("%i\n",i);
}
int sum = 0;
for(int i = 5; i<10; i++)
{
    sum += i;
}


return 0;

}