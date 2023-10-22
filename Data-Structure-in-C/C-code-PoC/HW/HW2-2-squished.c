#include <stdio.h>
#define SIZE 100
int stack[SIZE], top=-1; //[REDACTED]
int empty(){
    if(top<0) return 1;
    else return 0;
}
void push(int data){ stack[++top]=data; }
int pop(){ int temp=stack[top]; stack[top--]=0; return temp; }
int stack_top(){ return stack[top]; }
int main(){
    char c; int index=-1; // (((a+b)]*[[[c+d)] 
    while((c=getchar())!=EOF && c!='\n'){
        index+=1;
        if(c=='(') push(index);
        else if(c=='[') push(index+1000);
        else if(c==')'){
            if(empty()) printf("位置編號 %d 的右括弧)沒有可配對的左括弧(\n",index);
            else{
                if(stack_top()>=1000)
                    printf("位置編號 %d 的右括弧)沒有可配對的左括弧(\n",index);
                else
                    printf("(%d,%d)\n",pop(),index);
            }
        }
        else if(c==']'){
            if(empty()) printf("位置編號 %d 的右括弧]沒有可配對的左括弧[\n",index);
            else{
                if(stack_top()<1000)
                    printf("位置編號 %d 的右括弧]沒有可配對的左括弧[\n",index);
                else
                    printf("[%d,%d]\n",pop()-1000,index);
            }
        }
        else continue;
    }
    while(!empty()){
        if(stack_top()>=1000)
            printf("位置編號 %d 的左括弧[沒有可配對的右括弧]\n",pop()-1000);
        else
            printf("位置編號 %d 的左括弧(沒有可配對的右括弧)\n",pop());
    }
    return 0;}