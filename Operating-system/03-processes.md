# chapter 3, processes

**table of content**
- [chapter 3, processes](#chapter-3-processes)
- [3.4 interprocess communication](#34-interprocess-communication)
  - [process types](#process-types)
  - [interprocess communication models](#interprocess-communication-models)
- [3.5 IPC in shared-memory systems](#35-ipc-in-shared-memory-systems)
  - [producer and consumer](#producer-and-consumer)
  - [buffer types](#buffer-types)
- [3.6 IPC in message-passing systems](#36-ipc-in-message-passing-systems)
  - [3.6.1 naming](#361-naming)
    - [direct communication](#direct-communication)
    - [indirect communication](#indirect-communication)
      - [mailbox types](#mailbox-types)
  - [3.6.2 synchronization](#362-synchronization)
  - [3.6.3 buffering](#363-buffering)
- [3.7 examples of IPC systems](#37-examples-of-ipc-systems)
  - [3.7.1 POSIX shared memory](#371-posix-shared-memory)
  - [3.7.2 Mach message passing](#372-mach-message-passing)
  - [3.7.3 windows](#373-windows)
- [glossary](#glossary)

# 3.4 interprocess communication

> *placeholder*

## process types

- **independent** process
  - does not share data with any other processes (executing in the system)
- **cooperating** process
  - affect or be affected by the other processes
  - reasons for process cooperation:
    - **information sharing**
      - several applications may be interested in the same piece of information (e.g. copying and pasting)
    - **computation speedup**
      - breaking a task into subtasks to make it run faster
    - **modularity**
      - design choice to construct a system modularly, dividing system functions into separate processes or threads
  - require `interprocess communication` (IPC) mechanism

## interprocess communication models

- **shared memory**
  - establishing a region of memory shared by the `cooperating processes`
  - *faster* since no kernel intervention (system calls) is needed
  - > processes must agree to share the memory space to remove OS restriction of *process memory boundary*
- **message passing**
  - message exchanged between the `cooperating processes`
  - good for exchanging *smaller amount of data*
  - *easier to implement* in a distributed system
  - *slower* since it's implemented using system calls

# 3.5 IPC in shared-memory systems

- **the processes** are responsible for ensuring that they are not writing to the same location simultaneously (writing conflicts)
- the code for accessing and manipulating the shared memory is written explicitly by the application programmer
  - > so if it doesn't work or breaks, it's a skill issue

## producer and consumer

> also a client-server paradigm

- **producer** process
  - produces information
- **consumer** process
  - consumes information produced by the producer process
  
- for `producer` and `consumer` processes to run concurrently
  - **buffer** of items (that can be):
    - filled by the `producer`
    - emptied by the `consumer`
  - resides on the shared memory of `producer` and `consumer`

## buffer types

- **unbounded** buffer
  - *no limit* on the buffer size
  - the `producer` can always produce new items
- **bounded** buffer
  - assumes a *fixed* buffer size
  - the `producer` must wait if the buffer is full
  - the `consumer` must wait if the buffer is empty

# 3.6 IPC in message-passing systems

- **the operating system** is responsible for the IPC in the form if message passing
- message sizes types: (with trade-offs)
  - **fixed**
    - straight-forward system-level implementation
    - programming is more difficult
  - **variable**
    - more complex system-level implementation
    - programming is simpler
- **communication link** exist between processes
  - implementation method varies (physical or logical)
  - only the *logical implementation* is concerned here

## 3.6.1 naming

- processes must have a way to *refer to each other* to communicate
- can use either **direct** or **indirect** communication

### direct communication

- **symmetry** in addressing:
  - each process must **explicitly name** the recipient or sender of the communication
  - **primitives** for sending and receiving:
    - `send(P, message)`, send a message to process P
    - `receive(Q, message)`, receive a message from process Q
- **asymmetry** in addressing:
  - *only the sender names the recipient*
    - the recipient is not required to name the sender
  - **primitives** for sending and receiving:
    - `send(P, message)`, send a message to process P
    - `receive(id, message)`, *receive a message from any process*
      - `id` is set to the name of the process with which communication has taken place
- **communication link** properties:
  - link is established *automatically*
    - the processes need to *know only each other's identity* to communicate
  - a link is associated with exactly *two processes*
  - between a *pair of processes*, there exists exactly *one link*
---
- **disadvantage** in direct communication:
  - *limited modularity* of the resulting process definitions
    - when you change one definition, you need to change all of them manually
  - such **hard-coding** is less desirable comparing to *indirection*
    - e.g. the identifier must be explicitly stated

### indirect communication

- the messages are sent to and received from **mailboxes** (**ports**)
- **primitives** for sending and receiving:
  - `send(A, message)`, send a message to mailbox A
  - `receive(A, message)`, receive a message from mailbox A
- **communication link** properties:
  - a link is established between a pair of processes only if the they have a shared mailbox
  - a link my be associated with *more than two processes*
  - between a communicating pair, it can have *multiple links*, with each link corresponding to one mailbox
---
- the **design choice** decides which process can receive the message in a shared mailbox
  - allow at most two processes to be associated with a link
    - a sender and a recipient, no more conflict!
  - allow at most one process at a time to execute a `receive()`
    - one recipient at a time
  - allow the system to select arbitrarily which process will receive the message
    - the system has a mechanism to decide

#### mailbox types

- **mailbox owned by a process**
  - mailbox is a part of the address space of the process
  - ownership and user-ship:
    - owner: only receive message through this mailbox
    - user: only send messages to this mailbox
  - when a process terminates, the mailbox disappears
    - any process that sends messages to this mailbox must be notified that it no longer exists
- **mailbox owned by the operating system**
  - independent and *not attached to any particular process*
  - OS provided mechanism for processes:
    - create a new mailbox
    - send and receive messages through the mailbox
    - delete a mailbox
  - ownership & user-ship:
    - the *process that creates* the mailbox is the *owner by default*
    - the ownership and receiving *privilege may be passed* to other processes via system calls
      - could result in multiple receivers for each mailbox

## 3.6.2 synchronization

- **blocking** → synchronous
- **nonblocking** → asynchronous
---
- **send**
  - **blocking send** → the sending process is blocked until the message is received by the receiving process (or by the mailbox)
    - sender waits
  - **nonblocking send** → the sending process *resumes operation* after sending the message
    - sender doesn't wait
- **receive**
  - **blocking receive** → receiver blocks until a message is available
    - receiver waits
  - **nonblocking receive** → receiver retrieves either a *valid message or a null*
    - receiver doesn't wait
---
- different combinations of `send()` and `receive()` are possible
  - when both are blocking, we have a rendezvous between the sender and the receiver

## 3.6.3 buffering

- exchanged messages must reside in a *temporary queue*, which could be implemented in three ways:
  - **zero capacity**
    - the queue = *maximum length of zero*
    - the sender must block until the recipient receives the message
    - > there's no queue
  - **bounded capacity**
    - the queue = *finite length n*
    - the sender resumes operation if the queue is not full
    - the sender blocks if the queue is full
    - > the sender keeps going until the queue is full
  - **unbounded capacity**    
    - the queue = *infinite length (potentially)*
    - the sender never blocks
    - > any number of message can wait in the queue

# 3.7 examples of IPC systems

1. POSIX API
2. Mach OS
3. Windows IPC
4. UNIX IPC (pipes)

## 3.7.1 POSIX shared memory

> this is just API introduction


## 3.7.2 Mach message passing

- indirect in addressing
- finite-sized queue for ports

---
- ports
  - port rights
  - task self port
  - (task's) notify port
- bootstrap port
  - bootstrap server

## 3.7.3 windows

- advanced local procedural call (APLC)
  - public connection port provided from the server
  - client request connect through the connection port
  - the port passes the handle to server
  - server creates a private channel
    - client communication port
    - server communication port

# glossary

- IPC: interprocess communication
- POSIX: portable operating system interface
- APLC: advanced local procedural call