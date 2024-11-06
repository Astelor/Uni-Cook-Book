# chapter 4, threads and concurrency

> the APIs abstract the concept of creating threads for developers

**table of content**
- [chapter 4, threads and concurrency](#chapter-4-threads-and-concurrency)
- [4.1 overview](#41-overview)
  - [4.1.1 motivation](#411-motivation)
  - [4.1.2 benefits](#412-benefits)
- [4.2 multicore programming](#42-multicore-programming)
  - [4.2.1 programming challenges](#421-programming-challenges)
  - [4.2.2 types of parallelism](#422-types-of-parallelism)
- [4.3 multithreading models](#43-multithreading-models)
  - [4.3.1 many-to-one model](#431-many-to-one-model)
  - [4.3.2 one-to-one model](#432-one-to-one-model)
  - [4.3.3 many-to-many model](#433-many-to-many-model)
    - [two-level model](#two-level-model)
- [4.4 thread libraries](#44-thread-libraries)
  - [4.4.1 Pthreads](#441-pthreads)
  - [4.4.2 Java threads](#442-java-threads)
- [4.5 implicit threading](#45-implicit-threading)
  - [4.5.1 thread pools](#451-thread-pools)
  - [4.5.2 fork join](#452-fork-join)
  - [4.5.3 OpenMP](#453-openmp)
- [glossary](#glossary)

# 4.1 overview

- **thread**
  - basic unit of CPU utilization
  - comprises of:
    1. a thread ID
    2. a program counter (PC)
    3. a register set
    4. a stack 
- **single-threaded** process
  - traditional
- **multithreaded** process

## 4.1.1 motivation

> take a server as an example

- generally more efficient to use *one process* that *contains multiple threads*
- applications designed to leverage processing capabilities on multicore systems

```
[client]
 |
 | (1) request
 ↓
[server] (3) resume listening for additional client requests
 |
 | (2) create new thread to service the request
 ↓
[thread]
```

## 4.1.2 benefits

> in multithreading

1. **responsiveness**
   - allowing a program to *continue running* even if part of it is blocked
   - useful in *designing user interfaces*
2. **resource sharing**
   - threads share the memory and resources of the process they belonged to by default
   - allow an application to have several different threads within the same address space
3. **economy**
   - thread creation consumes less time and memory than process creation
4. **scalability**

# 4.2 multicore programming

- **multicore** system
  - multiple computing cores on a *single processing chip*
  - ---> each core appears as a *separate CPU* to the operating system
- **concurrency**
  - supports more than one task by allowing *all the tasks to make progress*
  - it's possible to have *concurrency* without *parallelism*
    - by process scheduling and switching
- **parallelism**
  - perform more than one task *simultaneously*

## 4.2.1 programming challenges

- **operating system designers**
  - scheduling algorithms that use multiple processing cores
- **application programmers**
  - modify existing programs + design new programs that are multithreaded

---

1. **identifying tasks**
   - find areas in applications that can be divided into separate, concurrent tasks
   - independent tasks so they can run in parallel
2. **balance**
   - tasks perform equal work of equal time
   - some tasks are not critical enough to overall process, thus not worthy enough to be running in another execution core
3. **data splitting**
   - data accessed and manipulated by the tasks must be divided to run on separate cores
4. **data dependency**
   - data accessed by the tasks must check for dependencies between two or more tasks
   - programmers ensuring that the execution of the tasks is synchronized
5. **testing and debugging**
   - when a program is running in parallel on multiple cores, *many different execution paths are possible*
     - thus making it more difficult to test and debug

## 4.2.2 types of parallelism

- **data parallelism**
  - distributing *subsets of the same data* across multiple cores
  - performing the *same operation on each cores*
- **task parallelism**
  - distributing *tasks* (threads) across multiple cores
  - each thread is performing a *unique operation*
  - *different threads may be operating on the same data*

# 4.3 multithreading models

- **user threads**
  - supported above the kernel
  - managed without kernel support
- **kernel threads**
  - supported and managed directly by the operating system
  - all contemporary operating systems support kernel threads


## 4.3.1 many-to-one model

- maps **many user threads** to **one kernel threads**
  - only one thread can access the kernel at a time
- **thread management** is done by the *thread library in user space* so it is *efficient*
- **con**:
  - entire process will block if a thread makes a blocking system call
  - multiple threads are unable to run in parallel on multicore systems
- very few system continue to use this model
  - inability to take advantage of multiple processing cores

## 4.3.2 one-to-one model

- maps **each user thread** to **a kernel thread**
  - more concurrency than *many-to-one*
- **con**:
  - creating a *user thread* requires creating the corresponding *kernel thread*
    - large number of *kernel threads* may burden the performance of a system
- > Linux and Windows operating systems implement the one-to-one model
- the increasing number of processing cores make limiting the number of kernel threads less important
  - *most operating systems now use the one-to-model*

## 4.3.3 many-to-many model

- multiplexes *many user threads* to a *smaller or equal number of kernel threads*
  - the number of kernel threads may be specific to either a particular application or machine 
    - (more kernel threads may be allocated to an application on a system with 8 cores than 4 cores)
- **con**:
  - not really

### two-level model

- variation to the many-to-many model
- allow a *user-level thread* to be **bound** to a *kernel thread*

# 4.4 thread libraries

- API for creating and managing threads
- primary ways of implementation
  1. **a library entirely in user space** with no kernel support
     - invoking a function in the library → *local function call* in user space
  2. **a kernel-level library supported directly by the operating system**
     - invoking function in API → *system call* to the kernel
- main thread libraries in use today
  1. POSIX Pthreads
  2. Windows
  3. Java

- **asynchronous threading**
  - parent and child execute concurrently and independently of one another
  - *little data sharing* in between
- **synchronous threading**
  - parent thread creates children and then must *wait for all of its children to terminate* before it resumes
    - threads created by the parent perform work concurrently
  - only after *all of the children have joined* can the parent resume execution
  - *significate data sharing* among threads

## 4.4.1 Pthreads

- POSIX standard (IEEE 1003.1c) defining an API for thread creation and synchronization
- a *specification* not an implementation
- may be provided either as user-level or kernel-level
- common in UNIX systems

## 4.4.2 Java threads

- Java threads are managed by the JVM
- typically implemented using the threads model provided by underlying OS
- Java threads may be created by:
  - extending thread class
  - implementing the Runnable Interface

```java
public interface Runnable{
    public abstract void run();
}
```

# 4.5 implicit threading

- transfer the creation and management of threading from application developers to compilers and run-time libraries
- methods
  1. thread pools
  2. OpenMP
  3. grand central dispatch
  - other methods:
    - microsoft threading building blocks (TBB)
    - java.util.concurrent package

## 4.5.1 thread pools

- *create a number of threads at start-up* and place them in a pool where they *await work*
- **pro**:
  1. *faster* to service a request with an existing thread than create a new thread
  2. *limits the number of thread* that exist at any one point
  3. *separating task to be performed* from *mechanics of creating task* allows us to use different strategies for running task
     - e.g. tasks could be scheduled to run periodically
- the *number of threads* in the pool *can be set heuristically* based on *factors*
  - e.g.
  - number of CPUs in the system
  - amount of physical memory
  - expected number of concurrent client requests
- windows API supports thread pools
```c
DWORD WINAPI PoolFunction(AVOID Param){
    /*
    this function runs as a separate thread
    */
}
```

> astelor: honestly all the API stuff are kinda confusing without some hand-on experience

## 4.5.2 fork join

> "the strategy for thread creation covered in [section 4.4](#44-thread-libraries)" aka **fork-join** model

- the main parent thread *forks* child threads and then waits for the children to terminate and *join* with it
- a synchronous model
- explicit thread creation
- synchronous version of thread pools

## 4.5.3 OpenMP

- a set of compiler directives and an API for programs written in C, C++, or FORTRAN

# glossary

- JVM: java virtual machine