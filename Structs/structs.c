#include<math.h>
#include<stdio.h>
#include<string.h>

struct point 
{
    double x;
    double y;
};

struct triangle
{
    struct point ptA, ptB, ptC;
};


double distance(struct point ptA, struct point ptB)
{
    double temp1 = (ptA.x - ptB.x);
    double temp2 = (ptA.y - ptB.y);
    temp1 = temp1*temp1;
    temp2 = temp2*temp2;
    double dist = sqrt((temp1 + temp2));
    return dist;
}

double area(struct triangle temptri)
{
    double c = distance(temptri.ptA,temptri.ptB);
    double b = distance(temptri.ptC,temptri.ptA);
    double a = distance(temptri.ptB,temptri.ptC);
    double s = (a+b+c)/2;
    double ans = sqrt(s*(s-a)*(s-b)*(s-c));  //Heron's formula
 
    return ans;
}

void flush(void) { char TEMPCHARBUF; while((TEMPCHARBUF=getchar()) != EOF && TEMPCHARBUF != '\n'); }

int main(void)
{
    struct point pt1 = {3.14, 5.7};
    struct point pt2 = {7, 4.1832};
    struct point pt3 = {-1, 2.5};

    //flush();

    struct triangle mytri = {pt1, pt2, pt3};

    double myarea = area(mytri);

    printf("The triangle struct is at %p\n",&mytri);
    printf("The area of the triangle is %f\n",myarea);
    

    return 0;
}