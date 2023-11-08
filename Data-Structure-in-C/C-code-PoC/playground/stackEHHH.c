#include <stdio.h>
#define SIZE 100

struct stack{
	int A[SIZE];
  	int top;
};

int access(struct stack *ps, struct stack *temps, int index);// counting from 0
int emptys(struct stack *ps); //return 1 is the stack is empty; return 0 otherwise
int fulls(struct stack *ps); // return 1 if the stack is full; return 0 otherwise
void pushs(struct stack *ps, int data); //push data onto the stack
int pops(struct stack *ps); //pop the stack and return the popped element
int tops(struct stack *ps); //return the top element in the stack
int prints(struct stack *ps); // print the stack

int main(){
    struct stack element={.A=0, .top=-1};
    struct stack temp={.A=0, .top=-1};
    //let's say if we want to access the third element from the top
    //the index will be 2 (counting from 0)
    int i;
    for(i=1;i<11;i++)
        pushs(&element,i);
    for(i=0;i<10;i++)
        printf("%d ",element.A[i]);
	int acc=access(&element,&temp,2);
	printf("\n");
	prints(&element);
	return 0;
}

int access(struct stack *ps, struct stack *temps, int index){
	int i,output;
	for(i=0;i<index;i++)//pop the original one
		pushs(temps,pops(ps));
	output=tops(ps);
    for(i=0;i<index;i++)
        pushs(ps,pops(temps));
    return output;
}
int emptys(struct stack *ps){
	return ( ps->top==-1 );
}
int fulls(struct stack *ps){
	return ( ps->top==SIZE-1 );
}
void pushs(struct stack *ps, int data){
	if(fulls(ps)){
		printf("Stack is full!\n");
	}
	else ps->A[++(ps->top)]=data;
}
int pops(struct stack *ps){
	if(emptys(ps)){
		printf("the stack is empty\n");
		return -1;
	}
	int temp=ps->A[ps->top];
	ps->A[(ps->top)--]=0;
	return temp;
}
int tops(struct stack *ps){
	return (ps->A[ps->top]);
}
int prints(struct stack *ps){
    int i;
    if(emptys(ps))
        printf("Empty Stack\n");
    else{
        printf("Top -> %d ", ps->A[ps->top]);
        for(i=ps->top-1;i>=0;i--)
            printf("%d ",ps->A[i]);
		printf("\n");
    }
}