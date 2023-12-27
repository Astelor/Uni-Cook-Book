#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#define TREE_SIZE 10
#define max 99
#define min 1
#define print_spacing 5
// TREEEEEEEEEEEEEEEEEEEEEEEEEEEEEE
// but linked
// frick

/*
1.	Write a program including the following steps 
(2) using linked implementation of trees
(a) Use rand()%100+1 to get 10 random numbers, output the numbers 
    (one by one, one space in between, and 5 numbers in one line), 
    insert the numbers into a created highly skewed tree one by one immediately.
    (each node has one child)

(b) output the data in the tree nodes one by one in preorder.
(c) output the data in the tree nodes one by one in inorder.
(d) output the data in the tree nodes one by one in postorder.
(e) output the data in the tree nodes one by one in levelorder.
(f) output the data in the tree nodes one by one in inorder (using iterative inorder traversal).

*/


struct TreeNode{
    int data;
    struct TreeNode* left;
    struct TreeNode* right;
};

struct TreeNode* createNode(int data){
    struct TreeNode* newNode = (struct TreeNode*)malloc(sizeof(struct TreeNode));
    if(newNode==NULL) exit(EXIT_FAILURE);

    newNode->data=data;
    newNode->left = NULL;
    newNode->right = NULL;
    return newNode;
}

struct TreeNode* insertNode(struct TreeNode* root, int data){
    if(root==NULL){
        //create a new node if the tree is empty
        return createNode(data);
    } else{
        // we want a "highly skewed" tree, in this case, we let it skewed to the right
        root->right = insertNode(root->right, data);

        /*// place to left/right judging from if it's smaller or larger than the current node
        if(data <= root ->data){
            // recursively insert into the left or right subtree
            root->left = insertNode(root->left, data);
        } else{
            root->right = insertNode(root->right, data);
        }*/
        return root;
    }
}
int count=0;

// recursive traversals-----------------------------------------------------------------|
void preorderTraversal(struct TreeNode* root){
    if(root!=NULL){
        printf("%2d ", root->data);
            if((++count)%print_spacing==0) printf("\n");
        preorderTraversal(root->left);
        preorderTraversal(root->right);
    }
}

void inorderTraversal(struct TreeNode* root){
    if(root!= NULL){
        inorderTraversal(root->left);
        printf("%2d ", root->data);
            if((++count)%print_spacing==0) printf("\n");
        inorderTraversal(root->right);
    }
}

void postorderTraversal(struct TreeNode* root){
    if(root!=NULL){
        postorderTraversal(root->left);
        postorderTraversal(root->right);
        printf("%2d ", root->data);
            if((++count)%print_spacing==0) printf("\n");
    }
}

// iterative traversals-----------------------------------------------------------------|
struct StackNode{
    struct TreeNode* node;
    struct StackNode* next;
};
struct TreeNode* pop(struct StackNode** top){
    if(*top == NULL) return NULL;
    struct TreeNode* poppedNode = (*top)->node;
    struct StackNode* temp = *top;
    *top = (*top)->next;
    free(temp);
    return poppedNode;
}
void push(struct StackNode** top, struct TreeNode* node) {
    struct StackNode* newNode = (struct StackNode*)malloc(sizeof(struct StackNode));
    if (newNode == NULL) {
        // Handle memory allocation failure
        exit(EXIT_FAILURE);
    }
    newNode->node = node;
    newNode->next = *top;
    *top = newNode;
}

void iterPreorderTraversal(struct TreeNode* root){
    if(root == NULL) return;

    struct StackNode* stack = NULL;
    push(&stack, root);

    while (stack != NULL) {
        struct TreeNode* current = pop(&stack);
        printf("%2d ", current->data);
            if((++count)%print_spacing==0) printf("\n");

        // Push the right child first (to be processed later)
        if (current->right != NULL) {
            push(&stack, current->right);
        }

        // Push the left child (to be processed next)
        if (current->left != NULL) {
            push(&stack, current->left);
        }
    }
    count=0;
}

void iterInorderTraversal(struct TreeNode* root) {
    if (root == NULL) {
        return;
    }
    struct StackNode* stack = NULL;
    struct TreeNode* current = root;

    while (current != NULL || stack != NULL) {
        // Traverse to the leftmost leaf
        while (current != NULL) {
            push(&stack, current);
            current = current->left;
        }

        // Visit the current node
        current = pop(&stack);
        printf("%2d ", current->data);
            if((++count)%print_spacing==0) printf("\n");

        // Move to the right subtree
        current = current->right;
    }
    count=0;
}

void iterPostorderTraversal(struct TreeNode* root) {
    if (root == NULL) {
        return;
    }
    struct StackNode* stack = NULL;
    struct TreeNode* current = root;
    struct TreeNode* lastVisited = NULL;

    while (current != NULL || stack != NULL) {
        // Traverse to the leftmost leaf
        while (current != NULL) {
            push(&stack, current);
            current = current->left;
        }

        // Peek at the top of the stack
        struct TreeNode* peekNode = stack->node;

        // If the right child exists and hasn't been processed yet, move to the right
        if (peekNode->right != NULL && peekNode->right != lastVisited) {
            current = peekNode->right;
        } else {
            // Visit the current node and mark it as visited
            printf("%2d ", peekNode->data);
                if((++count)%print_spacing==0) printf("\n");
            lastVisited = pop(&stack);
        }
    }
    count=0;
}

void iterLevelOrderTraversal(struct TreeNode* root) {
    if (root == NULL) {
        return;
    }

    struct StackNode* currentLevel = NULL;
    struct StackNode* nextLevel = NULL;

    // Enqueue the root node
    push(&currentLevel, root);

    while (currentLevel != NULL) {
        // Dequeue a node and print its value
        struct TreeNode* current = pop(&currentLevel);
        printf("%2d ", current->data);
            if((++count)%print_spacing==0) printf("\n");

        // Enqueue the left child to the next level
        if (current->left != NULL) {
            push(&nextLevel, current->left);
        }

        // Enqueue the right child to the next level
        if (current->right != NULL) {
            push(&nextLevel, current->right);
        }

        // Move to the next level when the current level is empty
        if (currentLevel == NULL) {
            // Swap currentLevel and nextLevel
            struct StackNode* temp = currentLevel;
            currentLevel = nextLevel;
            nextLevel = temp;
            //printf("\n");  // Move to the next line for the next level
        }
    }
    count=0;
}

// data adding and deleting functions---------------------------------------------------|
struct TreeNode* emplaceTree(struct TreeNode* root){
    int i;
    for(i=0;i<TREE_SIZE;i++){
        int random_number=rand()%100+1;
        root=insertNode(root,i+1);
    }
    return root;
}

// this is a helper for freeTree
void helperFree(struct TreeNode* root){
    if(root!=NULL){
        helperFree(root->left);
        helperFree(root->right);
        free(root);
    }
}
struct TreeNode* freeTree(struct TreeNode* root){
    helperFree(root);
    return NULL;
}

int main(){
    struct TreeNode* new_tree = NULL;
    int input;
    /*while(1){
	    scanf("%d",&input);
        insertNode(new_tree,input);
    }*/
    srand(time(NULL));
    new_tree=emplaceTree(new_tree);
    preorderTraversal(new_tree); count=0;
    iterPreorderTraversal(new_tree);

    inorderTraversal(new_tree); count=0;
    iterInorderTraversal(new_tree);

    postorderTraversal(new_tree); count=0;
    iterPostorderTraversal(new_tree);
    iterLevelOrderTraversal(new_tree);
    //new_tree=freeTree(new_tree);
    
    return 0;
}