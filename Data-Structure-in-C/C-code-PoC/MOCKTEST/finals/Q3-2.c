
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#define print_spacing 10
#define queue_size 50
#define max 99
#define min 1
// queue
// linked stack by linke queue
// okay wtf?
// base is from hw4-part2
// peek is from hw4-part1-2

struct Node{
    int data;
    struct Node* next;
};
struct Queue{
    struct Node* front;
    struct Node* rear;
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

// base Queue functions-----------------------------------------------------------------|
struct Queue* createQueue(){
    struct Queue* newQueue=(struct Queue*)malloc(sizeof(struct Queue));
    if(newQueue==NULL){
         printf("Memory allocation failed\n");
        exit(EXIT_FAILURE);
    }
    newQueue->front = newQueue->rear = NULL;
    return newQueue;
}

int isEmptyQueue(struct Queue* ptr){
    return (ptr->front==NULL);
}

void addQueue(struct Queue** ptr, int data){
    struct Node* newNode= createNode(data);
    if(isEmptyQueue(*ptr)){
        (*ptr)->front=(*ptr)->rear=newNode;
    }else{
        (*ptr)->rear->next= newNode;
        (*ptr)->rear = newNode;
    }
}

int deleteQueue(struct Queue** ptr){
    if(isEmptyQueue(*ptr)){
        printf("Queue underflow\n");
        exit(EXIT_FAILURE);
    }
    struct Node* temp = (*ptr)->front;
    int output=temp->data;
    (*ptr)->front = temp->next;
    free(temp);
    if((*ptr)->front==NULL){
        (*ptr)->rear = NULL;
    }
    return output;
}

int frontQueue(struct Queue* ptr){
    return ptr->front->data;
}

void freeQueue(struct Queue** ptr){
    while(!isEmptyQueue(*ptr)){
        deleteQueue(ptr);
    }
}

void newDataQueue(struct Queue** ptr){
    freeQueue(ptr);
    *ptr=createQueue();
    int i;
    for(i=0;i<queue_size;i++){
        int random_number=rand()%(max-min+1)+min;
        addQueue(ptr, random_number);        // debug here!
    }
}

void printQueue(struct Queue* ptr){
    struct Node* temp=ptr->front;
    int count=0;
    while(temp!=NULL){
        printf("%2d ", temp->data);
        temp=temp->next;
        if(++count%print_spacing==0) printf("\n");
    }
    printf("\n");
}

// mimic stack structure ---------------------------------------------------------------|
// data processing
// okay this is annoying, why make the top front?????
/* queue: first in first out, the new data is placed at rear
 * stack: first in last out, the new data is place at top
 * 1 <- front (top)
 * 2
 * 3
 * 4
 * 5 rear
*/
int isEmptyStack_Q(struct Queue* ptr){
    return isEmptyQueue(ptr);
}

void pushStack_Q(struct Queue** ptr, int data){
    // the data should be placed at front of queue (the top for stack)
    // create another queue, place the data in, empty ptr innit, make ptr temp 
    struct Queue* temp=createQueue();
    addQueue(&temp,data);
    while(!isEmptyQueue(*ptr)){
        addQueue(&temp,deleteQueue(ptr));
    }
    *ptr=temp;
}
int popStack_Q(struct Queue** ptr){
    // the data at the front will be deleted
    return deleteQueue(ptr);
}

void printStack_Q(struct Queue* ptr){
    // the order is exactly the same, we can just call queue's function here
    printQueue(ptr);
}
int topStack_Q(struct Queue* ptr){
    // the order is the same
    return frontQueue(ptr);
}

// peeking function from hw4-part1-2
int peekStack_Q(struct Queue** ptr, int index, int query_reverse, int query_ditch){
    // use only the functions
    struct Queue* temp=createQueue();
    index--; // counting from 1
    int i,output;
    if(!query_reverse){
        // for the normal indexing, count down the stack
        for(i=0;i<index;i++){
            pushStack_Q(&temp,popStack_Q(ptr));
        }
        output=topStack_Q(*ptr);
        if(!query_ditch){
            // place the popped items back
            while(!isEmptyStack_Q(*ptr)){
                pushStack_Q(&temp,popStack_Q(ptr));
            }
            while(!isEmptyStack_Q(temp)){
                pushStack_Q(ptr,popStack_Q(&temp));
            }
        } /*else{// if not placing the items back, just leave it as it is.
            // freeStack(popped_items) // clear the stack
            // popped_items=createStack() //initialize the stack again
            // popped_items=temp; // asign the address to it
            // freeStack(&temp);
        }*/
    } else{
        // for the reverse indexing, traverse the entire stack
        while(!isEmptyStack_Q(*ptr)){
            pushStack_Q(&temp,popStack_Q(ptr));
        }
        for(i=0;i<=index;i++){
            pushStack_Q(ptr,popStack_Q(&temp));
        }
        output=topStack_Q(*ptr);
        if(!query_ditch){
            while(!isEmptyQueue(temp)){
                pushStack_Q(ptr,popStack_Q(&temp));
            }
        }/*else{

        }*/
    }
    return output;
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
{12,0,0},
{1,1,0},
{2,1,0},
{3,1,0},
{4,1,0}
};

int main(){
    // if the stack is empty, top will point to NULL
    struct Queue* new_heap=createQueue();
    int i,m;
    srand(time(NULL));
    printStack_Q(new_heap);
    for(i=0;i<6;i++){
        newDataQueue(&new_heap); // create a new queue
        
        printf("↓ top\n");       // print the created new queue
        printStack_Q(new_heap);

        m=peekStack_Q(&new_heap,hw_data[i][0],hw_data[i][1],hw_data[i][2]);
        printf("%s\nm = %d\n",hw_question[i],m); // print the question
        
        printf("↓ top\n");
        printStack_Q(new_heap);
        
        printf("----------------------------------\n\n");
    }
    return 0;
    
}
