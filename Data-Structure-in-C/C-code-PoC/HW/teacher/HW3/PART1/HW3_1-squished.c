#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#define SIZE 100
#define LENT 30

struct stack{ //411440117 陳思妤 
	int A[SIZE];
  	int top;
};
int emptys(struct stack *ps){return ( ps->top==-1 );}
int fulls(struct stack *ps){return ( ps->top==SIZE-1 );}
void pushs(struct stack *ps, int data){
	if(fulls(ps))
		printf("Stack is full!\n");
	else ps->A[++(ps->top)]=data;
}
int pops(struct stack *ps){
	if(emptys(ps)){
		printf("the stack is empty\n");
		return -1;
	}
	int temp=ps->A[ps->top];
	ps->A[(ps->top)--]=0;
	return temp;
}
int tops(struct stack *ps){return (ps->A[ps->top]);}
int prints(struct stack *ps){ 
    int i,k=0;
    if(emptys(ps))
        printf("Empty Stack\n");
    else{
        for(i=ps->top;i>=0;i--){
        	if(k++%10==0) printf("\n");
            printf("%d ",ps->A[i]);
		}
		printf("\n");
    }
}
int accessS(struct stack *ps, struct stack *temps, int index){
	int i,output;
	for(i=0;i<index;i++) pushs(temps,pops(ps));
	output=tops(ps);
    for(i=0;i<index;i++) pushs(ps,pops(temps));
    return output;
}//411440117 陳思妤 
void accessS2(struct stack *ps, struct stack *temps, int index){
	int i,m;
	for(i=0;i<index;i++) pushs(temps,pops(ps));
	m = tops(ps);
	printf("m = %d\n Processed stack:",m);
	prints(ps);
    while(!emptys(temps)) pops(temps);
}
void clearstack(struct stack *ps){
	int k;
	while(!emptys(ps)) pops(ps);
	for(k=0;k<LENT;k++) pushs(ps,rand()%9+1);
}
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
int ques[6]={2,9,LENT-1,LENT-2,LENT-3,LENT-4};// the accessing index for each questions

int main(){
	struct stack element={.A=0, .top=-1};
	struct stack temp={.A=0, .top=-1};
	srand(time(NULL));
	int i,k=0;
	for(i=0;i<6;i++){ //bruh
		printf("%s\n Generated stack:",TheQues[k++]);
			clearstack(&element);
			prints(&element);
		accessS2(&element,&temp,ques[i]);
		
		printf("%s\n Generated stack:",TheQues[k++]);
			clearstack(&element);
			prints(&element);
		int middle=accessS(&element, &temp, ques[i]);
		printf("m = %d\n Processed stack:",middle);
		prints(&element);
	}
	return 0;//411440117 陳思妤 
}