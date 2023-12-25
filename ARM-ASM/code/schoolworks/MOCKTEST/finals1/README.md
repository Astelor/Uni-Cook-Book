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
- `PUSH` and `POP` are the same as `STMDB` and `LDMIA`, except it uses SP(stack pointer, register 13) and updates automatically 
  - SP can be set using a `LDR` pseudo-instruction

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

I'm so unfortunately not good enough to dissect functionalities and make them into "lego blockos" to be assembled when taking the exam. Nonetheless there will be funky restrictions and I'll have to rewrite my code completely. And the exam is so frustratingly arduous and lengthy it's impossible to finish within an hour.

We are not lab rats.

anyways