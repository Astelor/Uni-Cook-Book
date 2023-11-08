# Data Structure cheat sheet
It's a "cheat sheet", not a complete code. :>

- [Data Structure cheat sheet](#data-structure-cheat-sheet)
	- [Structure](#structure)
		- [Where it stores?](#where-it-stores)
		- [Struct](#struct)
		- [Union](#union)
	- [Stack](#stack)
		- [The Fundamentals](#the-fundamentals)
		- [Access the middle with 2 stacks](#access-the-middle-with-2-stacks)
		- [Inserting the middle with 2 Stacks](#inserting-the-middle-with-2-stacks)
		- [Parenthesis Checker](#parenthesis-checker)
	- [Queue](#queue)
		- [The Fundamentals](#the-fundamentals-1)
		- [Accessing the middle with 2 queues](#accessing-the-middle-with-2-queues)
		- [user input code checker](#user-input-code-checker)
		- [Jargons](#jargons)
			- [lastOperationIs...](#lastoperationis)
			- [TotalInQueue](#totalinqueue)
			- [Sacrificing an element space](#sacrificing-an-element-space)
	- [Misc](#misc)
		- [Generate a sequence of random numbers](#generate-a-sequence-of-random-numbers)
		- [rand](#rand)
		- [time](#time)
	- [NOTE](#note)


## Structure
### Where it stores?
Because in C the compiler isn't that smart.
- The address is a BYTE a unit (0x0~0x3 is 3 bytes of data)
- The **order of the variables matter**!
- a variable must be accessible within a cycle
  - you can't store a double in 2 different registers

|type|size (byte)|
|---|---|
|char|1|
|int|4|
|float|**4**|
|double|8|

```
float a  | 4 +(4)
double b | 8
char c   | 1 +(7)
[▮▮▮▮]▯▯▯▯ float
[▮▮▮▮▮▮▮▮] double
[▮]▯▯▯▯▯▯▯ char
-> 24 bytes
``` 

```
float a  | 4
char b   | 1 +(3)
double c | 8
[▮▮▮▮][▮]▯▯▯ float & char
[▮▮▮▮  ▮▮▮▮] double (ignore the spaces)
-> 16 bytes
```

```
int a,b,c | 4+4+4
[▮▮▮▮][▮▮▮▮] a, b
[▮▮▮▮]			c
-> 12 bytes
yes the area after *integer c* is blank
```

```
int a,b,c | 4+4+4
char d	  | 1 +(3)
[▮▮▮▮][▮ ▮▮▮] a, b
[▮▮▮▮][▮]▯▯▯  c, d
-> 16 bytes
```

- it's most sensible to check it in the IDE beforehand, but it follows these general rules

### Struct
Syntax
```c
struct typeName{
	int a;
    char b;
    //variables here
}AccessibleName;

struct typeName variableName[array!];
```
- you can't go sizeof(typeName) btw

### Union
Syntax
```c
union{
	struct typeName2 variableName2;
	struct typeName3 variableName3;
  //variables here
}unionName;
```
- an union will allocate the memory from the largest data type
  - both variableName(2 and 3) are accessible, but will write-over the other, if one is being written.
  - if you write 2, 3 will disappear. vise versa

## Stack
fuck you :Madge:

### The Fundamentals
I'm a lazy mf, everything should apply under this condition(fundamentals), so that you don't have to check the base code every time you make a modification.

tldr; don't change the stack itself.
[stackEHHH.c](/Data-Structure-in-C/C-code-PoC/playground/stackEHHH.c)
(verified)
```c
#include <stdio.h>
#define SIZE 100

struct stack{
	int A[SIZE];
  	int top;
};

int emptys(struct stack *ps); //return 1 is the stack is empty; return 0 otherwise
int fulls(struct stack *ps); // return 1 if the stack is full; return 0 otherwise
void pushs(struct stack *ps, int data); //push data onto the stack
int pops(struct stack *ps); //pop the stack and return the popped element
int tops(struct stack *ps); //return the top element in the stack
int prints(struct stack *ps); // print the stack

int main(){
    struct stack element={.A=0, .top=-1};
    struct stack temp={.A=0, .top=-1};
    // your code here
	// you wanna do push(&element,data); the pointer eats address
}
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
}
int prints(struct stack *ps){
    int i;
    if(emptys(ps))
        printf("Empty Stack\n");
    else{
        printf("Top -> %d ", ps->A[ps->top]);
        for(i=ps->top-1;i>=0;i--)
            printf("%d ",ps->A[i]);
		printf("\n");
    }
}
```

### Access the middle with 2 stacks
> bruh altering "top" is an index accessing, idc, I don't deserve a zero for doing index accessing. SOOO here it is, the orthodox way to do this.

The functions added should be placed in the fundamentals accordingly.
[stackEHHH.c](/Data-Structure-in-C/C-code-PoC/playground/stackEHHH.c)
(verified)
```c
int accessS(struct stack *ps, struct stack *temps, int index);

int main(){
	struct stack element={.A=0, .top=-1};
	struct stack temp={.A=0, .top=-1};
	int i,lent=30;
	for(i=0;i<lent;i++){
	    pushs(&element,rand()%9+1);
	}
	while(1){ //a checker
		int ind;
		scanf("%d",&ind);
		int middle=accessS(&element, &temp, ind);
		printf("%d\n",middle);
		prints(&element);
	}
}

int accessS(struct stack *ps, struct stack *temps, int index){
	int i,output;
	for(i=0;i<index;i++)//pop the original one
		pushs(temps,pops(ps));
	output=tops(ps);
    for(i=0;i<index;i++)
        pushs(ps,pops(temps));
    return output;
}
```
### Inserting the middle with 2 Stacks

```c
int inserts(struct stack *ps, int data, int index);
int main(){

}
int inserts(struct stack *ps, struct stack *temps, int data, int index){
	int i;
	for(i=0;i<index;i++) //pop the original one
		pushs(temps,pops(ps));
	
		
}
```
### Parenthesis Checker
> In C++, you can just slap vector and pair in and call it a day. But in C, and writing it from scratch using only array. An independent stack is your best bet.

This only checks 2 types of parenthesis. Just add more conditions and checks if there are more than 2 types.

element and parent should be popped or pushed simultaneously.
[parenthsis-check.c](/Data-Structure-in-C/C-code-PoC/playground/parenthsis-check.c)
(verified)
```c
int main(){
	struct stack element = {.A=0, .top=-1}; //initialize stack
    struct stack parent = { .A=0, .top=-1}; //for parenthesis type 
    char c; // (->1 [->2
    int index=-1;
    while( (c=getchar())!=EOF && c!='\n'){
        index+=1;
        if(c=='(' || c=='['){ //different parenthesis parser
            pushs(&element, index);
            if(c=='(')
                pushs(&parent, 1);
            else 
                pushs(&parent, 2);
        }
        else if(c==')' || c==']'){	
            if(c==')'){
                if(emptys(&element) || tops(&parent)!=1)
                    printf("位置編號 %d 的右括弧)沒有可配對的左括弧(\n",index);
                else{
                    printf("(%d,%d)\n",pops(&element),index);
                    pops(&parent);
                }
            }
            else{
                if(emptys(&element) || tops(&parent)!=2)
                    printf("位置編號 %d 的右括弧]沒有可配對的左括弧[\n",index);
                else{
                    printf("[%d,%d]\n",pops(&element),index);
                    pops(&parent);
                }
            }
			//just add more conditions if there are more than 2 types of parenthesis
        }
        else continue;
    }
    while(!emptys(&element)){
        if(tops(&parent)==1)
            printf("位置編號 %d 的右括弧)沒有可配對的左括弧(\n",pops(&element));
        else
            printf("位置編號 %d 的右括弧]沒有可配對的左括弧[\n",pops(&element));
        pops(&parent);
    }
	return 0;
}
```
---
## Queue

### The Fundamentals
Circular Queue
[queueEHHH.c](/Data-Structure-in-C/C-code-PoC/playground/queueEHHH.c)
```c
#include <stdio.h>
#include <stdlib.h>
#define SIZE 5
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
int frontq(struct queue *ps); //return the front element

int main(){
    struct queue element= {.A=0, .front=-1, .rear=-1};
    //int text,data;
    // your code here
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
int frontq(struct queue *ps){
    return ps->A[ps->front];
}
```
### Accessing the middle with 2 queues

(verified)
```c
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
```

### user input code checker
this is a fail safe
```c
while(1){
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
		printf("not an available command!\n");
		break;
	}
}
```
### Jargons
> The prof just doesn't explain anything in the paper, they are just jargons to me. Thanks for making me go through the recordings.
> THESE are hardly relevant to data structure itself, these are implementations, these are programming.

#### lastOperationIs...

#### TotalInQueue

#### Sacrificing an element space


---
## Misc

### Generate a sequence of random numbers
```c
#include <stdlib.h>
#include <time.h>

srand(time(NULL));
int i,len=30;
for(i=0;i<len;i++)
    pushs(&element,rand()%9+1);//or addq if it's a queue
```

### rand
```c
#include <stdlib.h>
srand(seed);
int randomNumber=rand()%(max - min +1) + min; //max~min
```

### time
```c
#include <time.h>
int t=time(NULL);
```

## NOTE
- If the IDE gives you some makefile error when compiling, just make a new project. (when you're in the exam ofc)
- If the debug window is weird, go to `Project Options` -> `Compiler` -> `Linker` -> `Generate debugging information` -> check it to `yes`  

