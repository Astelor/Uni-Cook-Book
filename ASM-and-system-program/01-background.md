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
    - [arithmetic](#arithmetic)
      - [ADD](#add)
      - [COMP](#comp)
    - [jump](#jump)
      - [J](#j)
      - [JSUB](#jsub)
      - [RSUB](#rsub)
    - [load](#load)
    - [store](#store)
- [glossary](#glossary)
- [basics](#basics)
  - [flags](#flags)
  - [comparison](#comparison)

# 1.3.1. SIC machine architecture

> *placeholder*

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

- **A**: `accumulator`; used for arithmetic operations
- **X**: `index register`; used for addressing 
  - setting `x-bit` in the machine code for indexed addressing 
- **L**: `linkage register`; the Jump to Subroutine (`JSUB`) instruction stores the *return address* in this register
  - > so the program knows where to go back once the subroutine is done
- **PC**: `program counter`; contains the *address of the next instruction* to be fetched for execution
- **SW**: `status word`; contains a variety of information, including a Condition Code (CC)
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
### arithmetic

#### ADD

- instruction: `ADD m`
- notes: (none)
- effect: A ← (A) + (m...m+2)
  - **contents of memory locations {m, m+1, m+2}** are added with with the `contents of register A`
  - and then store the arithmetic result to `register A`
- > `register A` is a special register, if someone were to do *m_1* + *m_2*, *m_1* must be loaded into `register A` first, and then do `ADD m_2`

#### COMP

- instruction: `COMP m`
- effect: (A) : (m...m+2)
- notes: C
  - > updates the conditional code (the 4 flags)

---

### jump

#### J

- instruction: `J m`
- effect: PC ← m

#### JSUB

> sub: subroutine, J: jump
- instruction: `JSUB m`
- effect: L ← (PC); PC ← m
  - > store the *contents of PC* to L, then load the address m to PC
    > 
    > PC points to the next instruction (the one under `JSUB`) 

#### RSUB

> sub: subroutine, R: return
- instruction: `RSUB`
- effect: PC ← (L)
  - > load the *contents of L* to PC

### load

- `LDA m`
  - A ← (m..m+2)
- `LDCH m`
  - A[*least significant byte*] ← (m)
- `LDX m`
  - X ← (m..m+2)
- `LDL m`
  - L ← (m..m+2)

### store

- `STA m`
  - (m..m+2) ← A
  - > store A, accumulator
- `STCH m`
  - (m) ← A[*least significant byte*]
  - > store character, a character is 1 byte
- `STX m`
  - (m..m+2) ← X
  - > store X, index register
- `STL m`
  - (m..m+2) ← L
  - > store L, linkage register

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

- **carry** flag (`CF`): *c_23*
- **overflow** flag (`OF`): *c_23* XOR *c_22*
  - overflow flag is set when *c_23* or *c_22* is set
  - *c_23*
- **sign** (negative) flag (`SF`): *z_23*
  - in 2's complement, signed negative integer's most significant bit is 1
- **zero** flag (`ZF`): *z_23* OR *z_22* OR *z_21* OR ... OR *z_0*

## comparison

> `cmp x`; do (A) - x
>
> the comparison operation itself is doing a subtraction and update flags

- **signed** integer comparison
  - **GT** (greater than)
    - `OF` = `SF` AND `ZF` = 0
  - **GE** (greater than or equal to)
    - `OF` = `SF` OR `ZF` = 1
  - **LT** (less than)
    - `OF` != `SF` AND `ZF` = 0
  - **LE** (less than or equal to)
    - `OF` != `SF` OR `ZF` = 1
- **unsigned** integer comparison
  - **GT** (greater than)
    - `CF` = 0 AND `ZF` = 0
  - **GE** (greater than or equal to)
    - `CF` = 0 OR `ZF` = 1
  - **LT** (less than)
    - `CF` = 1 AND `ZF` = 0
  - **LE** (less than or equal to)
    - `CF` = 1 OR `ZF` = 1