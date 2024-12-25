# chapter 2, assembler

- **forward reference**
  - a reference to a label defined later in the program

# assembler directive

> or pseudo-instructions, not translated into

- `START`
- `END`
  - end of the source program and *optionally* specify the first executable instruction in the program (if not, the assembler will decide it for you)
- `BYTE`/`WORD`
  - generate one-byte/word integer constant
- `RESB`/`RESW`
  - reserve bytes/words



# 2 pass assembling

**pass 1** (define symbols)
1. assign addresses to all statements in the program
2. save the values (addresses) assigned to all labels (for use in *pass 2*)
3. perform some processing of assembler directives (processing that affects address assignment, `RESW`/`RESB`/`WORD`/`BYTE`)

**pass 2**
1. assemble instructions (translating operation codes and looking up addresses)
2. generate data value defined by `WORD`, `BYTE`, etc
3. perform processing of assembler directives not done during *pass 1*
4. write the object program and the assembly listing

# assembler data structures

- **OPTAB**: operation code table
  - look up *mnemonic operation codes* -> translate into machine code
- **SYMTAB**: symbol table
  - store values (addresses) assigned to *labels*
  - usually a hash table
    - entries rarely deleted from this table
- **LOCCTR**: location counter
  - initialized to the beginning address specified in the `START` statement
  - current value will be assigned to newly reached *label's* address
  - is incremented by the length of assembled instruction (format3/4, `RESW`/`RESB`, `WORD`/`BYTE`)

# object code records

- columns vary in size
  - ASCII -> 1 byte
  - HEX -> half a byte, 1 nibble, 4 bits

## H (header) record

1. 1, H (1 byte)
2. 2-7, program name (6 nibble, 3 bytes, 1 word)
3. 8-13, starting address of object program (hex) (6 nibble, 3 bytes, 1 word)
4. 14-19, length of object program in bytes (hex) (6 nibble, 3 bytes, 1 word)

```
H COPY__ 001000 00107A
 +      +      +
```

## T (text) record

1. 1, T (1 byte)
2. 2-7, starting address for object code (hex) (6 nibble, 3 bytes, 1 word)
3. 8-9, length of object code in this record (hex) (2 nibble, 1 byte)
4. 10-69, object code (hex) (60 nibble, 30 bytes, 10 word)

```
T 001000 1E 141033 482039 001036 281030 301014 482061 3C1003 00102A 0C1039 00102D
 +      +  +      +      +      +      +      +      +      +      +      +
```

## E (end) record

1. 1, E (1 byte)
2. 2-7, Address of the first executable (hex) (6 nibble, 3 bytes, 1 word)

```
E 001000
 +
```

- M (modification) record
- D (define) record
- R (reference) record
