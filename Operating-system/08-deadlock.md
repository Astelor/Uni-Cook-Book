# chapter 8, deadlock


# 8.1 system model

- **normal mode of operation for a thread**
  - **request**
    - number of resources requested may not exceed the total number of resources *available*
  - **use**
    - operate on the resource
  - **release**
    - releases the resource, making it available to 

# 8.2 deadlock in multithreaded applications

## 8.2.1 livelock

- another form of liveness failure
  - similar to deadlock
- when a thread continuously attempts an action that fails
- typically occurs when threads retry failing operations at the same time

# 8.3 deadlock characterization

## 8.3.1 necessary conditions

- *all four* conditions must hold for a deadlock to occur

- **mutual exclusion**
  - at least one resource must be held in a non-sharable mode
- **hold and wait**
  - a thread must be *holding at least one* resource and *waiting to acquire additional* resources that are not available
- **no preemption**
  - resources cannot be preempted
- **circular wait**
  - T1 → T2 → T3 → ... → Tn → T0
  - implies the hold-and-wait condition

## 8.3.2 resource-allocation graph

- **vertices V**: two different types of nodes
  - T={T1,T2,...,Tn}: consisting of all the processes (threads) in the system
  - R={R1,R2,...,Rm}: consisting of all resource types in the system
- **directed edge E**
  - **request edge**: Ti → Rj
  - **assignment edge**: Rj → Ti
- the graph contains 
  - **no cycle**: *no deadlock*, the state is safe
  - **a cycle**:
    - *single instances* for all resources types
      - *deadlock occurred* for all the threads involved in the cycle
    - *multi-instance* for all resources types
      - the cycle is a necessary but *not sufficient condition for deadlock*

# 8.4 methods for handling deadlocks

- **ignore the problem**
  - *pretend* that deadlocks *never occur* in the system
  - > used by most operating systems
- **use a protocol**
  - ensuring that the system wil *never enter* a deadlocked state
  - > programmed by the programmers in anything, if it happens it's your skill issue!
- **allow entering of deadlocked state**
  - *detect and recover*
  - > used by databases

# 8.5 deadlock prevention

- ensuring **at least one of the [necessary conditions](#831-necessary-conditions) cannot hold**
  - preventing the occurrence of a deadlock

## 8.5.1 mutual exclusion

- **some resources are intrinsically non-sharable**
  - *mutex locks* are a must for preventing *race conditions*
    - and is not simultaneously sharable
- -> cannot prevent deadlocks by denying mutual exclusion

## 8.5.2 hold and wait

- **whenever a thread request a resource, it does not hold any other resources**
- **protocols**:
  - **protocol 1**:
    - requires each thread to request and be *allocated all its resources* *before it begins* execution
    - -> impractical due to *dynamic nature* of requesting resources
  - **protocol 2**:
    - allows a thread to request resources only *when it has none*
      - before it can *request any additional resources*, it must *release all* the resources it currently allocated
- **disadvantage for both protocols**
  - resources utilization may be low
  - starvation is possible

## 8.5.3 no preemption

- **protocols**:
  - **protocol 1**:
    1. if a thread is *holding some resources* and *requests another resources* that is *not available* (the thread must wait)
    2. all the resources the thread is *currently holding* are *preempted*
    3. the thread will be *restarted* only when it has the *old resources* and the *requested new resources*
  - **protocol 2**:
    1. a thread requests some resources
    2. if not available, check if the requested resource is held by other waiting thread
    3. preempt the requested resources held by the waiting thread
    4. if the resource is neither *available* nor *held by a waiting thread* (it's in operation), the thread *must wait*
- applied to resources whose *state can be easily saved and restored*
  - CPU registers and database transactions
- *cannot* generally be applied to types of resources where *deadlock occurs most commonly*
  - mutex locks and semaphores

## 8.5.4 circular wait

- impose a **total ordering of all resources types**
- require each thread requests resources in an increasing order of enumeration
  - does **not guarantee deadlock prevention** if locks can be acquired dynamically 

# 8.6 deadlock avoidance

- require **additional information** about how resources are to be requested
- ensuring the system *never enter an unsafe state*

## 8.6.1 safe state

- a state is safe:
  - if the system can *allocate resources* to each thread (up to its maximum) *in some order* and still *avoid a deadlock*
  - only if there exist a **safe sequence**
    - if no such sequence exists, the system is in an *unsafe state*
- **protocol**
  - the resource requests that Ti can still make, can be satisfied by
    - currently available resources
    - plus resources held by all Tj, j < i
  - Ti can wait until all Tj have finished
- not all unsafe states are deadlocks
  - an unsafe state may lead to deadlocks

**a safe state**: with 12 resources
|threads|maximum|required|currently allocated|
|---|---|---|---|
|T0|10|5|5|
|T1|4|2|2|
|T2|9|7|2|

**elaboration**
|time|thread|allocated|free resources|requested|
|---|---|---|---|---|
|0|T1|2|3|2|
|1|T0|5|5|5|
|2|T2|2|10|7|

### 8.6.1.a unsafe state

- a system can go from a *safe state* to an *unsafe state*
  - by granting request from a thread (e.g. T2) for more resource (1 in allocated)

**safe turned unsafe state**: with 12 resources in total
|time|thread|allocated|free resources|requested|
|---|---|---|---|---|
|0|T1|2|3|2|
|**1**|**T2**|2|5|**1**|
|2|T0|5|4|5 (unsafe)|
|3|T2|2|4|7 (deadlocked)|

- T0 requires 5 but there's only 4, the system is deadlocked
- thus if a thead request a resource that is currently available, it may still have to wait
  - resource utilization may be lower

## 8.6.2 resource-allocation-graph algorithm

- single instance of a resource type:
  - resource-allocation-graph
- multi instance of a resource type:
  - [banker's algorithm](#863-bankers-algorithm)
---
- **claim edge**: Ti ⇢ Rj
  - thread Ti may request resource Rj, represented by a dashed line
  - when Ti request request resource Rj, *claim edge* converts to *request edge*
  - *request edge* (Ti → Rj) converts to *assignment edge* (Rj → Ti) when the resource is allocated to the process
  - *assignment edge* converts to *claim edge* when the resource is released by a thread
- resources must be claimed a priori in the system
- request can be granted only if *converting the request edge to an assignment edge* does not result in the *formation of a cycle*

## 8.6.3 banker's algorithm