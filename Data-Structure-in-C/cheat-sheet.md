# Data Structure cheat sheet
It's a "cheat sheet", not a complete code. :>

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
fuck you Madge

### The Fundamentals
I'm a lazy mf, everything should apply under this condition(fundamentals), so that you don't have to check the base code every time you make a modification.

tldr; don't change the stack itself.
```c
#include <stdio.h>
#define SIZE 100

struct stack{
	int A[SIZE];
  	int top;
};
int empty(struct stack *ps); //return 1 is the stack is empty; return 0 otherwise
int full(struct stack *ps); // return 1 if the stack is full; return 0 otherwise
void push(struct stack *ps, int data); //push data onto the stack
int pop(struct stack *ps); //pop the stack and return the popped element
int top(struct stack *ps); //return the top element in the stack


int main(){
	struct stack element = {.A=0, .top=-1}; //initialize stack
	// your code here
	// you wanna do push(&element,data); the pointer eats address
	return 0;
}

int empty(struct stack *ps){
	return ( ps->top==-1 );
}
int full(struct stack *ps){
	return ( ps->top==SIZE-1 );
}
void push(struct stack *ps, int data){
	if(full(ps)){
		printf("the stack is full! no space to push\n");
		//exit(1);
	}
	ps->A[++(ps->top)]=data;
}
int pop(struct stack *ps){
	if(empty(ps)){
		printf("the stack is empty! nothing to pop\n");
		//exit(2);
	}
	int temp=ps->A[ps->top];
	ps->A[(ps->top)--]=0;
	return temp; // return the popped element
}
int top(struct stack *ps){
	if(empty(ps)){
        printf("the stack is empty!\n");
        //exit(3);
    }
	return (ps->A[ps->top]);
}
```

### Access the middle with 2 stacks
bruh altering "top" is an index accessing, idc, I don't deserve a zero for doing index accessing. SOOO here it is, the orthodox way to do this.

The functions added should be placed in the code accordingly.

```c
int access(struct stack *ps, struct stack *temps, int index);

int main(){
	struct stack element={.A=0, .top=-1};
	struct stack temp={.A=0, .top=-1};
	// let's say if we want to access the third element from the top
	// the index will be 2 (counting from 0)
	int middle=access(&element, &temp, 2);
}

int access(struct stack *ps, struct stack *temps, int index){
	int i,output;
	for(i=0;i<index;i++) //pop the original one
		push(temps,pop(ps));
	output=top(ps);
    for(i=0;i<index;i++) //push back the original one
        push(ps,pop(temps));
    return output;
}
```

### Parenthesis Checker
This only checks 2 types of parenthesis. Just add more conditions and checks if there are more than 2 types.

In C++, you can just slap vector and pair in and call it a day. But in C, and writing it from scratch using only array. An independent stack is your best bet.

element and parent should be popped or pushed simultaneously.
```c
int main(){
	struct stack element = {.A=0, .top=-1}; //initialize stack
    struct stack parent = { .A=0, .top=-1}; //for parenthesis type 
    char c; // (->1 [->2
    int index=-1;
    while( (c=getchar())!=EOF && c!='\n'){
        index+=1;
        if(c=='(' || c=='['){ //different parenthesis parser
            push(&element, index);
            if(c=='(')
                push(&parent, 1);
            else 
                push(&parent, 2);
        }
        else if(c==')' || c==']'){	
            if(c==')'){
                if(empty(&element) || top(&parent)!=1)
                    printf("位置編號 %d 的右括弧)沒有可配對的左括弧(\n",index);
                else{
                    printf("(%d,%d)\n",pop(&element),index);
                    pop(&parent);
                }
            }
            else{
                if(empty(&element) || top(&parent)!=2)
                    printf("位置編號 %d 的右括弧]沒有可配對的左括弧[\n",index);
                else{
                    printf("[%d,%d]\n",pop(&element),index);
                    pop(&parent);
                }
            }
			//just add more conditions if there are more than 2 types of parenthesis
        }
        else continue;
    }
    while(!empty(&element)){
        if(top(&parent)==1)
            printf("位置編號 %d 的右括弧)沒有可配對的左括弧(\n",pop(&element));
        else
            printf("位置編號 %d 的右括弧]沒有可配對的左括弧[\n",pop(&element));
        pop(&parent);
    }
	return 0;
}
```
## Queue

### The Fundamentals
this is fine yep.

## Misc

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

I love simplifying my code and make it look easy, and lose points because it looks easy.