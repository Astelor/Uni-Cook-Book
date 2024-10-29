# chapter 1, background

> all the little things at one place

**table of content**
- [chapter 1, background](#chapter-1-background)
- [1.3.1. SIC machine architecture](#131-sic-machine-architecture)
  - [memory](#memory)
  - [registers](#registers)
  - [data formats](#data-formats)
  - [addressing mode](#addressing-mode)
  - [instruction set](#instruction-set)
    - [ADD](#add)
    - [COMP](#comp)
    - [JSUB](#jsub)
- [glossary](#glossary)
- [basics](#basics)
  - [flags](#flags)

# 1.3.1. SIC machine architecture

## memory
- `8-bit byte` for a unit in memory
  - all addresses are `byte addresses`
- 3 bytes for a word (24 bits)
  - and a instruction 

## registers

|mnemonic|number|special use|
|--|--|--|
|A|0|accumulator|
|X|1|index register|
|L|2|linkage register|
|PC|8|program counter|
|SW|9|status word|

- A: `accumulator`; used for arithmetic operations
- X: `index register`; used for addressing 
  - setting `x-bit` in the machine code for indexed addressing 
- L: `linkage register`; the Jump to Subroutine (`JSUB`) instruction stores the *return address* in this register
  - > so the program knows where to go back once the subroutine is done
- PC: `program counter`; contains the *address of the next instruction* to be fetched for execution
- SW: `status word`; contains a variety of information, including a Condition Code (CC)
  - > **what's this??**

## data formats

- integers are stored as `24-bit` binary numbers
- characters are stored as `8-bit` ASCII codes
- 2's complement is used for negative numbers
- no floating point hardware on standard SIC
  - SIC/XE has floating point hardware
  - > yes it requires special hardware to do floating point in ASM

## addressing mode

```
   8      1    15
[opcode] [x] [addr]
```

- 24 bit
- x-bit is for the addressing mode
  - x = 0: direct addressing, `target address` (TA) = addr
  - x = 1: indexed addressing, `target address` (TA) = addr + (X)
    - (X) → content of register `X`

## instruction set

> see appendix A for full SIC instructions and its opcodes
>
> but for example...
- notes in the appendix
  - P: privileged instruction
  - X: instruction available only on XE version
  - F: floating-point instruction
  - C: Condition code (`CC`) set to indicate the result of operation (<, =, or >) 

---

### ADD

- instruction: `ADD m`
- notes: (none)
- effect: A ← (A) + (m...m+2)
  - `contents of memory locations {m, m+1, m+2}` are added with with the `contents of register A`
  - and then store the arithmetic result to `register A`
- > `register A` is a special register, if someone were to do *m_1* + *m_2*, *m_1* must be loaded into `register A` first, and then do `ADD m_2`

---

### COMP

- instruction: `COMP m`
- effect: (A) : (m...m+2)
- notes: C

### JSUB

# glossary

- SIC: simplified instructional computer
- ASCII: american standard code for information interchange

# basics

## flags

```
c_23 c_22 c_21 ... c_1 c_0 0
     x_23 x_22 ... x_2 x_1 x_0
+    y_23 y_22 ... y_2 y_1 y_0
-------------------------------
     z_23 z_22 ... z_2 z_1 z_0
```

- `carry` flag: c_23
- `overflow` flag: c_23 XOR c_22
  - overflow flag is set when c_23 or c_22 is set
  - c_23
- `sign` (negative) flag: z_23
  - in 2's complement, signed negative integer's most significant bit is 1
- `zero` flag: z_23 OR z_22 OR z_21 OR ... OR z_0