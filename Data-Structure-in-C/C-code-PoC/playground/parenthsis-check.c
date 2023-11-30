#include <stdio.h>
#define SIZE 100

struct stack{
	int A[SIZE];//pt.A[index][0]=position [index][1]=parenthesis type
  	int top;
};

int empty(struct stack *ps); //return 1 is the stack is empty; return 0 otherwise
int full(struct stack *ps); // return 1 if the stack is full; return 0 otherwise
void push(struct stack *ps, int data); //push data onto the stack
int pop(struct stack *ps); //pop the stack and return the popped element
int top(struct stack *ps); //return the top element in the stack

int main(){
	struct stack element = {.A=0, .top=-1}; //initialize stack
    struct stack parent = { .A=0, .top=-1}; //for parenthisis type 
    char c; // (->1 [->2
    int index=-1;
    while( (c=getchar())!=EOF && c!='\n'){
        index+=1;
        if(c=='(' || c=='['){
            push(&element, index);
            if(c=='(')
                push(&parent, 1);
            else 
                push(&parent, 2);
        }
        else if(c==')' || c==']'){
            if(c==')'){
                if(empty(&element) || top(&parent)!=1)
                    printf("位置編號 %d 的右括弧)沒有可配對的左括弧(\n",index);
                else{
                    printf("(%d,%d)\n",pop(&element),index);
                    pop(&parent);
                }
            }
            else{
                if(empty(&element) || top(&parent)!=2)
                    printf("位置編號 %d 的右括弧]沒有可配對的左括弧[\n",index);
                else{
                    printf("[%d,%d]\n",pop(&element),index);
                    pop(&parent);
                }
            }
        }
        else continue;
    }
    while(!empty(&element)){
        if(top(&parent)==1)
            printf("位置編號 %d 的左括弧(沒有可配對的右括弧)\n",pop(&element));
        else
            printf("位置編號 %d 的左括弧[沒有可配對的右括弧]\n",pop(&element));
        pop(&parent);
    }
	return 0;
}
/*
int main(){
    char c;
    int index=-1;
    while((c=getchar())!=EOF && c!='\n'){
        index+=1;
        if(c=='(')
            push(index);
        else if(c=='[')
            push(index+1000);
        else if(c==')'){
            if(empty())
                printf("位置編號 %d 的右括弧)沒有可配對的左括弧(\n",index);
            else{
                if(stack_top()>=1000)
                    printf("位置編號 %d 的右括弧)沒有可配對的左括弧(\n",index);
                else
                    printf("(%d,%d)\n",pop(),index);
            }
        }
        else if(c==']'){
            if(empty())
                printf("位置編號 %d 的右括弧]沒有可配對的左括弧[\n",index);
            else{
                if(stack_top()<1000)
                    printf("位置編號 %d 的右括弧]沒有可配對的左括弧[\n",index);
                else
                    printf("[%d,%d]\n",pop()-1000,index);
            }
        }
        else
            continue;
    }
    while(!empty()){
        if(stack_top()>=1000)
            printf("位置編號 %d 的左括弧[沒有可配對的右括弧]\n",pop()-1000);
        else
            printf("位置編號 %d 的左括弧(沒有可配對的右括弧)\n",pop());
    }
    return 0;
}
*/

int empty(struct stack *ps){
	return ( ps->top==-1 );
}
int full(struct stack *ps){
	return ( ps->top==SIZE-1 );
}
void push(struct stack *ps, int data){
	if(full(ps)){
		printf("the stack is full! no space to push\n");
		//exit(1);
	}
	ps->A[++(ps->top)]=data;
}
int pop(struct stack *ps){
	if(empty(ps)){
		printf("the stack is empty! nothing to pop\n");
		//exit(2);
	}
	int temp=ps->A[ps->top];
	ps->A[(ps->top)--]=0;
	return temp; //return the popped element
}
int top(struct stack *ps){
    if(empty(ps)){
        printf("the stack is empty!\n");
        //exit(3);
    }
	return (ps->A[ps->top]);
}