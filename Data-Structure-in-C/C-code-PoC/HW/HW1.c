#include <stdio.h>

struct stint{//4*12
    int f1,f2,f3;
}stint_test;
struct stfloat{ //4+(4)+8=16
    float f4;
    double f5;
}stfloat_test;
struct sam {//[1+(3)+4+4+(4)+8]+16=[24]+16=40
    char utype;
    float f6, f7;
    double f8;
    union{
        struct stint f11;
        struct stfloat f12;
        
    }f13;
};
struct sam s[100];
int main(){
    //results
    int sam_size=sizeof(s[0]), 
        stint_size=sizeof(stint_test), 
        stfloat_size=sizeof(stfloat_test), 
        sam_union_size=sizeof(s[0].f13),
        q1=sizeof(s[27].utype),
        q2=sizeof(s[23].f6),
        q3=sizeof(s[18].f8),
        q4=sizeof(s[37].f13.f11.f3),
        q5=sizeof(s[37].f13.f12.f5);
    
    return 0;
}