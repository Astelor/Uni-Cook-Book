# quick notes
fricking frick :<
## Question 1-1
Tree traversal with array implementation.
The generated tree is a full binary tree (I think)



```
a level 4 complete tree
       0
     /   \
    1     2
   / \   /  \
  3   4 5    6
 / \
7   8
```
### Preorder
-> 0, 1, 3, 7, 8, 4, 2, 5, 6 

```
preorder tree traversal
       0
     /   \
    1     6
   / \   /  \
  2   5 7    8
 / \
3   4
```
### Inorder
-> 7 3 8 1 4 0 5 2 6

```
inorder tree traversal
       5
     /   \
    3     7
   / \   /  \
  1   4 6    8
 / \
0   2
```
### Posterorder
1. go down the left subtree until the node has no subtree (7)
2. 
-> 7 8 3 4 1 5 6 2 0

```
postorder tree traversal
       8
     /   \
    4     7
   / \   /  \
  2   3 5    6
 / \
0   1
```
## Questino 1-2
Tree traversal with linked list implementation.
