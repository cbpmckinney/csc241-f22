#include<stdio.h>

void flush(void) { char TEMPCHARBUF; while((TEMPCHARBUF=getchar()) != EOF && TEMPCHARBUF != '\n'); }