#include <stdio.h>
#include <stdlib.h>
#define SIZE 100

struct queue{
    int A[SIZE];
    int front;
    int rear;
};

int emptyq(struct queue *ps);
int fullq(struct queue *ps);
void addq(struct queue *ps, int data);
int deleteq(struct queue *ps);
int printq(struct queue *ps);


int main(){
    struct queue element={.A=0, .front=0, .rear=0};
    return 0;
}

int emptyq(struct queue *ps){ //front = rear, rear is pointing to nothing
    return (ps->rear==ps->front);
}
int fullq(struct queue *ps){ //rear-front=10
    if (ps->rear < ps->front)
        return (ps->rear)+1==ps->front;
    else
        return ps->front - ps->rear==SIZE;
}
void addq(struct queue *ps, int data){
    if(fullq(ps)){
        printf("the queue is full!\n");
        exit(1);
    }
    if(emptyq(ps)){
        ps->A[(ps->rear)++]=data;
    }
    else if(ps->rear<SIZE-1){
        ps->A[++(ps->rear)]=
    }
    else{

    }
}
int deleteq(struct queue *ps){
    if(emptyq(ps)){
        printf("the queue is empty!\n");
        exit(2);
    }
    int output;
    output = ps->A[ps->front];
    if(ps->front < SIZE-1){
        ps->A[ps->front++]=0;
    }
    else{
        ps->A[ps->front]=0;
        ps->front=0;
    }
    return output;
}
int printq(struct queue *ps);