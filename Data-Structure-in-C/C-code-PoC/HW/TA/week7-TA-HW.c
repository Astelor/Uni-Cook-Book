#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#define SIZE 100

struct stack{
    int A[SIZE];
    int top;
};
int empty(struct stack *ps); //return 1 is the stack is empty; return 0 otherwise
int full(struct stack *ps); // return 1 if the stack is full; return 0 otherwise
void push(struct stack *ps, int data); //push data onto the stack
int pop(struct stack *ps); //pop the stack and return the popped element

int main(){
    srand(time(NULL));
    int co=10,i,k;
    struct stack element;
    element.top=-1; //initialize stack
    for(i=0;i<co;i++)
        push(&element,rand()%9+1);
    printf("Generated stack:\n");
    for(i=0;i<co-1;i++)
        printf("%d\n",element.A[i]);
    printf("%d <- top\n",element.A[co-1]);

    k=element.A[element.top-1]; printf("Question 1: k = %d\n",k);
    k=element.A[element.top-8]; printf("Question 2: k = %d\n",k);
    k=element.A[0];             printf("Question 3: k = %d\n",k);
    k=element.A[2];             printf("Question 4: k = %d\n",k);

    printf("Question 5:\n%d <- top\n",element.A[co-1]);
    for(i=co-2;i>=0;i--)
        printf("%d\n",element.A[i]);
    return 0;
}

int empty(struct stack *ps){
    return (ps->top==-1); //-1 = empty
}
int full(struct stack *ps){
    return (ps->top==SIZE-1);
}
void push(struct stack *ps, int data){
    if(full(ps)){
        printf("the stack is full! no space to push.\n");
        exit(1);
    }
    ps->A[++(ps->top)]=data;
}
int pop(struct stack *ps){
    if(empty(ps)){
        printf("the stack if empty! nonthing to pop.\n");
        exit(2);
    }
    int temp=ps->A[ps->top];
    ps->A[(ps->top)--]=0;
    return temp;
}