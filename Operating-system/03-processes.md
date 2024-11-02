# chapter 3, processes

**table of content**
- [chapter 3, processes](#chapter-3-processes)
- [3.4 interprocess communication](#34-interprocess-communication)
  - [process types](#process-types)
  - [interprocess communication models](#interprocess-communication-models)
- [3.5 IPC in shared-memory systems](#35-ipc-in-shared-memory-systems)
  - [producer and consumer](#producer-and-consumer)
  - [buffer types](#buffer-types)
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

- the processes are responsible for ensuring that they are not writing to the same location simultaneously (writing conflicts)

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
  - no practical limit on the buffer size
- **bounded** buffer
  - assumes a fixed buffer size

# glossary

- IPC: interprocess communication
