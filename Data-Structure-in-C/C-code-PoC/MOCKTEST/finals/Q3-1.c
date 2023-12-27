#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#define print_spacing 10
#define stack_size 40
#define max 99
#define min 1
// STACK
// linked queue by linked stack
// hw4-part3

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

// mimic queue structure
// data processing
/* 
 * queue: first in first out, the new data is placed behind rear
 * 1 <- top (rear)
 * 2
 * 3
 * 4
 * 5 <- front
 * 
*/
int isEmptyQueue_Stack(struct Stack* ptr){
    // if the stack itself is empty, the queue must be empty
    return isEmptyStack(ptr);
}

void addQueue_Stack(struct Stack** ptr, int data){
    // the designated rear is the top of a stack
    pushStack(ptr,data);
}

int deleteQueue_Stack(struct Stack** ptr){
    if(isEmptyQueue_Stack(*ptr)){
        printf("Queue underflow\n");
        exit(EXIT_FAILURE);
    }
    struct Stack* temp=createStack();
    int output;
    while(!isEmptyStack(*ptr)){
        // traverse the "stack" until reaching the "front"
        pushStack(&temp,popStack(ptr));
    }
    // now the top is the front, pop it
    output=popStack(&temp);
    while(!isEmptyStack(temp)){
        //place the reversed "stack" back
        pushStack(ptr,popStack(&temp));
    }
    return output;
}

void printQueue_Stack(struct Stack* ptr){
    struct Stack* temp=createStack();
    int count=0;
    while(!isEmptyQueue_Stack(ptr)){
        // traverse the entire stack untill reaching the front
        pushStack(&temp,popStack(&ptr));
    }
    while(!isEmptyQueue_Stack(temp)){
        // printing the reversed "stack" and place it back
        int item=popStack(&temp);
        printf("%2d ", item);
        pushStack(&ptr,item);
        if(++count%print_spacing==0) printf("\n");
    }
}

int frontQueue_Stack(struct Stack* ptr){
    struct Stack* temp=createStack();
    int output;
    while(!isEmptyStack(ptr)){
        // traverse the entire stack untill reaching the front
        pushStack(&temp,popStack(&ptr));
    }
    output=topStack(temp);
    while(!isEmptyStack(temp)){
        // place the stack back
        pushStack(&ptr,popStack(&temp));
    }
    return output;
}


int peekQueue_Stack(struct Stack** ptr, int index, int query_reverse, int query_ditch){
    // use only the functions
    struct Stack* temp=createStack();
    index--;
    int i,output;
    if(!query_reverse){
        //for normal indexing, count down the queue
        for(i=0;i<index;i++){
            addQueue_Stack(&temp, deleteQueue_Stack(ptr));
        }
        output=frontQueue_Stack(*ptr);
        if(!query_ditch){
            // keep traversing untill all the elements are added back
            while(!isEmptyQueue_Stack(*ptr)){
                addQueue_Stack(&temp,deleteQueue_Stack(ptr));
            }
            (*ptr)=temp;
        }
    } else{
        // for the reverse indexing, traverse the entire queue
        int count=0;
        while(!isEmptyQueue_Stack(*ptr)){
            addQueue_Stack(&temp, deleteQueue_Stack(ptr));
            count++;
        } // now we have all the elements in temp
        for(i=0;i<(count-index-1);i++){
            // counting the queue unill we have the desired index in the front
            addQueue_Stack(ptr,deleteQueue_Stack(&temp));
        } 
        output=frontQueue_Stack(temp);
        if(!query_ditch){
            while(!isEmptyQueue_Stack(temp)){
                // add the remaining queue back
                addQueue_Stack(ptr,deleteQueue_Stack(&temp));
            }
        } else{
            // the desired index is the front at temp,
            // the remaining queue should be temp
            *ptr=temp; // comment this line, if the teacher what it the other way around
        }
    }
    return output;
}



char hw_question[6][10000]={
"第一題：指定m 的數值為排頭算起的第三元素。 ",
"第二題：指定m 的數值為排頭算起的第三元素，且不改變佇列。",
"第三題：指定m 的數值為排頭算起的第十二元素。 ",
"第四題：指定m 的數值為排頭算起的第十二元素，且不改變佇列。 ",
"第五題：指定m 的數值為排尾。 ",
"第六題：指定m 的數值為排尾，且不改變佇列。"
};

int hw_data[6][3]={
{3,0,1},
{3,0,0},
{12,0,1},
{12,0,0},
{1,1,1},
{1,1,0}
};
int main(){
    struct Stack* new_heap=createStack();
    int i,m;
    srand(time(NULL));
    for(i=0;i<6;i++){
        newDataStack(&new_heap);
        printf("↓ front\n");
        printQueue_Stack(new_heap);
        m=peekQueue_Stack(&new_heap,hw_data[i][0],hw_data[i][1],hw_data[i][2]);
        printf("%s\nm = %d\n\n",hw_question[i],m);
        printf("↓ front\n");
        printQueue_Stack(new_heap);
        printf("\n---------------------------------------------\n");
    }
    return 0;
}