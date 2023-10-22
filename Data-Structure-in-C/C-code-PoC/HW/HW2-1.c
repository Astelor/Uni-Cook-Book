#include <stdio.h>
#define SIZE 100

int stack[SIZE];
int top=-1;
int empty(); // return 1 if the stack is empty; return 0 otherwise
void push(int data); // push data onto the stack
int pop(); // pop the stack and return the popped element
int stack_top();

int main(){
    char c;
    int index=-1;
    while((c=getchar())!=EOF && c!='\n'){
        index+=1;
        if(c=='(')
            push(index);
        else if(c==')'){
            if(empty())
                printf("位置編號 %d 的右括弧沒有可配對的左括弧\n",index);
            else
                printf("(%d,%d)\n",pop(),index);
        }
        else
            continue;
    }
    while(!empty())
        printf("位置編號 %d 的左括弧沒有可配對的右括弧\n",pop());
    return 0;
}

int empty(){
    if(top<0) return 1;
    else return 0;
}
void push(int data){
    stack[++top]=data;
}
int pop(){
    int temp=stack[top];
    stack[top--]=0;
    return temp;
}
int stack_top(){
    return stack[top];
}