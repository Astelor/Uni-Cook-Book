#include <stdio.h>
#include <stdlib.h>
#include <time.h>

// Node structure
typedef struct Node *listPointer;
struct Node {
    int data;
    listPointer next;
};

/// Circular Queue structure
struct CircularQueue {
    listPointer front;
    listPointer rear;
};

// Function to initialize an empty circular queue
void initializeQueue(struct CircularQueue* queue) {
    queue->front = NULL;
    queue->rear = NULL;
}

// Function to check if the circular queue is empty
int isEmptyQ(struct CircularQueue* queue) {
    return queue->front == NULL;
}
// temp queue for aceessQ
struct CircularQueue tempq;

// Function to enqueue (insert) an element into the circular queue
void enqueue(struct CircularQueue* queue, int data) {
    listPointer new_node = (listPointer)malloc(sizeof(struct Node));
    if (!new_node) {
        printf("Memory allocation failed. Exiting.\n");
        exit(EXIT_FAILURE);
    }

    new_node->data = data;
    new_node->next = NULL;

    if (isEmptyQ(queue)) {
        queue->front = new_node;
        queue->rear = new_node;
    } else {
        queue->rear->next = new_node;
        queue->rear = new_node;
    }
    queue->rear->next = queue->front;
}

// Function to dequeue (remove) an element from the circular queue
int dequeue(struct CircularQueue* queue) {
    if (isEmptyQ(queue)) {
        printf("Queue is empty. Cannot dequeue.\n");
        exit(EXIT_FAILURE);
    }
    int dequeued_data = queue->front->data;
    listPointer temp = queue->front;
    queue->front = queue->front->next;
    free(temp);
    if (isEmptyQ(queue)){
        queue->rear = NULL;
        queue->front = NULL;
    }else
        queue->rear->next = queue->front;
    return dequeued_data;
}

// Function to display the elements in the circular queue
void display(struct CircularQueue* queue) {
    int spacing=10,a=0;
    if (isEmptyQ(queue)) {
        printf("Queue is empty.\n");
        return;
    }
    listPointer current = queue->front;
    printf("front -> ");
    do {
        printf("%3d ", current->data);
        current = current->next;
        if(!((++a)%spacing)){
            printf("\n         ");
        }
    } while (current != queue->front);
    printf("\n");
}

int top(struct CircularQueue* queue){
    return queue->front->data;
}

// generate a sequence of numbers for queue
void generateNumQ(struct CircularQueue* queue, int count, int min, int max){
    while(!isEmptyQ(queue)) dequeue(queue); //reset
    initializeQueue(queue);
    srand(time(NULL));
    int i;
    for(i=0;i<count;i++){
        int random_number = rand() % (max-min+1)+min;
        enqueue(queue,random_number);
    }
}
// fetch number within a queue. index counts from 1, indicating the first element
int accessQ(struct CircularQueue * queue, int index, int query_reverse, int query_ditch){
	int i,output;
    while(!isEmptyQ(&tempq)) dequeue(&tempq); //reset
    //initializeQueue(&tempq);
    index--;
    if(query_reverse){ // counting from the bottom
        while(!isEmptyQ(queue))
            enqueue(&tempq,dequeue(queue));
        for(i=0;i<=index;i++)
            enqueue(queue,dequeue(&tempq));
        output=top(queue);
        printf("proc: %d\n",output);
        if(!query_ditch){
            while(!(isEmptyQ(&tempq))) enqueue(queue,dequeue(&tempq));
        }
    }
    else{ // counting from the top
        for(i=0;i<index;i++){//dequeue the original one
            enqueue(&tempq,dequeue(queue));
        }
        output=top(queue);
        if(!query_ditch){
            //if(!isEmptyQ(queue)) // Check if the queue is not empty
                enqueue(&tempq, dequeue(queue));
                enqueue(&tempq, dequeue(queue));
                enqueue(&tempq, dequeue(queue));
                
            
        }
    }
    return output;
}
/*
// requirement for the homework, printing out the question itself
char req_questions[4][1000]={
    "1. 指定m 的數值為頂端元素，且不改變堆疊",
    "2. 指定m 的數值為頂端算起的第三元素，且不改變堆疊",
    "3. 指定m 的數值為底端，且不改變堆疊",
    "4. 指定m 的數值為底端算起的第十元素。且不改變堆疊"};

// requirement for the homework, (index, query_reverse, query_ditch)
int req_index[4][10]={
    {1,1,0},
    {3,1,0},
    {1,0,0},
    {10,0,0}};

// requirement for the homework, main function
void req_function(struct CircularQueue *queue){
    int i;
    for(i=0;i<4;i++){
        generateNumQ(queue,30,1,99);
        display(queue);
        printf("%s\n\n",req_questions[i]);
        printf("m = %d\n\n",accessQ(queue,req_index[i][0],req_index[i][1],req_index[i][2]));
        display(queue);
        printf("--------------------------------------------------\n");
    }
}*/

int main() {
    // Create an empty queue
    struct CircularQueue queue;
    initializeQueue(&queue);
    initializeQueue(&tempq);
    //req_function(&queue);
    int i=0;
    generateNumQ(&queue,5,1,99);
    display(&queue);
    //printf("m = %d\n\n",accessQ(&queue,5,0,0));
    //display(&queue);*/
    int testpoint=top(&queue);
    int testopint2=accessQ(&queue,2,0,0);
    display(&tempq);
    display(&queue);
    return 0;
}
