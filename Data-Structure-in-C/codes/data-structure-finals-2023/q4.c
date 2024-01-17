#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#define TREE_SIZE 50
#define max 100
#define min 1
#define print_spacing 10
// TREEEEEEEEEEEEEEEEEEEEEEEEEEEEEE
// in array
// 411440117 Aster Chen

void createTree(int tree[]){
    int i;
    for(i=0;i<TREE_SIZE;i++){
        int random_number=rand()%(max - min +1) + min; //max~min
        tree[i] = random_number/*i*/; // debug  here
    }
}

int count=0;

// 0: as a simple array. 1: preorder. 2: inorder. 3: postorder **4: levelorder**
// recursive method except case 0 and 4 ------------------------------------------------|
void printTREE(int tree[], int query_method, int rootIndex){
    int i;
    switch (query_method)
    {
    case 0:
        for(i=0;i<TREE_SIZE;i++){
            printf("%2d ", tree[i]);
            if((++count)%print_spacing==0) printf("\n");
        }
        count=0;
        break;
    case 1: // preorder
        if(rootIndex < TREE_SIZE && tree[rootIndex] != -1){
            printf("%2d ", tree[rootIndex]);
            if((++count)%print_spacing==0) printf("\n");

            printTREE(tree, 1, 2 * rootIndex+1);
            printTREE(tree, 1, 2 * rootIndex+2);
        }
        break;
    case 2: // inorder
        if(rootIndex < TREE_SIZE && tree[rootIndex] != -1){
            printTREE(tree, 2, 2 * rootIndex+1);

            printf("%2d ", tree[rootIndex]);
            if((++count)%print_spacing==0) printf("\n");

            printTREE(tree, 2, 2 * rootIndex+2);
        }// 411440117 Aster Chen
        break;
    case 3: // postorder 
        if(rootIndex < TREE_SIZE && tree[rootIndex] != -1){
            printTREE(tree, 3, 2 * rootIndex+1);
            printTREE(tree, 3, 2 * rootIndex+2);

            printf("%2d ", tree[rootIndex]);
            if((++count)%print_spacing==0) printf("\n");
        }
        break;
    case 4: // levelorder (breadth-first traversal)
        for(i=0;i<TREE_SIZE;i++){
            if(tree[i]!=-1){
                printf("%2d ", tree[i]);
                if((++count)%print_spacing==0) printf("\n");
            }
        }
        count=0;
        break;
    default:
        printf("undefined method\n");
        exit(4);
        break;
    }
}

// 1: preorder. 2: inorder. 3: postorder
// iterative method --------------------------------------------------------------------|
void iterPrintTREE(int tree[], int query_method){
    int stack[TREE_SIZE];
    int top = -1;     // stack top pointer
    int currentIndex = 0;
    int lastVisited = -1; // apparently dev cpp doesn't allow ANY inline declaration
    switch (query_method)
    { // 411440117 Aster Chen
    case 1: // preorder
        while(currentIndex < TREE_SIZE || top!=-1){
            if(currentIndex < TREE_SIZE && tree[currentIndex] != -1){
                printf("%2d ", tree[currentIndex]);
                if((++count)%print_spacing==0) printf("\n");
                // push teh right child onto the stack
                if( (2 * currentIndex + 2) < TREE_SIZE && tree[2*currentIndex+2]!=-1){
                    stack[++top] = 2 * currentIndex + 2;
                }
                // move to the left child
                currentIndex = 2 * currentIndex + 1;
            } else if(top!=-1){
                currentIndex = stack[top--];
            }
        }
        break;
    case 2: // inorder
        while(currentIndex < TREE_SIZE || top!=-1){
            // push all left children onto the stack
            while(currentIndex < TREE_SIZE && tree[currentIndex] != -1){
                stack[++top] = currentIndex;
                currentIndex = 2 * currentIndex + 1;
            }
            if(top!=-1){
                currentIndex = stack[top--];
                printf("%2d ", tree[currentIndex]);
                if((++count)%print_spacing==0) printf("\n");
                currentIndex = 2 * currentIndex + 2;
            }
        } 
        break;
    case 3: //postorder
        while(currentIndex < TREE_SIZE || top!=-1){
            if(currentIndex < TREE_SIZE && tree[currentIndex] != -1 ){
                stack[++top] = currentIndex;
                currentIndex = 2 * currentIndex +1;
            } else{
                int peekIndex = stack[top];
                if( (2* peekIndex + 2) < TREE_SIZE && lastVisited != 2 * peekIndex + 2
                    && tree[2*currentIndex+2]!=-1){
                    currentIndex = 2 * peekIndex +2 ;
                }else{
                    printf("%2d ", tree[peekIndex]);
                    if((++count)%print_spacing==0) printf("\n");
                    lastVisited = stack[top--];
                }
            }
        }
        break;
    default:
        printf("undefined method\n");
        exit(4);
        break;
    }
    count=0;
}// 411440117 Aster Chen
// idividual functions here... ---------------------------------------------------------|
void iterPreorderTraversal(int tree[]){
    int stack[TREE_SIZE];
    int top=-1;
    int currentIndex = 0;
    while(currentIndex < TREE_SIZE || top!=-1){
        if(currentIndex < TREE_SIZE && tree[currentIndex] != -1){
            printf("%2d ", tree[currentIndex]);
                if((++count)%print_spacing==0) printf("\n");
            // push teh right child onto the stack
            if( (2 * currentIndex + 2) < TREE_SIZE && tree[2*currentIndex+2]!=-1){
                stack[++top] = 2 * currentIndex + 2;
            }
            // move to the left child
            currentIndex = 2 * currentIndex + 1;
        } else if(top!=-1){
            currentIndex = stack[top--];
        }
    }
    count=0;
}

