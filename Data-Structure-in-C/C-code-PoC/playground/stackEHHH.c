#include <stdio.h>
#define SIZE 100

struct stack{
	int A[SIZE];
  	int top;
};

int access(struct stack *ps, struct stack *temps, int index);// counting from 0
int empty(struct stack *ps); //return 1 is the stack is empty; return 0 otherwise
int full(struct stack *ps); // return 1 if the stack is full; return 0 otherwise
void push(struct stack *ps, int data); //push data onto the stack
int pop(struct stack *ps); //pop the stack and return the popped element
int top(struct stack *ps); //return the top element in the stack


int main(){
    struct stack element={.A=0, .top=-1};
    struct stack temp={.A=0, .top=-1};
    //let's say if we want to access the third element from the top
    //the index will be 2 (counting from 0)
    int i;
    for(i=1;i<11;i++)
        push(&element,i);
    for(i=0;i<10;i++)
        printf("%d ",element.A[i]);
	int acc=access(&element,&temp,2);
	printf("\n");
	for(i=0;i<10;i++)
        printf("%d ",element.A[i]);
	return 0;
}

int access(struct stack *ps, struct stack *temps, int index){
	int i,output;
	for(i=0;i<index;i++)//pop the original one
		push(temps,pop(ps));
	output=top(ps);
    for(i=0;i<index;i++)
        push(ps,pop(temps));
    return output;
}
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
	return temp;
}
int top(struct stack *ps){
	return (ps->A[ps->top]);
}