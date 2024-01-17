#include <stdio.h>

int main(){
    struct{
        int f1,f2,f3;
    }test1;

    struct{
        double f1; //it will align to the largest data type
        char c;
        int f2;
    }test2;
    struct{
        char c;
        double d;
        float f;
    }test3;
    struct{
        char a;
        float f;
        double d;
    }test4;
    printf("%d\n",sizeof(test3));
}