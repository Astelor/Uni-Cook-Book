#include <stdio.h>
#include <stdlib.h>
// a copypase from week12-TA-HW.c because I don't really wanna write it again
// a parenthesis checker using linked list
typedef struct listNode *listPointer;
struct listNode{ //16 bytes
    int position;
    char symbol;
    listPointer link;
};

// Stack structure
struct LinkedListStack {
    listPointer top;
}; // 411440117 Aster Chen

// Function to check if the stack is empty
int empty(struct LinkedListStack* stack) {
    return stack->top == NULL;
}

// Function to push a new element onto the stack
void push(struct LinkedListStack* stack, int pos, int sym) {
    listPointer new_node = (listPointer)malloc(sizeof(struct listNode));
    if (!new_node) {
        printf("Memory allocation failed. Exiting.\n");
        exit(EXIT_FAILURE);
    }
    // [newNode] -> [top] -> [] -> []
    // [new top] -> [] -> [] -> []
    new_node->position = pos;
    new_node->symbol   = sym;
    new_node->link = stack->top;
    stack->top = new_node;
}

struct listNode output;
// Function to pop an element from the stack
listPointer pop(struct LinkedListStack* stack) {
    if (empty(stack)) {
        printf("Stack is empty. Cannot pop.\n");
        exit(EXIT_FAILURE);
    }
    listPointer temp = stack->top;
    output.position = temp->position;
    output.symbol   = temp->symbol;
    stack->top = temp->link;
    free(temp);
    return &output;
}// 411440117 Aster Chen

listPointer top(struct LinkedListStack* stack){
    if (empty(stack)) {
        printf("Stack is empty. Cannot pop.\n");
        exit(EXIT_FAILURE);
    }
    output.position = stack->top->position;
    output.symbol   = stack->top->symbol;
    return &output;
}

int main(){
    char input;
    struct LinkedListStack element = {.top=NULL}; //initialize node
	//struct stack element = {.position=0, .symbol=0, .top=-1}; //initialize stack
    char c;
    int index=-1;
    while( (c=getchar())!=EOF && c!='\n'){
        index+=1;
        if(c=='(' || c=='[')
            push(&element, index, c);

        else if(c==')' || c==']'){
            if(c==')'){
                if(empty(&element) || top(&element)->symbol!='('){
                    printf("��m�s�� %d ���k�A��)�S���i�t�諸���A��(\n",index);
                    pop(&element); //why?? just why???
                }
                else
                    printf("(%d,%d)\n",pop(&element)->position,index);
            }
            else{
                if(empty(&element) || top(&element)->symbol!='['){
                    printf("��m�s�� %d ���k�A��]�S���i�t�諸���A��[\n",index);
                    pop(&element);
                }
                else
                    printf("[%d,%d]\n",pop(&element)->position,index);
            }
        }
        else continue;
    }
    while(!empty(&element)){
        if(top(&element)->symbol=='(')
            printf("��m�s�� %d �����A��(�S���i�t�諸�k�A��)\n",pop(&element)->position);
        else
            printf("��m�s�� %d �����A��[�S���i�t�諸�k�A��]\n",pop(&element)->position);
    }
	return 0;// 411440117 Aster Chen
}
    
