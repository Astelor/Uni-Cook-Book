#include <stdio.h>

typedef struct human_being {
    char name[12];
    int age;
    float salary;
    union { //the fields share memory
        int children;
        int beard;
    }u; //union name goes ONLY here, for some reason.
};

int main(){
    struct human_being person1, person2;
    long long p1[10]={}, p2[10]={};
    
    p1[0] = &person1; //you can point to the structure itself
    p1[1] = &person1.name;
    p1[2] = &person1.age;
    p1[3] = &person1.salary;
    p1[4] = &person1.u.children;
    p1[5] = &person1.u.beard;
    //what kind of abomination is this.
    p2[0] = &person2;
    p2[1] = &person2.name;
    p2[2] = &person2.age;
    p2[3] = &person2.salary;
    p2[4] = &person2.u.children;
    p2[5] = &person2.u.beard;
    //set a break point and ignore the wint-conversion warning
}