#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#define print_spacing 10
#define stack_size 15
#define max 99
#define min 1
// STACK

struct Node{
    int data;
    struct Node* next;
};
struct Stack{
    struct Node* top;
};

// function to create a new node with data
struct Node* createNode(int data){
    struct Node* newNode=(struct Node*)malloc(sizeof(struct Node));
    if(newNode==NULL){
        printf("Memory allocation failed\n");
        exit(EXIT_FAILURE);
    }
    newNode->data = data;
    newNode->next = NULL;
    return newNode;
}

struct Stack* createStack(){
    struct Stack* newStack = (struct Stack*)malloc(sizeof(struct Stack));
    if(newStack==NULL){
        printf("Memory allocation failed\n");
        exit(EXIT_FAILURE);
    }
    newStack->top=NULL;
    return newStack;
}

int isEmptyStack(struct Stack* ptr){
    return (ptr->top==NULL);
}
void pushStack(struct Stack** ptr, int data){
    struct Node* newNode=createNode(data);
    newNode->next= (*ptr)->top;
    (*ptr)->top = newNode;
}

int popStack(struct Stack** ptr){
    int temp=(*ptr)->top->data;
    struct Node* tempS;
    tempS = (*ptr)->top;
    (*ptr)->top = tempS->next;
    free(tempS);
    return temp;
}

int topStack(struct Stack* ptr){
    return ptr->top->data;
}

//struct Stack* popped_items;

int peekStack(struct Stack** ptr, int index, int query_reverse, int query_ditch){
    // use only the functions
    struct Stack* temp=createStack();
    index--; // counting from 1
    int i,output;
    if(!query_reverse){
        // for the normal indexing, count down the stack
        for(i=0;i<index;i++){
            pushStack(&temp,popStack(ptr));
        }
        output=topStack(*ptr);
        if(!query_ditch){
            // place the popped items back
            while(!isEmptyStack(*ptr)){
                pushStack(&temp,popStack(ptr));
            }
            while(!isEmptyStack(temp)){
                pushStack(ptr,popStack(&temp));
            }
        } /*else{// if not placing the items back, just leave it as it is.
            // freeStack(popped_items) // clear the stack
            // popped_items=createStack() //initialize the stack again
            // popped_items=temp; // asign the address to it
            // freeStack(&temp);
        }*/
    } else{
        // for the reverse indexing, traverse the entire stack
        while(!isEmptyStack(*ptr)){
            pushStack(&temp,popStack(ptr));
        }
        for(i=0;i<=index;i++){
            pushStack(ptr,popStack(&temp));
        }
        output=topStack(*ptr);
        if(!query_ditch){
            while(!isEmptyStack(temp)){
                pushStack(ptr,popStack(&temp));
            }
        }/*else{

        }*/
    }
    return output;
}

void freeStack(struct Stack** ptr){
    while(!isEmptyStack(*ptr)){
        popStack(ptr);
    }
}

void newDataStack(struct Stack** ptr){
    freeStack(ptr);
    *ptr=createStack();
    int i;
    for(i=0;i<stack_size;i++){
        int random_number=rand()%(max-min+1)+min;
        pushStack(ptr,/*random_number*/i+1);
    }
}

void printStack(struct Stack* ptr){
    struct Node* temp;
    int count=0;
    temp=ptr->top;
    while( temp!=NULL){
        printf("%2d ", temp->data);
        temp=temp->next;
        if(++count%print_spacing==0) printf("\n");
    }
    printf("\n");
}

char hw_question[6][10000]={
"第一題：指定m 的數值為頂端算起的第三元素，且不改變堆疊。",
"第二題：指定m 的數值為頂端算起的第十二元素，且不改變堆疊。", 
"第三題：指定m 的數值為底端，且不改變堆疊。  ",
"第四題：指定m 的數值為底端算起的第二元素，且不改變堆疊。 ",
"第五題：指定m 的數值為底端算起的第三元素，且不改變堆疊。 ",
"第六題：指定m 的數值為底端算起的第四元素，且不改變堆疊。"
};

int hw_data[6][3]={
{3,0,0},
{10,0,0},
{1,1,0},
{2,1,0},
{3,1,0},
{4,1,0}
};

int main(){
    // if the stack is empty, top will point to NULL
    struct Stack* new_heap=createStack();
    int i,m;
    srand(time(NULL));
    printStack(new_heap);
    for(i=0;i<6;i++){
        newDataStack(&new_heap);
        printf("↓ top\n");
        printStack(new_heap);
        m=peekStack(&new_heap,hw_data[i][0],hw_data[i][1],hw_data[i][2]);
        printf("%s\nm = %d\n",hw_question[i],m);
        printf("↓ top\n");
        printStack(new_heap);
        printf("\n\n");
    }
    return 0;

}