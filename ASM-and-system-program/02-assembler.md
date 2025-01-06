# chapter 2, assembler

# assembler directive

> or pseudo-instructions, not translated into machine code

- `START`: specify name and starting address for the program
- `END`: end of the source program and *optionally* specify the first executable instruction in the program (if not, the assembler will decide it for you)
- `BYTE`/`WORD`: generate one-byte/word integer constant
- `RESB`/`RESW`: reserve bytes/words

# 2 pass assembling

- **forward reference**
  - a reference to a label *defined later* in the program
    - thus the *multiple pass* assembling

- **pass 1** (define symbols)
  1. assign addresses to all statements in the program
  2. save the values (addresses) assigned to all labels (for use in *pass 2*)
  3. perform some processing of assembler directives (processing that affects address assignment, `RESW`/`RESB`/`WORD`/`BYTE`)

- **pass 2** (assemble instructions and generate object program)
  1. assemble instructions (translating operation codes and looking up addresses)
  2. generate data value defined by `WORD`, `BYTE`, etc
  3. perform processing of assembler directives not done during *pass 1*
  4. write the object program and the assembly listing

# assembler data structures

- **OPTAB**: *operation* code table
  - look up *mnemonic operation codes* -> translate into machine code
- **SYMTAB**: *symbol* table
  - store values (addresses) assigned to *labels*
  - usually a *hash table*
    - entries rarely deleted from this table
- **LOCCTR**: *location counter*
  - initialized to the beginning address specified in the `START` statement
  - current value will be assigned to newly reached *label's* address
  - is incremented by the length of assembled instruction (format3/4, `RESW`/`RESB`, `WORD`/`BYTE`)

# object code records

- **object program**
  - loaded into memory by loader for execution
- columns vary in size
  - ASCII -> 1 byte, 2 nibble, 8 bits
  - HEX -> half a byte, 1 nibble, 4 bits
    - e.g. 0x1, 0xA, 0xF
- **relocatable program**
  - object program that contains the information necessary to perform address modification


## H (header) record

1. 1, H (ascii) (1 byte)
2. 2-7, program name (ascii) (6 bytes, 2 word)
3. 8-13, starting address of object program (hex) (6 nibble)
4. 14-19, length of object program in bytes (hex) (6 nibble)

```
H COPY__ 001000 00107A
 +      +      +
```

## T (text) record

1. 1, T (ascii) (1 byte)
2. 2-7, starting address for object code (hex) (6 nibble)
3. 8-9, length of object code in this record (hex) (2 nibble)
4. 10-69, object code (hex) (60 nibble)

```
T 001000 1E 141033 482039 001036 281030 301014 482061 3C1003 00102A 0C1039 00102D
 +      +  +      +      +      +      +      +      +      +      +      +
```

## E (end) record

1. 1, E (ascii) (1 byte)
2. 2-7, Address of the first executable (hex) (6 nibble, 3 bytes, 1 word)

```
E 001000
 +
```

## M (modification) record

> - the command for the *loader* to modify the offending instruction address
>   - the instructions that specify *direct addresses*
>   - PC and base relative addressing won't be affected
> - if the field to be modified is an *odd number of nibbles*, the field begins at the *middle of the first byte* of the starting location 


1. 1, M (ascii) (1 byte)
2. 2-7, starting location of the address field to be modified, relative to the beginning of the program (hex)
3. 8-9, length of the address to be modified, in half-bytes (hex)

```
M 000014 05
 +      +
```
- D (define) record
- R (reference) record

# 2.3 machine-independent assembler features

## literals

- value is *literally* stated in the instruction
- a literal is defined with a prefix `=`
- **literal pools**: literals used in the program, gathered in one place, typically after the `END` directive
- the effect is exactly the same as using a label to define a constant
- `LTORG` directive: make a literal pool for the literals encountered so far

```
LDA   =C'EOF'
TD    =X'05'
LTORG
```