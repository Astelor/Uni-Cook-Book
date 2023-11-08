#include <stdio.h>
#include <stdlib.h>
#include <time.h> 
#define SIZE 100
#define LENT 30
struct queue{ // 411440117  
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
}// 411440117 ³¯«ä§± 
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
}// 411440117 
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
void accessQ2(struct queue *ps, struct queue *temps, int index){
	int i=-1,output;
	while(!emptyq(ps)){//pop the original one
        if(++i==index){
			output=frontq(ps);
        	break;
		}
        addq(temps,deleteq(ps));
    }
    printf("k = %d",output);
    printq(ps);
    while(!emptyq(temps))
        deleteq(temps);
}
int clearqueue(struct queue *ps){
	int k;
	while(!emptyq(ps)) deleteq(ps);
	for(k=0;k<LENT;k++){
		addq(ps,rand()%9+1);
	}
}
int ques[6]={2,9,LENT-1,LENT-2,LENT-3,LENT-4};
char TheQues[12][1000]={"第一題：指定m 的數值為頂端算起的第三元素。",
"第二題：指定m 的數值為頂端算起的第三元素，且不改變堆疊。",
"第三題：指定m 的數值為頂端算起的第十元素。",
"第四題：指定m 的數值為頂端算起的第十元素，且不改變堆疊。",
"第五題：指定m 的數值為底端。",
"第六題：指定m 的數值為底端，且不改變堆疊。",
"第七題：指定m 的數值為底端算起的第二元素。",
"第八題：指定m 的數值為底端算起的第二元素，且不改變堆疊。",
"第九題：指定m 的數值為底端算起的第三元素。",
"第十題：指定m 的數值為底端算起的第三元素，且不改變堆疊。",
"第十一題：指定m 的數值為底端算起的第四元素。",
"第十二題：指定m 的數值為底端算起的第四元素，且不改變堆疊。"};
int main(){
	struct queue element={.A=0, .front=-1, .rear=-1};
	struct queue temp={.A=0, .front=-1, .rear=-1};
	int i,k=0;
	srand(time(NULL));
    
    for(i=0;i<6;i++){ //bruh
    printf("%s\n Generated queue:",TheQues[k++]);
        clearqueue(&element);
        printq(&element);
    accessQ2(&element,&temp,ques[i]);
    
    printf("%s\n Generated queue:",TheQues[k++]);
        clearqueue(&element);
        printq(&element);
    int middle=accessQ(&element, &temp, ques[i]);
    printf("k = %d\n Processed queue:",middle);
    printq(&element);
	}
}// 411440117
