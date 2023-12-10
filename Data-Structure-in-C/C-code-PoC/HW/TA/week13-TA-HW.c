#include <stdio.h>
#include <stdlib.h>
#include <time.h>

// Node structure
typedef struct Node *listPointer;
struct Node {
    int data;
    listPointer next;
};

// Stack structure
struct LinkedListStack {
    listPointer top;
};

// Function to check if the stack is empty
int isEmptyS(struct LinkedListStack* stack) {
    return stack->top == NULL;
}

// Function to push a new element onto the stack
void push(struct LinkedListStack* stack, int data) {
    listPointer new_node = (listPointer)malloc(sizeof(struct Node));
    if (!new_node) {
        printf("Memory allocation failed. Exiting.\n");
        exit(EXIT_FAILURE);
    }
    new_node->data = data;
    new_node->next = stack->top;
    stack->top = new_node;
}

// Function to pop an element from the stack
int pop(struct LinkedListStack* stack) {
    if (isEmptyS(stack)) {
        printf("Stack is empty. Cannot pop.\n");
        exit(EXIT_FAILURE);
    }

    listPointer temp = stack->top;
    int popped_data = temp->data;
    stack->top = temp->next;
    free(temp);
    return popped_data;
}

// Function to display the elements in the stack
void display(struct LinkedListStack* stack) {
    listPointer current = stack->top;
    int spacing=10,a=0;
    printf("top -> ");
    while (current) {
        printf("%3d ", current->data);
        current = current->next;
        if(!((++a)%spacing)){
            printf("\n       ");
        }
    }
    printf("\n");
}

// return the element on the top of a stack
int top(struct LinkedListStack *stack){
    return stack->top->data;
}

// generate a sequence of numbers for stack
void generateNumS(struct LinkedListStack* stack, int count, int min, int max){
    while(!isEmptyS(stack)) pop(stack); //reset
    int i;
    for(i=0;i<count;i++){
        int random_number = rand() % (max-min+1)+min;
        push(stack,random_number);
    }
}
// temp stack for aceessS
struct LinkedListStack temps;
// fetch number within a stack. index counts from 1, indicating the first element
int accessS(struct LinkedListStack *stack, int index, int query_reverse, int query_ditch){
	int i,output;
    while(!isEmptyS(&temps)) pop(&temps); //reset
    index--;
    if(query_reverse){ // counting from the bottom
        while(!isEmptyS(stack))
            push(&temps,pop(stack));
        for(i=0;i<=index;i++)
            push(stack,pop(&temps));
        output=top(stack);
        if(!query_ditch){
            while(!(isEmptyS(&temps))) push(stack,pop(&temps));
        }
    }
    else{ // counting from the top
        for(i=0;i<index;i++)//pop the original one
            push(&temps,pop(stack));
        output=top(stack);
        if(!query_ditch){
            for(i=0;i<index;i++) push(stack,pop(&temps));
        }
    }
    return output;
}

// requirement for the homework, printing out the question itself
char req_questions[4][1000]={
    "1. 指定m 的數值為頂端元素，且不改變堆疊",
    "2. 指定m 的數值為頂端算起的第三元素，且不改變堆疊",
    "3. 指定m 的數值為底端，且不改變堆疊",
    "4. 指定m 的數值為底端算起的第十元素。且不改變堆疊"};

// requirement for the homework, (index, query_reverse, query_ditch)
int req_index[4][10]={
    {1,0,0},
    {3,0,0},
    {1,1,0},
    {10,1,0}};

// requirement for the homework, main function
void req_function(struct LinkedListStack *stack){
    int i;
    for(i=0;i<4;i++){
        generateNumS(stack,30,1,99);
        display(stack);
        printf("%s\n\n",req_questions[i]);
        printf("m = %d\n\n",accessS(stack,req_index[i][0],req_index[i][1],req_index[i][2]));
        display(stack);
        printf("--------------------------------------------------\n");
    }
}

int main() {
    // Create an empty stack
    struct LinkedListStack stack;
    stack.top = NULL;
    srand(time(NULL));
    req_function(&stack);
    return 0;
}
