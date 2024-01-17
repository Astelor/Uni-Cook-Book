#include <stdio.h>
#define SIZE 100

int top=-1;
typedef struct element{
    char par;
    int pos;
};

struct element stack[SIZE];

void push(struct element *data){
    if(full()){
        printf("the stack is full\n");
        exit(1); //exit with 1
    }
    top++;
    stack[top].par=data->par;
    stack[top].pos=data->pos;
}
int full(){
    return (top==SIZE-1);
}
int empty(){
    return (top==-1);
}
struct element *pop(){
    if(empty()){
        printf("the stack is empty");
        exit(2); //exit with 2
    }
    stack[top].par=NULL;
    stack[top].pos=NULL;
    top--;
}
char invert(char c){
    if(c=='(') return ')';
    if(c==')') return '(';
    if(c=='[') return ']';
    if(c==']') return '[';
}

int main(){
    char symb;
    int index=-1;
    struct element input;
    struct element *pt=&input; //a pointer to input so the function can access it
    while((symb=getchar())!=EOF && symb!='\n'){
        if(symb=='(' || symb=='['){
            pt->par=symb;
            pt->pos=++index;
            push(pt);
        }
        else if(symb==')' || symb==']'){
            if(!empty()){
                struct element *k=pop();
                //if()   
            }
        }

    }
}