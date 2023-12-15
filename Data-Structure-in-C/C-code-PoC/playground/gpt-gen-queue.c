#include <stdio.h>
#include <stdlib.h>

// Node structure
struct Node {
    int data;
    struct Node* next;
};

// Circular Queue structure
struct CircularQueue {
    struct Node* front;
    struct Node* rear;
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

// Function to enqueue (insert) an element into the circular queue
void enqueue(struct CircularQueue* queue, int data) {
    struct Node* new_node = (struct Node*)malloc(sizeof(struct Node));
    if (!new_node) {
        printf("Memory allocation failed. Exiting.\n");
        exit(EXIT_FAILURE);
    }

    new_node->data = data;
    new_node->next = NULL;

    if (isEmptyQ(queue)) {
        // If the queue is empty, set both front and rear to the new node
        queue->front = new_node;
        queue->rear = new_node;
    } else {
        // Otherwise, update the rear and link the last node to the new node
        queue->rear->next = new_node;
        queue->rear = new_node;
    }

    // Make the queue circular by linking the rear to the front
    queue->rear->next = queue->front;
}

// Function to dequeue (remove) an element from the circular queue
int dequeue(struct CircularQueue* queue) {
    if (isEmptyQ(queue)) {
        printf("Queue is empty. Cannot dequeue.\n");
        exit(EXIT_FAILURE);
    }

    // Extract data from the front node
    int dequeued_data = queue->front->data;

    // Move front to the next node
    struct Node* temp = queue->front;
    queue->front = queue->front->next;

    // Free the memory of the dequeued node
    free(temp);

    // If the queue becomes empty after dequeue, update rear to NULL
    if (isEmptyQ(queue)) {
        queue->rear = NULL;
    } else {
        // Make the queue circular by linking the rear to the new front
        queue->rear->next = queue->front;
    }

    return dequeued_data;
}

// Function to display the elements in the circular queue
void display(struct CircularQueue* queue) {
    if (isEmptyQ(queue)) {
        printf("Queue is empty.\n");
        return;
    }
    struct Node* current = queue->front;
    do {
        printf("%d -> ", current->data);
        current = current->next;
    } while (current != queue->front);

    printf("(front)\n");
}

struct CircularQueue queue;
int main() {
    // Create an empty circular queue
    initializeQueue(&queue);
    int text, data;
    printf("0 -> insert data\n1 -> delete data\n2 -> show the current list\nplease enter an command...");
    while(1){
        scanf("%d",&text);
        switch (text)
        {
        case 0:{
            printf("enter an integer data: ");
            scanf("%d",&data);
            enqueue(&queue,data);
            break;
        }
        case 1:{
            printf("Deleted item-> %d\n",dequeue(&queue));
            break;
        }
        case 2:{
            printf("show the list\n");
            display(&queue);
            break;
        }
        default:
            printf("not an available command!\n");
            break;
        }
    }
    // Enqueue some elements into the circular queue

    return 0;
}
