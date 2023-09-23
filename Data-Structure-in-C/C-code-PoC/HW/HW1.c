#include <stdio.h>

struct stint {
    int f1,f2,f3,test1,test2; //alignment
};
struct stfloat{
    double f4;
    double f5;
};
struct sam{
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
    long long base=&s[0];
    printf("base: %p\n",&s[0]);
    printf("(1)   %p\n",&s[27].utype);//,&s[27].utype-base);
    printf("(2)   %p\n",&s[23].f6);//,&s[23].f6-base);
    printf("(3)   %p\n",&s[18].f8);//,&s[18].f8-base);
    printf("(4)   %p\n",&s[37].f13.f11.f3);//,&s[37].f13.f11.f3-base);
    printf("(5)   %p\n\n",&s[37].f13.f12.f5);//,&s[37].f13.f12.f5-base);

    printf("(1) size: %d\n",sizeof(s[27].utype));
    printf("(2) size: %d\n",sizeof(s[23].f6));
    printf("(3) size: %d\n",sizeof(s[18].f8));
    printf("(4) size: %d\n",sizeof(s[37].f13));
    printf("(5) size: %d\n",sizeof(s[37].f13.f12.f5));
    return 0;
}