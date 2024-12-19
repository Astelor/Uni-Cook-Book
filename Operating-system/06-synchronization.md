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


## 6.1.a producer-consumer problem

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

## 6.1.b race condition

- concurrent processes operation on a shared variable
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
T0: producer reg1  = count     [reg1 = 5]
T1: producer reg1  = reg1 + 1  [reg1 = 6]
T2: consumer reg2  = count     [reg2 = 5]
T3: consumer reg2  = reg2 - 1  [reg2 = 4]
T4: producer count = reg1      [count = 6]
T5: consumer count = reg2      [count = 4]
```

- `count` = 4 instead of 5, the correct result
- to prevent this, one should make sure only one process gets exclusive access to operate on shared variable
  - > so they don't interweave
  - ---> thus the "synchronization"

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

## 6.2.a requirement to a solution (of the critical section problem)

- **mutual exclusion**
  - only one process is allowed to execute in its CS
- **progress**
  - if no process is in its CS
    - ---> a process wish to enter the CS
    - ---> processes that are *not* in *remainder* section can participate in deciding which process gets its turn
      - processes that are in *entry* section or above it
    - ---> the decision must be made in limited amount of time (not indefinitely)
    - ---> then one process enters the CS and *does some work*
  - if a process is in its CS
    - ---> the process *does some work*
  - > the processes are "progressing" since *work is getting done*
- **bounded waiting**
  - a limited number of times other processes are allowed to enter their CS after a process has made a request to enter its CS *and* before that request is granted
  - > meaning when P made a request, A B C cannot camp the CS forever and block P forever. 
  - pretext:
    - assuming process executes at a nonzero speed
    - no assumption concerning the relative speed of the processes

[stackoverflow:what-is-progress-and-bounded-waiting-in-critical-section](https://stackoverflow.com/questions/33143779/what-is-progress-and-bounded-waiting-in-critical-section)

## 6.2.b environment when dealing with the CS problem

- **core**:
  - **single core**
    - disable interrupts and preemption
  - **multiple cores** (multiprocessor)
    - resource locks
- **kernel**:
  - **non-preemptive kernel**
    - not allowing a process running in *kernel mode* to be preempted
      - a kernel-mode process will run until...
        - exit kernel mode
        - blocks
        - voluntarily yields control of the CPU
    - free from race condition
      - only one process is active in the kernel at a time
    - bad response time and real-time programming
      - one process may run for a long time
  - **preemptive kernel**
    - allows a process running in *kernel mode* to be preempted
    - ensuring shared kernel data is free from race conditions

## 6.2.c kernel race condition

- **example 1**:
  - a kernel data structure that maintains *a list of all open files* in the system
  - if two processes were to open files simultaneously
  - ---> race condition
- **example 2**:
  - kernel variable `next_available_pid`
    - next available process identifier
  - without mutual exclusion (to this shared variable)
  - ---> two processes could be assigned the same pid
- the CS/ race condition problem is the *application and kernel developers' problem*

# 6.3 Peterson's solution

- classic **software-based** solution
  - software-based solution *does not work* on *modern computer architectures*
- restricted to *two process*
- assume that `LOAD` and `STORE` instructions are *atomic*
- shared variable
```c
int turn
bool flag[2]
```
- `turn` indicates whose turn it is the enter the CS
- `flag[]` indicate if a process is ready to enter the CS
  - `flag[k] = true` -> ready 
  - initializes to `false`

**process Pi**
```c
while(true){
  flag[i] = true;
  turn = j;
  while (flag[j] && turn == j);
    /* critical section */
  
  flag[i] = false

    /* remainder section */
}
```

**process Pj**
```c
while(true){
  flag[j] = true;
  turn = i;
  while (flag[i] && turn == i);
    /* critical section */
  
  flag[j] = false

    /* remainder section */
}
```

## 6.3.a proving the correctness of Peterson's solution

- **mutual exclusion**
  - there could only be one value for `turn`
  - even when both process executes concurrently, `turn` will eventually be assign to either `i` or `j`, depends on the machine code.
  - one process will go into while-loop 
  - one process will go into its CS
- **progress** & **bounded waiting**
  - when `Pj` leaves its CS, it sets `flag[j] = false` 
  - allowing `Pi` to enter its CS
    - no matter if `Pi` is spinning in the while-loop or not
  - `Pj` can enter its CS again when `flag[i] = false`  

```c
flag[j] = true;
flag[i] = true;
turn = i;
while (flag[i] && turn == i); //spins first
turn = j;
while (flag[j] && turn == j); //spins
// freeing Pj -> Pj goes into CS
```

## 6.3.b modern computer architecture on Peterson's solution

- processors and/or compilers may *reorder read and write operations* that have *no dependencies*
- **single-threaded** application
  - not a problem
- **multithreaded** application
  - with shared data -> inconsistent or unexpected results

**reordering the first two statements**:
```c
turn = i;
flag[j] = true;
```

**effect of instruction reordering in Peterson's solution**
```c
turn = i;
turn = j;
flag[i] = true;
while (flag[j] && turn == j); // flag[j]=false, Pi goes into CS
flag[j] = true;
while (flag[i] && turn == i); // turn = j, Pj goes into CS
// Pi and Pj are in CS -> race condition
```

# 6.4 hardware support for synchronization

- software-based solutions are not guaranteed to work on modern computer architectures

## 6.4.1 memory barriers

### 6.4.1.a memory model
- how a computer architecture determines what memory guarantees it will provide to an application program
- vary by processor type
1. **strongly ordered**
   - *memory modification* on one processor is *immediately visible to all* other *processors*
2. **weakly ordered**
   - modification to memory on one processor may *not be immediately visible* to other processors

### 6.4.1.b memory barrier or memory fences

- `memory_barrier()`
- the system ensure that all *loads and stores* are *completed* before any subsequent load or store operations are performed
- considered very low-level operation


```c
while (!flag);
memory_barrier();
print x;
```

```c
x = 100;
memory_barrier();
flag = true;
```

- ensure `x = 100` occurs before `flag = true`
- ensure `while (!flag);` occurs before `print x`

## 6.4.2 hardware instructions

- atomic hardware instructions
  - atomic = non-interruptible
- `test_and_set()`
- `compare_and_swap()`

### test_and_set()

**primitive**:
```c
bool test_and_set(bool *target) {
  bool rv = *target;
  *target = true;

  return rv;
}
```

**mutual-exclusion implementation**:
```c
do {
  while (test_and_set(&lock))
    ; /* do nothing */

    /* critical section */
  
  lock = false;
  
    /* remainder section */
} while (true);
```

### compare_and_swap

- aka CAS instruction

**primitive**:
```c
int compare_and_swap(it *value, int expected, int new_value) {
  int temp = *value;

  if (*value == expected)
    *value = new_value;
  
  return temp;
}
```
**mutual-exclusion implementation**:
```c
while (true) {
  while (compare_and_swap(&lock, 0, 1) != 0)
    ; /* do nothing */
    /* critical section */
    
    lock = 0;
    
    /* remainder section */
}
```
- operation:
  - when `lock == 1`
    - `compare_and_swap(&lock, 0, 1)` returns 1, and keep spinning in the while-loop
  - when `lock == 0`
    - `compare_and_swap(&lock, 0, 1)` returns 0, sets `lock = 1`, and leaves the while-loop
- does not meet the **bounded-waiting** requirement
  - does not hand over to a particular waiting process
  - a same set of process can camp CPU forever 


**bounded-waiting mutual exclusion**:
```c
bool waiting[n];
int lock;
```
```c
while (true) {
  waiting[i] = true;
  key = 1;
  while (waiting[i] && key == 1)
    key = compare_and_swap(&lock, 0, 1);
  waiting[i] = false;

  /* critical section */

  j = (i % 1) % n;
  while( ( j != i ) && !waiting[j])
    j = (j + 1) % n;

  if (j == i)
    lock = 0;
  else
    waiting[j] = false;

  /* remainder section */
}
```
- yes **bounded-waiting**
  - scans `waiting[]` and let the "next" waiting process by setting its `waiting` to false
  - if there's no other process waiting, it sets `lock = 0`, allowing future requesting processes to enter CS
  - when `waiting[i] == true`
    - if `lock == 1`
      - `key = compare_and_swap(&lock, 0, 1) == 1`
      - stays in the while-loop
    - if `lock == 0`
      - `key = compare_and_swap(&lock, 0, 1) == 0`
      - leaves the while-loop

## 6.4.3 atomic variables

- atomic operation on basic data types
  - such as integers and booleans
- often implemented using `compare_and_swap()`
- such tool do not entirely solve race conditions
  - two consumers that leaves while-loop when `count>0` may enter CS when there's only one item in the buffer

```c
increment(&sequence)
```
```c
void increment (atomic_int *v)
{
  int temp;
  do {
    temp = *v;
  }
  while (temp != compare_and_swap(v, temp, temp+1));
}
```

- operation:
  1. it'll leave the while-loop after incrementing v by one
  2. if `temp` was *modified unexpectedly* before the executing the while-loop condition check
  3. `compare_and_swap(v, temp, temp+1)==*v != temp`
  4. it'll retry and go back to `temp = *v`

# 6.5 mutex locks

- hardware-based solution is...
  - complicated
  - generally inaccessible to application programmers
- "**locks**"
  - higher-level software tools
  - built by operation-system designers

**solution to CS using mutex lock**:
```c
while (true) {
  [acquire lock]
    critical section
  [release lock]
    remainder section
}
```

**primitives**:
```c
acquire() {
  while (!available)
    ; /* busy wait */
  available = false;
}
```
```c
release() {
  available = true;
}
```
- `acquire()`: acquires the lock, unavailable the lock
  - processes attempting the acquire an unavailable lock is blocked
- `release()`: releases the lock, available the lock
- `bool available`: indicates if the lock is available or not
- aka a **spin-lock**
  - no context switch is required when a process must wait on a lock
  - beneficial when held for a short duration
    - about less than two context switches

# 6.6 semaphore

- an integer variable
- accessed only through *standard atomic operations*
  - `wait()`
  - `signal()`

**primitives** (atomic):
```c
wait (S) {
  while (S <= 0)
    ; // busy wait
  S--;
}
```
```c
signal (S) {
  S++;
}
```

## 6.6.1 semaphore usage

- **binary semaphore**
  - value = 0 or 1
  - like mutex locks
- **counting semaphore**
  - value = unrestricted
  - control access to a given resource consisting of a finite number of instances
  - initialized to the number of resources available
  - `wait()` decrements the semaphore
  - `signal()` increments the semaphore

**process 1**
```
S1;
signal(synch);
```

**process 2**
```
wait(synch);
S2;
```

- `synch` is initialized to 0
- P2 will execute `S2` when P1 invokes `signal(synch)`

## 6.6.2 semaphore implementation



## deadlock characterization

> this is discussed in depth in [chapter 8](08-deadlock.md)

- **mutual exclusion**
- **hold and wait**
- **no preemption**
- **circular wait**

# glossary
- CS: critical section
- CAS: compare_and_swap