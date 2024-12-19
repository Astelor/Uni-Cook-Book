# include "buffer.h"
# include <stdio.h>
# include <stdlib.h>

buffer_item buffer[BUFFER_SIZE] = {0};
// static indices for the circular buffer
static int front = 0, rear = 0, TotalinQueue = 0;

// check if the buffer is empty
int empty() { return (TotalinQueue == 0); }

// check if the buffer is full
int full() { return(TotalinQueue == BUFFER_SIZE); }

// insert an item into the buffer
int insert_item(buffer_item item){
    // note: the buffer_item is int, "item" is int
    if(full()) return -1; // return error if buffer is full
    // put the item into queue
    buffer[rear] = item;
    rear = (rear+1)%BUFFER_SIZE;
    TotalinQueue++; // increment the counter of items in the buffer
    return 0; // return success
}

int remove_item(buffer_item *item){
    // note: "*item" is a pointer, this things gives us an address
    if(empty()) return -1; // return error if buffer is empty
    // get the item from queue 
    *item = buffer[front];
    front = (front+1)%BUFFER_SIZE;
    TotalinQueue--; // decrement the counter of items in the buffer
    return 0; // return success
}