#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#define max 99
#define min 1
#define size 40
#define print_spacing 10
// question 2
// this one's HW4 part4, but with deleteNode() and "6th" improved
// it works, idc and i dont wanna do redundancy

/*
2. Write a program including the following steps.
(1) Use rand()%100+1 to get 40 random numbers, output the numbers 
    (one by one, one space in between, and 10 numbers in one line), 
    insert the odd numbers into a created linear list (listPointer list1) one by one 
    (sorted in ascending order – from small to big), 
    and insert the even numbers into another created linear list (listPointer list2) one by one 
    **(sorted in decending order – from big to small). 
    
    (Note: Be sure to use the two functions void insertnum_s2b(listPointer *p, int x) and void insertnum_b2s(listPointer *p, int x).)
    
(2) output the linear list data from list1 and list2 
    (one by one from the first to the last, one space in between, and 10 numbers in one line). 
    (Note: Be sure to use the function void printL(listPointer p).)

(3) produce a new linear list (listPointer p) that contains the linear list list1 followed by the linear list list2, 
    and output data from the new linear list list (one by one from the first to the last, one space in between, and 10 numbers in one line). 
    (Note: Be sure to use the function listPointer concatenate(listPointer p1, listPointer p2). )

(4) invert the linear list <list> to form a new linear list <invlist> and output the linear list data from the new linear list <invlist> 
    (one by one from the first to the last, one space in between, and 10 numbers in one line). 
    (Note: Be sure to use the function listPointer invert(listPointer p). )

(5) change the linear list <invlist> to a circular list. 
    (Note: Be sure to use the function listPointer Lin2Cir(listPointer p). )

(6) output the circular list data (one by one from the first to the last, one space in between, and 10 numbers in one line). 
    (Note: Be sure to use the function void printC(listPointer p). )

(7) start from the first node of the circular list in (6), count around the list and delete the 6th node each time 
    (using int delete(listPointer p)), and output the deleted number until the list becomes empty.

*/

struct Node{
    int data;
    struct Node* next;
};

int isEmpty(struct Node** ptr){
    return ((*ptr)==NULL);
}

// insert a node at the beginning of the list
// [newnode] -> [old head] -> [data1] -> [data2]
void insert(struct Node** ptr, int x){
    // ptr is a pointer to a pointer
    // so that the changes done(to (*ptr) ) in the function can be effective on the local varible(head)
    struct Node* newNode = (struct Node*) malloc(sizeof(struct Node));
    newNode->data=x;            // assgin the data(x) to newNode

    if(isEmpty(ptr)){
        // if the list is empty, 
        newNode->next = NULL;   // creating a brand new node, there's no data in next
        (*ptr) = newNode;       // set the head to newNode
    }else{
        newNode->next = *ptr;   // ptr points to the very head, making the new node the "prior" of ptr
        *ptr = newNode;         // the new node is now the head 
    }
}

// delete the first node of the list and returns its data
// [delete] -> [new head] -> [data1] -> [data2]
int deleteNode(struct Node** ptr){
    if(isEmpty(ptr)){
        printf("the list is empty!\n");
        exit(1);
    }
    int temp = (*ptr)->data;
    struct Node* temp2=*ptr;    // hold the address of the deleted item
    if((*ptr)==(*ptr)->next)
        *ptr=NULL;              // if the list is circular, reset ptr if the deleted item is the last one
    else
        (*ptr)=(*ptr)->next;    // make the new head the "next" node of the deleted item 

    free(temp2);                // free the space of the deleted item
    return temp;
}

// insert a node in a sorted manner
// query_ascending=1: 123. query_ascending=0: 321
void insertNum(struct Node** ptr, int x, int query_ascending){
    struct Node* newNode=(struct Node*) malloc(sizeof(struct Node));
    newNode->data = x;          // assign the data(x) to the new node
    if(isEmpty(ptr)){
        // if the list is empty, create node
        newNode->next = NULL;
        *ptr = newNode;
    }else{
        // if the node is not empty, traverse the nodes
        struct Node* current = *ptr;
        if(query_ascending){
            if( x<= current->data){
                // handles exception when the newNode should be at the beginning
                newNode->next = *ptr;
                *ptr=newNode;
            }else{
                while(current->next != NULL){
                    // handles segmentation fault if the newNode should be at the end
                    if(x <= current->next->data) break;
                    current=current->next;
                }
                if(current->next!=NULL){
                    newNode->next = current->next;
                    current->next= newNode;
                }else{
                    newNode->next = NULL;
                    current->next = newNode;
                }
            }
        } else{
            if( x > current->data){
                // handles exception when the newNode should be at the beginning
                newNode->next = *ptr;
                *ptr=newNode;
            }else{
                while(current->next != NULL){
                    // handles segmentation fault if the newNode should be at the end
                    if(x > current->next->data) break;
                    current=current->next;
                }
                if(current->next!=NULL){
                    newNode->next = current->next;
                    current->next= newNode;
                }else{
                    newNode->next = NULL;
                    current->next = newNode;
                }
            }
        }
    }
}

