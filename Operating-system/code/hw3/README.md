# HW3 for Operating System

> I write CompOS cuz just writing "OS" is confusing

**how to compile?**
```
gcc -pthread buffer.c -o hw3-compos.exe hw3-compos.c
```
- `buffer.c` inclusion is for the compiler to grab the custom library
- `-pthread` to link the pthread library and define additional macros [man gcc]