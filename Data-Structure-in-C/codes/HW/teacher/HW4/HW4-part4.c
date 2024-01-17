#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#define max 99
#define min 1
#define size 40
#define print_spacing 10
// this is a copypase from week14-TA-HW.c (with some modifications)
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
    (*ptr)=(*ptr)->next;        // make the new head the "next" node of the deleted item 
    free(temp2);                // free the space of the deleted item
    return temp;
}

// insert a node in a sorted manner
void insertNum(struct Node** ptr, int x){
    struct Node* newNode=(struct Node*) malloc(sizeof(struct Node));
    newNode->data = x;          // assign the data(x) to the new node
    if(isEmpty(ptr)){
        // if the list is empty, create node
        newNode->next = NULL;
        *ptr = newNode;
    }else{
        // if the node is not empty, traverse the nodes
        struct Node* current = *ptr;
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
        insertNum(&head,random_number/*size-i*/);
    }
    printf("(1) List after inserting 50 ranom numbers:\n↓ first\n");
    printList(head);
    head=invertList(head);

    // (2) invert list---------------------------------------------------------------------------------|
    printf("\n(2) List after inverting:\n↓ first\n");
    printList(head);
    
    // (3) seperate odd numbers from a list------------------------------------------------------------|
    struct Node* oddlist = NULL;
    struct Node* not_oddlist = NULL;
    struct Node* temp;
    struct Node* head2=NULL;
    while(head!=NULL){
        int deleted_item=deleteNode(&head);
        insert(&head2,deleted_item);
        if(deleted_item%2==1){
            insertNum(&oddlist, deleted_item);
        }else{
            insertNum(&not_oddlist, deleted_item);
        }
    }
    head=head2;                         // put the original data back to head;
    printf("\n(3)-1 oddlist:\n↓ first\n");
    printList(oddlist);
    printf("\n(3)-2 not_oddlist:\n↓ first\n");
    printList(not_oddlist);

    // (4) concatenate oddlist to the front of not_oddlist --------------------------------------------|
    printf("\n(4) List after concatenating oddlist to the front:\n↓ first\n");
    head=concatenate(oddlist, not_oddlist);
    printList(head);

    // (5) convert the linear list into a circular list------------------------------------------------|
    printf("\n(5) List after converting to a circular linked list\n↓ first\n");
    head=Lin2Cir(head);
    printList(head);   // to prevent infinite loop, the function itself has a precaution

    // (6) delete every 6th node-----------------------------------------------------------------------|
    printf("\n(6) Deleted node with data every 6th element:\n↓ first\n");
    int count=0;
    struct Node* prevNode=NULL;
    temp=head;
    do{
        if((++count)%6==0){
            struct Node* temp2=temp;
            prevNode->next=temp->next;
            temp=temp->next;
            // if the freed item is the head, make the head the next element
            if(temp2==head) head=head->next; 
            free(temp2);
            count++;
            printList(head); printf("\n");
            if(temp->next==temp){
                temp=temp->next=NULL;
                break;
            }
        }
        prevNode=temp;
        temp=temp->next;
    }while(temp->next!=NULL);
    return 0;
}