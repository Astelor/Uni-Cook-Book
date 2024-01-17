#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#define max 100
#define min 1
#define size 50
#define print_spacing 8
// question 3
// this one's HW4 part4, but with deleteNode() and "6th" improved

struct Node{
    int data;
    struct Node* next;
}; // 411440117 Aster Chen

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
}// 411440117 Aster Chen

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
}// 411440117 Aster Chen

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
}// 411440117 Aster Chen

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

int main(){// 411440117 Aster Chen
    //initialize an empty linked list
    struct Node* head = NULL;
    //srand(time(NULL));
    int i;
    // (1) inserting random numbers--------------------------------------------------------------------|
    for(i=0;i<size;i++){
        // inserting 50 random numbers into the list
        int random_number = rand()%(max-min+1)+min;
        insert(&head, random_number/*size-i*/); //debug here
    }
    printf("(1) List after inserting 50 ranom numbers:\n¡õ first\n");
    printList(head);

    // (2) seperate odd numbers from a list------------------------------------------------------------|
    struct Node* p0 = NULL;
    struct Node* p1 = NULL;
    struct Node* temp;
    
    while(head!=NULL){
        int deleted_item=deleteNode(&head);
        //insert(&head2,deleted_item);
        if(deleted_item%2==1){
            insertNum(&p0, deleted_item, 1);
        }else{
            insertNum(&p1, deleted_item, 1);
        }
    }
    //head=head2;                         // put the original data back to head;
    
	printf("\n(2)-1 oddlist(p0):\n¡õ first\n");
    printList(p0);
    printf("\n(2)-2 not_oddlis(p1)t:\n¡õ first\n");
    printList(p1);
    
    
    // (3) concatenate oddlist to the front of not_oddlist --------------------------------------------|
    struct Node* p = NULL;
	p=concatenate(p0, p1);
    
	printf("\n(3) List after concatenating oddlist to the front:\n¡õ first\n");
    printList(p);


    // (4+5) convert the linear list into a circular list-------------------------------------------|
    printf("\n(4+5) List after converting to a circular linked list\n¡õ first\n");
    p=Lin2Cir(p);
    printList(p);   // to prevent infinite loop, the function itself has a precaution
	
    // (6) delete every 6th node-----------------------------------------------------------------------|
    printf("\n(6) Deleted node with data every 3rd element:\n¡õ first\n");
    int count=0;
    struct Node* prevNode=NULL;
    //struct Node*
	temp=p;
    do{
        if((++count)%3==0){
            printf("%2d ", deleteNode(&temp));
                if((count/3)%print_spacing==0) printf("\n");
            prevNode->next=temp;
            count++;
            if(isEmpty(&temp)) break;
        }
        prevNode=temp;
        temp=temp->next;
    }while(!isEmpty(&temp)); 
    return 0; // 411440117 Aster Chen
}
