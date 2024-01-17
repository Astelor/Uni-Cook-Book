#include <stdio.h>
#include <stdlib.h>
#include <time.h> 
#define SIZE 100
#define LENT 30
struct queue{ // 411440117 陳思妤 
    int A[SIZE];
    int front;
    int rear;
};

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
}// 411440117 陳思妤 
int printq(struct queue *ps){
    int i,k=0;
    if(emptyq(ps))
        printf("Empty Queue\n");
    else{
        //printf("Front -> %d\nItems -> ", ps->front);
        for(i=ps->front;i!=ps->rear;i=(i+1)%SIZE){
			if(k++%10==0) printf("\n");
            printf("%d ",ps->A[i]);
		}
        printf("%d\n", ps->A[i]);
        printf("\n");
    }
}
int frontq(struct queue *ps){
    return ps->A[ps->front];
}// 411440117 陳思妤 
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
int ques[4]={2,9,LENT-1,LENT-2};
char TheQues[4][1000]={"第一題：指定 n 的數值為排頭算起的第三元素。",
"第二題：指定 n 的數值為排頭算起的第十元素。",
"第三題：指定 n 的數值為排尾。",
"第四題：指定 n 的數值為排尾算起的第二元素。"};

int main(){
	struct queue element={.A=0, .front=-1, .rear=-1};
	struct queue temp={.A=0, .front=-1, .rear=-1};
	int i;
	srand(time(NULL));
	printf("  Generated Queue:");
	for(i=0;i<LENT;i++){
	    addq(&element,rand()%9+1);
	}
	printq(&element);
	for(i=0;i<4;i++){ //a checker
		printf("%s\n",TheQues[i]);
		int middle=accessQ(&element, &temp, ques[i]);
		printf("n = %d\n",middle);
	}
	printf("  Processed Queue:");
	printq(&element);
}

