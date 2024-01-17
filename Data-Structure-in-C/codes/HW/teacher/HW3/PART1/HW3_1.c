#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#define SIZE 100
#define LENT 30

struct stack{
	int A[SIZE];
  	int top;
};
int emptys(struct stack *ps){
	return ( ps->top==-1 );
}
int fulls(struct stack *ps){
	return ( ps->top==SIZE-1 );
}
void pushs(struct stack *ps, int data){
	if(fulls(ps)){
		printf("Stack is full!\n");
	}
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
int tops(struct stack *ps){
	return (ps->A[ps->top]);
} // all the above are exactly the same
int prints(struct stack *ps){
    int i,k=0;
    if(emptys(ps))
        printf("Empty Stack\n");
    else{
        //printf("Top -> %d ", ps->A[ps->top]);
        for(i=ps->top;i>=0;i--){ // 10 numbers a segment
        	if(k++%10==0) printf("\n");
            printf("%d ",ps->A[i]);
		}
		printf("\n");
    }
}
int accessS(struct stack *ps, struct stack *temps, int index){
	int i,output;
	for(i=0;i<index;i++)//pop the original one
		pushs(temps,pops(ps));
	output=tops(ps); // get the content
    for(i=0;i<index;i++) // push back to the original one(from temps)
        pushs(ps,pops(temps));
    return output;
}
void accessS2(struct stack *ps, struct stack *temps, int index){
	int i,m;
	for(i=0;i<index;i++)//pop the original one
		pushs(temps,pops(ps));
	m = tops(ps); // get the content
	printf("m = %d\n Processed stack:",m); // print the altered stack
	prints(ps); // not pushing back the original one
    while(!emptys(temps)) // flush the temps
        pops(temps);
}// added helper
void clearstack(struct stack *ps){ //clear and place new ones
	int k;
	while(!emptys(ps)) pops(ps); // clear the stack
	for(k=0;k<LENT;k++){ // place new numbers in
		pushs(ps,rand()%9+1);
	}
}// added helper
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
	return 0;
}