# How to get a program running
- Selection of programming language
- Editing: text editor
- **Translation**
    - high-level: compiler
    - low-level: assembler
> - java -> byte code -> VM -> machine code
> - C ---> machine code
> - A compiler typically only translate to one set of machine code
> - gcc stands for GNU compiler collection
> 	- free software foundation FTW (GPL 2)
>	- proprietary compiler exist for proprietary uses
- **Linking**: Linkage Editor (Linker)
    - puts all the object files in one file -> executable
- **Loading**: Loader
	- put the things into the memory to execute

## Step 1, Editing: text editor
- easy to use, hard to write one
- IDE: Integrated Development Environment
	- text editing + compiler + debugger
	- e.g. Notepad++, Eclipse

## Step 2, Translation
- from language A to language B
	- A: source language -> B: object language
	- source program -> object program
Usually
- A: higher level programming language
- B: machine code (language)

- compiler: high level language translator
	- C program -> machine code program
	- test.c -> test.o (test.obj)
- assembler: assembly language translator
	- assembly program -> machine code program
	- test.S -> test.o (test.obj)
	- CPU architecture dependent
	- > HEH instruction set HEHEHEHEH
- Main probelm: **forward reference** problem
	> what?

## Step 3, Linking
Linkage Editor (Linker)
- you cannot write all the code by yourself :)
- combine ohter programs into a "complete" executable program
- put all related object codes together
- > library (libc.a) is a binder of object files, it's an entry to find stuff.
- test.o + libc.a = test.exe
- save the executable file to permanent memory
- Main problem: **cross reference** problem
	> heh?

## Step 4, Loading
Loader
- load the executable from permanent memory to RAM
	- > and to cache