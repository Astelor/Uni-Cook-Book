#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#define print_spacing 10
#define queue_size 50
#define max 99
#define min 1
// queue

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

int peekQueue(struct Queue** ptr, int index, int query_reverse, int query_ditch){
    // use only the functions
    struct Queue* temp=createQueue();
    index--;
    int i,output;
    if(!query_reverse){
        //for normal indexing, count down the queue
        for(i=0;i<index;i++){
            addQueue(&temp, deleteQueue(ptr));
        }
        output=frontQueue(*ptr);
        if(!query_ditch){
            // keep traversing untill all the elements are added back
            while(!isEmptyQueue(*ptr)){
                addQueue(&temp,deleteQueue(ptr));
            }
            (*ptr)=temp;
        }
    } else{
        // for the reverse indexing, traverse the entire queue
        int count=0;
        while(!isEmptyQueue(*ptr)){
            addQueue(&temp, deleteQueue(ptr));
            count++;
        } // now we have all the elements in temp
        for(i=0;i<(count-index-1);i++){
            // counting the queue unill we have the desired index in the front
            addQueue(ptr,deleteQueue(&temp));
        } 
        output=frontQueue(temp);
        if(!query_ditch){
            while(!isEmptyQueue(temp)){
                // add the remaining queue back
                addQueue(ptr,deleteQueue(&temp));
            }
        } else{
            // the desired index is the front at temp,
            // the remaining queue should be temp
            *ptr=temp;
        }
    }
    return output;
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
        addQueue(ptr,random_number);
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

char hw_question[6][10000]={
"第一題：指定m 的數值為排尾算起的第二元素。",
"第二題：指定m 的數值為排尾算起的第二元素，且不改變佇列。",
"第三題：指定m 的數值為排尾算起的第三元素。",
"第四題：指定m 的數值為排尾算起的第三元素，且不改變佇列。",
"第五題：指定m 的數值為排尾算起的第四元素。",
"第六題：指定m 的數值為排尾算起的第四元素，且不改變佇列。"
};

int hw_data[6][3]={
{2,1,1},
{2,1,0},
{3,1,1},
{3,1,0},
{4,1,1},
{4,1,0}
};
int main(){
    struct Queue* new_heap=createQueue();
    int i,m;
    srand(time(NULL));
    for(i=0;i<6;i++){
        newDataQueue(&new_heap);
        printf("↓ front\n");
        printQueue(new_heap);
        m=peekQueue(&new_heap,hw_data[i][0],hw_data[i][1],hw_data[i][2]);
        printf("%s\nm = %d\n",hw_question[i],m);
        printf("↓ front\n");
        printQueue(new_heap);
        printf("\n\n");
    }
    return 0;
}