void iterInorderTraversal(int tree[]){
    int stack[TREE_SIZE];
    int top = -1;     // stack top pointer
    int currentIndex = 0;
    while(currentIndex < TREE_SIZE || top!=-1){
        // push all left children onto the stack
        while(currentIndex < TREE_SIZE && tree[currentIndex] != -1){
            stack[++top] = currentIndex;
            currentIndex = 2 * currentIndex + 1;
        }
        if(top!=-1){
            currentIndex = stack[top--];
            printf("%2d ", tree[currentIndex]);
            if((++count)%print_spacing==0) printf("\n");
            currentIndex = 2 * currentIndex + 2;
        }
    } 
    count=0;
}// 411440117 Aster Chen

void iterPostorderTraversal(int tree[]){
    int stack[TREE_SIZE];
    int top = -1;
    int currentIndex = 0;
    int lastVisited = -1;
    while(currentIndex < TREE_SIZE || top!=-1){
        if(currentIndex < TREE_SIZE && tree[currentIndex] != -1 ){
            stack[++top] = currentIndex;
            currentIndex = 2 * currentIndex +1;
        } else{
            int peekIndex = stack[top];
            if( (2* peekIndex + 2) < TREE_SIZE && lastVisited != 2 * peekIndex + 2
                && tree[2*currentIndex+2]!=-1){
                currentIndex = 2 * peekIndex +2 ;
            }else{
                printf("%2d ", tree[peekIndex]);
                if((++count)%print_spacing==0) printf("\n");
                lastVisited = stack[top--];
            }
        }
    }
    count=0;
}

int main(){ // 411440117 Aster Chen
    int i;
    int binary_tree[TREE_SIZE]={};
    srand(time(NULL));
    createTree(binary_tree);
    // (1) immediate printing
    printf("(1) array\n");
    printTREE(binary_tree, 0, 0); count=0;
    
    // (2) preorder 
    printf("\n(2) preorder\n");
    printTREE(binary_tree, 1, 0); count=0;

    // (3) inorder
    printf("\n(3) inorder\n");
    printTREE(binary_tree, 2, 0); count=0;
	
    // (4) postorder
    printf("\n(4) postorder\n");
    printTREE(binary_tree, 3, 0); count=0;

    // (5) levelorder
    printf("\n(5) levelorder\n");
    printTREE(binary_tree, 4, 0); count=0;

    // (6) inorder iterative
    printf("\n(6) iterative inorder\n");
    iterInorderTraversal(binary_tree);
    return 0;
}
