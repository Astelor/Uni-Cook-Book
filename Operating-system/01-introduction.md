# 1. introduction

**table of contents**
- [1. introduction](#1-introduction)
- [1.1 what operating systems do](#11-what-operating-systems-do)
  - [1.1.1. user view](#111-user-view)
  - [1.1.2. system view](#112-system-view)
  - [1.1.3. defining operating systems](#113-defining-operating-systems)
- [glossary](#glossary)

# 1.1 what operating systems do

a computer system's components:
- hardware
  - computing resources for the system
  - e.g. central processing unit (CPU), memory, input/output (I/O) devices
- operating system
  - controls hardware
  - coordinate hardware usage among the `application programs` for users
    - resource distribution
  - *environment* for programs to work
- application programs
  - solve users' computing problems
  - e.g. word processors, compilers, web browsers
- user
  - you

## 1.1.1. user view

you on personal computer:
- user interface
  -  e.g. monitor, keyboard, touch screen, voice recognition
- monopolize all the resources
- **ease of use**
- maximize work
- no **resource utilization**

```
[user]
    ↕
[application programs]
(compilers, web browsers, etc)
    ↕
[operating system]
    ↕
[computer hardware]
(CPU, memory, I/O devices, etc)
```

**embedded computers**:
- in e.g. home devices, automobiles
- designed to run without user intervention

## 1.1.2. system view

the operating system is a:
- **resource allocator**
  - resources: e.g. CPU time, memory space, storage space, I/O devices
  - allocating resources to programs
  - to operate computer system efficiently and fairly
- **control program**
  - manages the execution of user programs
  - to prevent errors and improper use of the computer
  - especially the operation of I/O devices

## 1.1.3. defining operating systems

brief history of computer:
- fixed-purpose systems for military uses
  - e.g. census calculation, cipher decryption
- general-purpose, multifunction mainframes
  - operating systems were born
- 1960s `Moore's Law` predicted the number of transistors on ICs will double every 1.5 year (18 months)
- computer gained in functionality and shrank in size
  - vast number of uses and operating systems 

goal of computer system:
- execute programs
- make solving user problems easier 

definition of an OS:
- no universally accepted definition of OS
- everything a vendor ships when you order "the operating system"
  - features included vary greatly across systems
- the one program running *at all times* on the computer
  - more common definition, the one we usually follow
  - called the **`kernel`**


**`kernel`**:
- along with `system programs` and `application programs`
- `system programs` are associated with the OS
  - not necessarily part of the `kernel`
- `application programs` are all programs not associated with the operation of the system
  - a computer can live without `application programs` 
  - but cannot live without `system programs`

too much features?
- in short, *microsoft got sued by the us government* in 1998 and was found guilty for including too much features in its OS, creating a monopoly using the OS.
- the features included in OS on mobile devices is increasing

mobile operating systems
- include core `kernel` and `middleware`
- `middleware` is a set of software frameworks that provide additional services to application developers
  - e.g. supporting databases, multimedia, graphics

OS summary:
- `kernel` that is always running
- `middleware` frameworks for ease of app development + features
- `system programs` aid in managing the system

# glossary
- OS: operating system