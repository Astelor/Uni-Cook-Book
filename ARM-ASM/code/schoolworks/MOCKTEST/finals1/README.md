# quick notes
## Question 1
the question asks us to use STM (store multiple, introduced in chapter 13) to complete the task
```
STM<address-mode>{cond}, Rn{!}, reg-list{^}

STMIA{cond} r0, {r1,r2,r3,r4}   ; Increment After
STMIB{cond} Rn, {Rlist}         ; Increment Before
STMDA{cond} Rn, {Rlist}         ; Decrement After
STMDB{cond} Rn, {Rlist}         ; Decrement Before

STMIA{cond} Rn!, {Rlist}        ; the ! increments the base Rn
```
- it will store the contents within `r1, r2, r3, r4` to the address held in `r0` subsequently
- STMIA -> Rn is incremented AFTER each store operation

- the question ask us NOT to use ! so ehhhhhhhhhhhhh
### STM / LDM
- the lowest register will be loaded first no matter the order in the list
  - {r4,r0,r3} = {r0,r3,r4}

```
(to make it stored/loaded to the desired address)

LDMIA -> address
LDMIB -> address+4
LDMDA -> address+ 4*<number of data-1>
LDMDB -> address+ 4*<number of data>

STMIA -> address
STMIB -> address+4
STMDA -> address+ 4*<number of data-1>
STMDB -> address+ 4*<number of data>
```
### SP

- `PUSH` and `POP` are the same as `STMDB` and `LDMIA`, except it uses SP(stack pointer, register 13) and updates automatically 
  - SP can be set using a `LDR` pseudo-instruction
- or the other way around I guess
```
        AREA example, CODE
        ENTRY
        ADR r0, data
        LDR sp, =0x40000020
		
        LDMIA r0, {r2-r5}  ; load the values in
        STMDA sp!, {r2-r5} ; store the values using stack pointer
        LDMIB sp, {r6-r9}  ; loads the values stored correctly
                           ; and not changing sp
        
stop 	B stop
data    DCD 0xABCD1234, 0xBBBBAAAA, 0xFFFFDDDD, 0x87654321
        END
```
- `STMDA` places the first word of data on 0x20-0x23, and SP stops on 0x10, where 0x10-0x13 have nothing

and there are very much a lot of "fuck you" within and frustration :>
## Question 2
the question asks us to use subroutines
```
        ENTRY
        BL func1
stop    B  stop
func1
        ; some code here
        BX lr ; will link back to the next instruction below "BL func1"

        END
```
- just know that it does the job correctly
- the `STMDA` is probably for r0 and r1, so a `STMDA sp!, {r0,r1}` and `LDMIB sp, {r0,r1}` will be needed
  
## Question 3
the same as that we've done in the homework (parity check), except the checker is repeating by a subroutine

## Question 4
this is also an parity check, except it restricts the use of EOR (XOR).
To by-pass this restriction, we can count the number of 1s first, and simply check the least significant bit to see if it's an odd number.
```
; r2 -> 0x1
TST r2, #1
ANDS r1, r2, #1
```
`TST` and `ANDS` have the same functionality, except `TST` forgo the results and `ANDS` stores the results in r1 in this case.

## MISCs
### Initializing
use STM & LDM instead of multiple STR and LDR
```
MEM_ADD EQU 0x40000000
        AREA example, CODE
        ENTRY
        ADR r0, data
        LDR r1, =MEM_ADD
        LDMIA r0, {r2-r5} ; = {r2,r3,r4,r5}
        STMIA r1, {r2-r5} ; = {r2-r4, r5}

data    DCD 0xABCD1234, 0xBBBBAAAA, 0xFFFFDDDD, 0x87654321
        END
```

### Data Processing
- truth table (might come in handy)

|Data|mask|OR|AND|XOR|
|-|-|-|-|-|
|0|0|0|0|0|
|0|1|1|0|1|
|1|0|1|0|1|
|1|1|1|1|0|

- inverting bits
  - they do the same thing, but `MVN` is easier and doesn't require a mask
```
MVN r1, #0
EOR r2, r1, #0  ; r1=0xFFFFFFFF
MVN r1, r2      ; r2=0xFFFFFFFF
```

- set a~b bits to N
  - `ROR` bits, `BIC` the bits, add the designated bits, rotate them back.
```
; r0 -> data
; r1 -> temp
; r2 -> modified data
ROR r1, r0, <a>          ; get bit a
BIC r1, <0x<b-a+1 bits>> ; clear bit a~b
ADD r1, r1, <N>          ; add N
ROR r2, r1, <32-a>       ; rotate back to normal
```
if there are restrictions, you can...
- no `ROR`
  - use `LSL` / `LSR` to get the bits to where you want
```
; r0 -> data
; r1 -> temp
; r2 -> modified data
; r3 -> mask for BIC < 0x<b-a+1 bits> >
BIC r1, r3, LSL <a>
ADD r2, r1, <N>, LSL <a>
```
- no `BIC`
  - invert the mask and use `AND`

- no `EOR`
  - count the numbers manually
- reverses the hex numbers (0xABCD1234 -> 0x4321DCBA)
```
func2
        MOV r3, #0
        MOV r4, #0
        LDR r5, [r0]
loop2	
        LSR r2, r5, r3
        AND r2, r2, #0xF
        LSL r4, r4, #4
        ADD r4, r4, r2
        
        ADD r3, r3, #4
        CMP r3, #32
        BNE loop2
        BX lr
```