#include <stdio.h>

struct stint{   //12
    char tt;
    int f1,f2,f3;
}test1;
struct stfloat{ //24
    float f4;   //8
    char c2;
    double f5;  //8
}test2;
struct sam{
    double f8;  //8
    char c1;    //4
    float f6;   //4
    union{      //24>12
        struct stint f11;
        struct stfloat f12;
    }f13;
};
struct sam s[100];

int main(){
    int one=sizeof(test1),
        two=sizeof(test2),
        yyy=sizeof(s[0].f13);

    return 0;
}