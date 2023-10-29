#include <stdio.h>

struct trian{
    char name;
    int sides[3];
};
struct trian T[126];
int right(int a,int b, int c){
    if(a*a+b*b==c*c || a*a+c*c==b*b || b*b+c*c==a*a){
        return 1;
    }
    else return 0;
}

int main(){
    char tri=(char)0;
    int index=0;
    for(int a=1;a<6;a++){
        for(int b=1;b<6;b++){
            for(int c=1;c<6;c++){
                T[index].name=tri;
                T[index].sides[0]=a;
                T[index].sides[1]=b;
                T[index].sides[2]=c;
                if(right(a,b,c)){
                    printf("Triangle %c is number %d a right triangle with sides: {%d, %d, %d}\n",tri,index,a,b,c);
                }
                index++; tri++;
            }
        }
    }// I have no idea where malloc should be, doesn't the declaration work as memory allocation?
    return 0;
}