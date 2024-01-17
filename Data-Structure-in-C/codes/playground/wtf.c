#include <stdio.h>
#include <stdlib.h>

// Node structure for the linked list
typedef struct Node* listPointer;
struct Node{
    int data;
    listPointer next;
};

// Queue structure
struct Queue {
    listPointer front;
    listPointer rear;
};

// Function to create a new node
Node* createNode(int data) {
    Node* newNode = (Node*)malloc(sizeof(Node));
    if (newNode == NULL) {
        fprintf(stderr, "Memory allocation failed\n");
        exit(EXIT_FAILURE);
    }
    newNode->data = data;
    newNode->next = NULL;
    return newNode;
}

// Function to initialize a queue
Queue* initializeQueue() {
    Queue* queue = (Queue*)malloc(sizeof(Queue));
    if (queue == NULL) {
        fprintf(stderr, "Memory allocation failed\n");
        exit(EXIT_FAILURE);
    }
    queue->front = queue->rear = NULL;
    return queue;
}

// Function to check if the queue is empty
int isEmpty(Queue* queue) {
    return queue->front == NULL;
}

// Function to enqueue a new element
void enqueue(Queue* queue, int data) {
    Node* newNode = createNode(data);
    if (isEmpty(queue)) {
        queue->front = queue->rear = newNode;
    } else {
        queue->rear->next = newNode;
        queue->rear = newNode;
    }
}

// Function to dequeue an element
int dequeue(Queue* queue) {
    if (isEmpty(queue)) {
        fprintf(stderr, "Queue is empty\n");
        exit(EXIT_FAILURE);
    }
    Node* temp = queue->front;
    int data = temp->data;
    queue->front = temp->next;
    free(temp);
    return data;
}

// Function to display the elements in the queue
void displayQueue(Queue* queue) {
    if (isEmpty(queue)) {
        printf("Queue is empty\n");
        return;
    }
    Node* current = queue->front;
    while (current != NULL) {
        printf("%d ", current->data);
        current = current->next;
    }
    printf("\n");
}

// Function to free the memory used by the queue
void freeQueue(Queue* queue) {
    while (!isEmpty(queue)) {
        dequeue(queue);
    }
    free(queue);
}

int main() {
    Queue* queue = initializeQueue();

    enqueue(queue, 1);
    enqueue(queue, 2);
    enqueue(queue, 3);

    printf("Queue elements: ");
    displayQueue(queue);

    printf("Dequeued element: %d\n", dequeue(queue));

    printf("Queue elements after dequeue: ");
    displayQueue(queue);

    freeQueue(queue);

    return 0;
}
