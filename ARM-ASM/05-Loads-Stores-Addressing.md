# Chapter 5, Loads, Stores, and Addressing
>Astelor: this is one funky chapter, spent a lotta time reading AND absorbing.

> About half of the instrucions deal with data movement; therefore, loading and storing data efficiently is critical to optimizing processor performance.
>
> This chapter looks at those basic load and store instructions, their addressing modes, and their uses.

## 5.2 Memory
- **8 bits, a byte**:
  - the width of each element in the system universally adopted nowadays.
  - E.g. megabytes(MB, 2^20 or 10^6) • gigabytes(GB, 2^30 or 10^9) • terabytes(TB, 2^40 or 10^12)
- **processor speaks directly to a fixed memory size**: 
  - such as 4GB(0x0~0xFFFFFFFF)
  - "most textbooks on computer architecture cover it pretty well"
- **loss of data**:
  - registers are volatile, writing it to a non-volatile memory so no data is lost.
    > Energy management software may decide to power down certain parts of a chip when idle, and a loss of power may mean a loss of data. It may even have to store the contents of other on-chip memories such as a cache or tightly coupled memory (TCM)
- **hardware types**:
  - not all memory has to be readable and writable
  - E.g. ROM (Read-Only Memory) • EEPROM (Electrically Erasable Programmable ROM)

- **address bus**:
  - address bus on **ARM7TDMI**: 32 bits
    - you can address bytes in memory from address 0~2^32-1(0xFFFFFFFF)
    - which is 4GB of memory space.
    - 📝on 64-bit processor, it has 2^64-1 addresses, which is 8 million TeraBytes of memory space.
  - memory map on **Cortex-M4-based** microcontrollers(such as Tiva TM4C123GH6ZRB):
    - the entire address space is defined, but certain address ranges do not exist. 
      - the address between 0x4400000 and 0xDFFFFFFF
      - different types of memory on the die and an interface to talk to external memory off-chip
    - "not all addresses are used, and much of teh memory map contains areas dedicated to specific functions......While the memory layout is defined by an SoC's implementation, it is not part of the processor core" 

> Astelor: I'm so confused by this part, so it has a memory map SOMEWHERE on chip, so when we stick an external memory, the processor can talk to that? but where's that map? a memory outside the processor itself but NOT an external memory?

## 5.3 Loads and Stores: The Instructions
> Astelor: word size = the size of data the processor can access in a cycle = size of processor's register
>  
> So in 32-bit processor, a word is 32 bits, its general-purpose register(GPR) is 32 bits wide. In 64-bit processor, a word is 64 bits, its GPR is 64 bits wide.

- **Most often used load/store instructions**
  - |Loads|Stores|Size and Type|
    |---|---|---|
    |LDR|STR|Word (32 bits)|
    |LDRB|STRB|Byte (8 bits)|
    |LDRH|STRH|Halfword (16 bits)|
    |LDRSB||Signed byte|
    |LDRSH||Signed halfword|
    |LDM|STM|Multiple words|

- **Load** instructions take a single value from memory and write it to a general-purpose register.
  - for v4T, loads to register PC must be used with caution.
- **Store** instructions read a value from a general-purpose register and store it to memory.
- **Instruction format**:
```
LDR|STR{<size>}{<cond>} <Rd>,<addressing_mode>

<size>: optional size
<cond>: optional condition (discussed in chapter 8)
<Rd>: source or destination register
``` 
- **addressing mode**: (see 5.4 operand addressing)
  - `LDR r9, [r12, r8, LSL #2]`
    - Have a base register r12, an offset value created shifting r8 left by two bits.
    - The offset is added to the base register to created the effective address for the load in this case.
- **effective address**: 
  - the final address created from values in the various registers. 
  - the address to access memory.
- **limitations**:
  - loading to r15 (PC) must be used with caution


## 5.4 Operand Addressing
- pre-indexed addressing and post-indexed addressing are just variations on a theme.
- they have two things in common, a base register and an optional offset.
### Pre-Indexed Addressing

syntax:
```
LDR|STR{<size>}{<cond>} <Rd>, [<Rd>,<offset>]{!}
```
example:
```
STR r0, [r1, #12]
```
- **base register**:
  - Rn
- **effective address**:
  - base register(Rn) + offset = effective address
  - in pre-indexed addressing the offset is added before the data is stored to memory.
- **!** (the optional escalation mark)
  - writing the effective address back into base register(Rn) at the end of the instruction.


### Post-Indexed Addressing