// concatenate the second list to the first list
struct Node* concatenate(struct Node* ptr1, struct Node* ptr2){
    if(ptr1==NULL){
        // if the first list is empty, return the second list
        return ptr2;
    }
    struct Node* temp = ptr1;
    while(temp->next != NULL){
        // traverse the first list to find the last node
        temp=temp->next; 
    }
    
    // concatenate the second list to the end of the first list(thus will be head)
    temp->next = ptr2;
    return ptr1;
}

struct Node* invertList(struct Node* ptr){
    struct Node* prev=NULL;
    struct Node* current=ptr;
    struct Node* nextNode=NULL;
    while(current != NULL){             // 1      2      3      4
        nextNode = current->next;       // [p|0]->[c|3]->[n|4]->[ |0] hold the next node
        current->next = prev;           // [p|0]<-[c|1]->[n|4]->[ |0] edit the current node, make it link to the previous one
        prev = current;                 // [ |0]<-[p|1]->[n|4]->[ |0] step "prev" to the next one
        current = nextNode;             // [ |0]<-[p|1]->[cn|4]->[ |0]step "current" to the next one
    }
    return prev;
}

struct Node* Lin2Cir(struct Node* ptr){
    struct Node* temp= ptr;
    while(temp->next!=NULL) temp=temp->next;
    temp->next=ptr;
    return ptr;
}

// printing the list :D
void printList (struct Node* ptr){
    struct Node* temp = ptr;
    int count = 0;
    while(temp!=NULL){
        printf("%2d ", temp->data);
        temp=temp->next;
        count++;
        if(count%print_spacing==0) printf("\n");
        if(temp==ptr) break;            // if the list is circular, preventing a infinite loop
    }
    printf("\n");
}

int main(){
    //initialize an empty linked list
    struct Node* head = NULL;
    srand(time(NULL));
    int i;
    // (1) inserting random numbers--------------------------------------------------------------------|
    for(i=0;i<size;i++){
        // inserting 50 random numbers into the list
        int random_number = rand()%(max-min+1)+min;
        insert(&head,/*random_number*/size-i); //debug here
    }
    printf("(1) List after inserting 50 ranom numbers:\n↓ first\n");
    printList(head);

    // (2) seperate odd numbers from a list------------------------------------------------------------|
    struct Node* oddlist = NULL;
    struct Node* not_oddlist = NULL;
    struct Node* temp;
    struct Node* head2=NULL;
    while(head!=NULL){
        int deleted_item=deleteNode(&head);
        insert(&head2,deleted_item);
        if(deleted_item%2==1){
            insertNum(&oddlist, deleted_item, 1);
        }else{
            insertNum(&not_oddlist, deleted_item, 0);
        }
    }
    //head=head2;                         // put the original data back to head;
    printf("\n(2)-1 oddlist:\n↓ first\n");
    printList(oddlist);
    printf("\n(2)-2 not_oddlist:\n↓ first\n");
    printList(not_oddlist);
    
    // (3) concatenate oddlist to the front of not_oddlist --------------------------------------------|
    printf("\n(3) List after concatenating oddlist to the front:\n↓ first\n");
    head=concatenate(oddlist, not_oddlist);
    printList(head);

    // (4) invert list---------------------------------------------------------------------------------|
    struct Node* invlist;
    invlist=invertList(head);
    printf("\n(4) List after inverting:\n↓ first\n");
    printList(invlist);


    // (5)+ (6) convert the linear list into a circular list-------------------------------------------|
    printf("\n(5+6) List after converting to a circular linked list\n↓ first\n");
    invlist=Lin2Cir(invlist);
    printList(invlist);   // to prevent infinite loop, the function itself has a precaution

    // (7) delete every 6th node-----------------------------------------------------------------------|
    printf("\n(7) Deleted node with data every 6th element:\n↓ first\n");
    int count=0;
    struct Node* prevNode=NULL;
    /*struct Node* */temp=invlist;
    do{
        if((++count)%6==0){
            printf("%2d ", deleteNode(&temp));
                if((count/6)%print_spacing==0) printf("\n");
            prevNode->next=temp;
            count++;
            if(isEmpty(&temp)) break;
        }
        prevNode=temp;
        temp=temp->next;
    }while(!isEmpty(&temp));
    return 0;
}