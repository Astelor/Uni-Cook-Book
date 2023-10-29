#include <stdio.h>

int main(){
    struct stint{   //12
        int f1,f2,f3;
    };
    struct stfloat{ //24
        float f4;   //8
        double f5;  //8
        char c2;    //8
    };
    struct sam{
        double f8;  //8
        char c1;
        float f6;   
        union{      
            struct stint f11;
            struct stfloat f12;
        }f13;
    };
    struct sam s[100];
}