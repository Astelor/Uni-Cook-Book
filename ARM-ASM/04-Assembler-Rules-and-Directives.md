# Chapter 4, Assembler Rules and Directives
> Rules of the assembler, the structure of a program, and directives, which are instructions to the assembler for creating areas of code, aligning data, marking the end of your code, and so forth.
> Other assemblers have slightly different rules, be aware, but we will be focusing on Keil Tools in this chapter.

:>

## 4.2 Structure of Assembly Language Modules
### example module
```
        AREA ARMex, CODE, READONLY
        ; Name this block of code ARMex
        ENTRY               ; Mark first instructions to execute
start   MOV     r0, #10     ; Set up parameters
        MOV     r1, #3
        ADD     r0, r0, r1  ; r0=r0+r1
stop    B       stop        ; infinite loop
        END                 ; Mark end of file
```
- **general form of source lines**:
  - `{label} {instruction|directive|pseudo-instruction} {;comment}`
- **labels**
  - are names you choose to represent an address somewhere in memory.
  - will eventually be translated into a numeric value.
  - *must start at the beginning of the line*
- **instructions|directives|pseudo-instructions**
  - *must be preceded by a white space, a tab or any number of spaces*
  - leaving the first column blank, even if there's no label, it makes the code more readable.

- **Unified Assembler Language** (UAL):
  - the *current* ARM/Thumb assembler language
  - superseded earlier versions of both the ARM and Thumb assembler languages.
  - can be assembled for ARM, Thumb, or Thumb-2
  - ![old-version-vs-UAL](/ARM-ASM/attachments/UAL-differences.png)
    - Be mindful of the changes when you review older programs.

- **Guidelines for good comments**
  - don't comment the obvious
  - use concise language
  - comment the sections of code where you think another programmer will have a hard time following your reasoning.
  - do not abbreviate, if possible.

### Rules about constants
- **numbers**
  - decimal: 123
  - hexadecimal: 0x3F
  - n_xxx (Keil only) (base n):
    - *n* is a base between 2 and 9
    - *xxx* is a number in that base
`the constant formats are similar to that of C`

*tba, will comeback when I need this chapter*