#include <stdio.h>
#include <stdlib.h>

//typedef struct Node* listPointer;
// for the sake of my own studying, let's not use listPointer here
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
    if(ptr==NULL){
        printf("the list is empty!\n");
        exit(2);
    }
    
}

// printing the list :D
void printList (struct Node* ptr){
    //struct Node* temp = ptr;
    int count = 0;
    while(ptr!=NULL){
        printf("%2d ", ptr->data);
        ptr=ptr->next;
        count++;
        if(count%10==0) printf("\n");
    }
    printf("\n");
}

int main(){
    //initialize an empty linked list
    struct Node* head = NULL;
    insert(&head, 1234);
    insert(&head, 123);
    insert(&head, 12);
    insert(&head, -1);
    insertNum(&head,-2);
    printList(head);
    int t=deleteNode(&head);
    struct Node* head2 = NULL;
    insert(&head2, 8);
    insert(&head2, 9);
    insert(&head2, 111);
    insert(&head2, 100);
    printList(head2);
    concatenate(head, head2);
    printList(head);
    return 0;
}