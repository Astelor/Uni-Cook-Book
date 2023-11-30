#include <stdio.h>
#define SIZE 100

struct stack{
	int position[SIZE];
  	char symbol[SIZE];
    int top;
};
typedef struct stack *stackPointer;

int empty(struct stack *ps); //return 1 is the stack is empty; return 0 otherwise
int full(struct stack *ps); // return 1 if the stack is full; return 0 otherwise
void push(struct stack *ps, int pos, char sym); //push data onto the stack
stackPointer pop(struct stack *ps); //pop the stack and return the popped element
stackPointer top(struct stack *ps); //return the top element in the stack

int main(){
	struct stack element = {.position=0, .symbol=0, .top=-1}; //initialize stack
    char c;
    int index=-1;
    while( (c=getchar())!=EOF && c!='\n'){
        index+=1;
        if(c=='(' || c=='[')
            push(&element, index, c);

        else if(c==')' || c==']'){
            if(c==')'){
                if(empty(&element) || top(&element)->symbol!='(')
                    printf("位置編號 %d 的右括弧)沒有可配對的左括弧(\n",index);
                else
                    printf("(%d,%d)\n",pop(&element)->position,index);
            }
            else{
                if(empty(&element) || top(&element)->symbol!='[')
                    printf("位置編號 %d 的右括弧]沒有可配對的左括弧[\n",index);
                else
                    printf("[%d,%d]\n",pop(&element)->position,index);
            }
        }
        else continue;
    }
    while(!empty(&element)){
        if(top(&element)->symbol=='(')
            printf("位置編號 %d 的左括弧(沒有可配對的右括弧)\n",pop(&element)->position);
        else
            printf("位置編號 %d 的左括弧[沒有可配對的右括弧]\n",pop(&element)->position);
    }
	return 0;
}

int empty(struct stack *ps){
	return ( ps->top==-1 );
}
int full(struct stack *ps){
	return ( ps->top==SIZE-1 );
}

void push(struct stack *ps, int pos, char sym){
	if(full(ps)){
		printf("the stack is full! no space to push\n");
		//exit(1);
	}
    ++ps->top;
	ps->position=pos;
    ps->symbol=sym;
}
struct stack output;

stackPointer pop(struct stack *ps){
	if(empty(ps)){
		printf("the stack is empty! nothing to pop\n");
		//exit(2);
	}
    output.position = ps->position;
    output.symbol = ps->symbol;
    ps->position=ps->symbol=0;
    --ps->top;
	return &output; //return the popped element
}
stackPointer top(struct stack *ps){
    if(empty(ps)){
        printf("the stack is empty!\n");
        //exit(3);
    }
    output.position=ps->position;
    output.symbol=ps->symbol;
    return &output;
}