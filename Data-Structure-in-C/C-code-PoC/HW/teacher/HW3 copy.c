#include <stdio.h>
#define SIZE 5
// Circular Queue implementation in C

struct queue{
    int A[SIZE];
    int front;
    int rear;
};

// Check if the queue is full
int fullq(struct queue *ps) {
    if ((ps->front == ps->rear + 1) || (ps->front == 0 && ps->rear == SIZE - 1)) return 1;
    return 0;
}

// Check if the queue is empty
int emptyq(struct queue *ps) {
    if (ps->front == -1) return 1;
    return 0;
}

// Adding an element
void enQueue(struct queue *ps, int data) {
    if (fullq(ps))
        printf("Queue is full!! \n");
    else {
        if (ps->front == -1) ps->front = 0;//move from reset value
        ps->rear = (ps->rear + 1) % SIZE;
        ps->A[ps->rear] = data;
        //printf("\n Inserted -> %d", element);
    }
}

// Removing an element
int deQueue(struct queue *ps) {
    int output;
    if (emptyq(ps)) {
        printf("\n Queue is empty !! \n");
        return (-1);
    } else {
        output = ps->A[ps->front];
        if (ps->front == ps->rear)
            ps->front = ps->rear = -1;
        // reset the queue after deleting it.
        else
            ps->front = (ps->front + 1) % SIZE;
        //printf("\n Deleted element -> %d \n", output);
        return (output);
    }
}

// Display the queue
void display(struct queue *ps) {
    int i;
    if (emptyq(ps))
        printf("Empty Queue\n");
    else {
        printf("Front -> %d \n", ps->front);
        printf("Items -> ");
        for (i = ps->front; i != ps->rear; i = (i + 1) % SIZE)
            printf("%d ", ps->A[i]);
        printf("%d \n", ps->A[i]);
        printf("Rear -> %d \n", ps->rear);
    }
}

int main() {
  // Fails because front = -1
    struct queue element= {.A=0, .front=-1, .rear=-1};
    int text,data;
    while(1){
        scanf("%d",&text);
        switch (text)
        {
        case 0:{
            printf("enter an integer data: ");
            scanf("%d",&data);
            enQueue(&element,data);
            break;
        }
        case 1:{
            printf("Deleted item-> %d\n",deQueue(&element));
            break;
        }
        case 2:{
            printf("show the queue\n");
            display(&element);
            break;
        }
        default:
            printf("not a availible command!\n");
            break;
        }
    }
  return 0;
}