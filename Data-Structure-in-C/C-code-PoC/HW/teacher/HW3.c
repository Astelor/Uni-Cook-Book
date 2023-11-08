#include <stdio.h>
#include <stdlib.h>
#define SIZE 5

struct queue{
    int A[SIZE];
    int front;
    int rear;
};
// this one's a circular queue
int emptyq(struct queue *ps); // check if the queue is empty
int fullq(struct queue *ps); // check if the queue is full
void addq(struct queue *ps, int data); // adding an element
int deleteq(struct queue *ps); //deleting an element
int printq(struct queue *ps); //printing the element in queue

int main(){
    struct queue element= {.A=0, .front=-1, .rear=-1};
    int text,data;
    /*while(1){
        scanf("%d",&text);
        switch (text)
        {
        case 0:{
            printf("enter an integer data: ");
            scanf("%d",&data);
            addq(&element,data);
            break;
        }
        case 1:{
            printf("Deleted item-> %d\n",deleteq(&element));
            break;
        }
        case 2:{
            printf("show the queue\n");
            printq(&element);
            break;
        }
        default:
            printf("not an availible command!\n");
            break;
        }
    }*/
    return 0;
}

int emptyq(struct queue *ps){
    if (ps->front==-1) return 1;
    return 0; //because we reset front&rear to -1 after delete the last item
}
int fullq(struct queue *ps){ //rear-front=10
    if((ps->front==ps->rear+1) ||(ps->front==0 && ps-> rear ==SIZE-1))
        return 1;
    return 0;
}
void addq(struct queue *ps, int data){
    if(fullq(ps))
        printf("Queue is full!\n");
    else{
        if(ps->front==-1) ps->front = 0;
        ps->rear=(ps->rear +1) %SIZE;
        ps->A[ps->rear]=data;
    }
}
int deleteq(struct queue *ps){
    int output;
    if(emptyq(ps)){
        printf("the queue is empty!\n");
        return (-1);
    } else{
        output = ps->A[ps->front];
        if(ps->front == ps->rear)
            ps->front = ps->rear = -1;
        else
            ps->front = (ps->front+1) %SIZE;
        return output;
    }
}
int printq(struct queue *ps){
    int i;
    if(emptyq(ps))
        printf("Empty Queue\n");
    else{
        printf("Front -> %d\nItems -> ", ps->front);
        for(i=ps->front;i!=ps->rear;i=(i+1)%SIZE)
            printf("%d ",ps->A[i]);
        printf("%d \nRear -> %d\n", ps->A[i], ps->rear);
    }
}

