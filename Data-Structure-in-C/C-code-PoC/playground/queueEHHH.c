#include <stdio.h>
#include <stdlib.h>
#define SIZE 100
struct queue{ // circular queue
    int A[SIZE];
    int front;
    int rear;
};
int emptyq(struct queue *ps); // check if the queue is empty
int fullq(struct queue *ps); // check if the queue is full
void addq(struct queue *ps, int data); // adding an element
int deleteq(struct queue *ps); //deleting an element
int printq(struct queue *ps); //printing the element in queue

int frontq(struct queue *ps);

int accessQ(struct queue *ps, struct queue *temps, int index);

int main(){
	struct queue element={.A=0, .front=-1, .rear=-1};
	struct queue temp={.A=0, .front=-1, .rear=-1};
	int i,lent=30;
	for(i=0;i<lent;i++){
	    addq(&element,rand()%99+1);
	}
	while(1){ //a checker
		int ind;
		scanf("%d",&ind);
		int middle=accessQ(&element, &temp, ind);
		printf("%d\n",middle);
		printq(&element);
	}
}

int accessQ(struct queue *ps, struct queue *temps, int index){
	int i=-1,output;
	while(!emptyq(ps)){//pop the original one
        if(++i==index) output=frontq(ps);
        addq(temps,deleteq(ps));
    }
    while(!emptyq(temps))
        addq(ps,deleteq(temps));
    return output;
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
int frontq(struct queue *ps){
    return ps->A[ps->front];
}