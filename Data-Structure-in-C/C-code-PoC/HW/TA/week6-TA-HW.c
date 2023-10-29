// [REDACTED]
#include <stdio.h>
#define SIZE 100
int A[SIZE];
int top =-1;
int empty(); // return 1 if the stack is empty; return 0 otherwise
int full(); // return 1 if the stack is full; return 0 otherwise
void push(int data); // push data onto the stack
int pop(); // pop the stack and return the popped element
int main(){
    int k=3, i;
    push(k);push(k);
    for(i=0;i<5;i++)
        push(0);
    push(k);push(0);

    for(i=top;i>=0;i--)
        printf("%d ",A[i]);
    printf("\nthe index:\n");
    for(i=1;i<=9;i++)
        printf("%d ",i);
    return 0;
}
int empty(){
    if(top<0) return 1;
    else return 0;
}
int full(){
    if (top==SIZE-1) return 1;
    else return 0;
}
void push(int data){
    A[++top]=data;
}
int pop(){
    return A[top--];
}