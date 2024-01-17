#include <stdio.h>
#include <stdlib.h>

// turns out chatGPT is quite usefull if you ask the right question
// Node structure
typedef struct Node *listPointer;
struct Node {
    int data;
    listPointer next;
};

// Stack structure
struct LinkedListStack {
    listPointer top;
};

// Function to check if the stack is empty
int is_empty(struct LinkedListStack* stack) {
    return stack->top == NULL;
}

// Function to push a new element onto the stack
void push(struct LinkedListStack* stack, int data) {
    listPointer new_node = (listPointer)malloc(sizeof(struct Node));
    if (!new_node) {
        printf("Memory allocation failed. Exiting.\n");
        exit(EXIT_FAILURE);
    }

    new_node->data = data;
    new_node->next = stack->top;
    stack->top = new_node;
}

// Function to pop an element from the stack
int pop(struct LinkedListStack* stack) {
    if (is_empty(stack)) {
        printf("Stack is empty. Cannot pop.\n");
        exit(EXIT_FAILURE);
    }

    listPointer temp = stack->top;
    int popped_data = temp->data;
    stack->top = temp->next;
    free(temp);

    return popped_data;
}

// Function to display the elements in the stack
void display(struct LinkedListStack* stack) {
    listPointer current = stack->top;
    while (current) {
        printf("%d -> ", current->data);
        current = current->next;
    }
    printf("NULL\n");
}

int main() {
    // Create an empty stack
    struct LinkedListStack stack;
    stack.top = NULL;
    int text, data;
    printf("0 -> insert data\n1 -> delete data\n2 -> show the current list\nplease enter an command...");
    while(1){
        scanf("%d",&text);
        switch (text)
        {
        case 0:{
            printf("enter an integer data: ");
            scanf("%d",&data);
            push(&stack,data);
            break;
        }
        case 1:{
            printf("Deleted item-> %d\n",pop(&stack));
            break;
        }
        case 2:{
            printf("show the list\n");
            display(&stack);
            break;
        }
        default:
            printf("not an available command!\n");
            break;
        }
}


    // Push some elements onto the stack
    /*push(&stack, 1);
    push(&stack, 2);
    push(&stack, 3);

    // Display the stack after push operations
    printf("Stack after push operations:\n");
    display(&stack);

    // Pop an element from the stack
    int popped_item = pop(&stack);
    printf("Popped item: %d\n", popped_item);

    // Display the stack after pop operation
    printf("Stack after pop operation:\n");
    display(&stack);*/

    return 0;
}
