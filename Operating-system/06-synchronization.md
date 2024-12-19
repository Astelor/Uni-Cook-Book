# chapter 6, synchronization tools

# 6.1 background 

- **why synchronizing?**
  - processes can execute *concurrently* or in *parallel*
    - scheduler may *interrupt* the process
    - process may *partially complete execution*
  - leading to issues on *integrity* of process-shared data
- **what to do to synchronize**
  - ensure cooperating *sequential* process
    - 
  - (make sure they execute in the intended order)


## producer-consumer problem

- also a bounded buffer problem described in [ch3 buffer types](03-processes.md#buffer-types)
- the buffer is implemented a circular queue
- uses a counter to track the number of elements
- the processes here may *not function correctly* if *executed concurrently*
  - > shared variable being executed concurrently, causing its machine code to be interweaved.

**producer process**:
```c
while(true){
    /* produce an item in next_produced */
    while(count == BUFFER_SIZE);
        /* do nothing */
    buffer[in] = next_produced;
    in = (in+1) % BUFFER_SIZE;
    count++;
}
```

**consumer process**:
```c
while(true){
    while(count == 0);
        /* do nothing */
    next_consumed = buffer[out];
    out = (out+1) % BUFFER_SIZE;
    count--;
    /* consume the item in next_consumed */
}
```

**shared data**:
```c
#define BUFFER_SIZE 10
typedef struct{
    
} item;
item buffer[BUFFER_SIZE];
int in = 0, out = 0, counter = 0;
```

## race condition

- operating on a shared variable concurrently
- ---> interweaving of machine code
- ---> inconsistent result of the shared variable
  - the exact outcome depends on the particular order of the machine code

**low level implementation on the statement `count++`**:
```
reg1 = count
reg1 = reg1 + 1
count = reg1
```

**low level implementation on the statement `count--`**
```
reg2 = count
reg2 = reg2 - 1
count = reg2
```

**concurrent execution of `count++` and `count--`**
```
T0: producer reg1 = count     [reg1 = 5]
T1: producer reg1 = reg1 + 1  [reg1 = 6]
T2: consumer reg2 = count     [reg2 = 5]
T3: consumer reg2 = reg2 - 1  [reg2 = 4]
T4: producer count = reg1     [count = 6]
T5: consumer count = reg2     [count = 4]
```

- `count` = 4 instead of 5, the correct result
- to prevent this, one should make sure only one process gets exclusive access to operate on shared variable
  - > so they don't interweave

# 6.2 the critical-section problem

- **critical section**:
  - a segment of code that operate on *shared variable*
  - the problem:
    - to design a protocol that synchronize the processes' activity
- **protocol**:
  - **entry** section
  - *critical* section
  - **exit** section
  - *remainder* section
    - can contain any code
- **requirement to a solution** (of the critical section problem):
  - **mutual exclusion**
    - only one process is allowed to execute in its CS
  - **progress**
    - 
    - if no process is in its CS
      - a process wish to enter the CS
      - processes that are *not* in *remainder* section can participate in deciding which process gets its turn
        - processes that are in *entry* section or above it
      - the decision must be made in limited amount of time (not indefinitely)
      - then one process enters the CS and *does some work*
    - if a process is in its CS
      - it *does some work*
    - the processes are "progressing" since *work is getting done*
  - **bounded waiting**

[stackoverflow:what-is-progress-and-bounded-waiting-in-critical-section](https://stackoverflow.com/questions/33143779/what-is-progress-and-bounded-waiting-in-critical-section)

## deadlock characterization

- **mutual exclusion**
- **hold and wait**
- **no preemption**
- **circular wait**


# glossary
- CS: critical section