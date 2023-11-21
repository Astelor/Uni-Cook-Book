# ASM Cheat Sheet
:>
when in doubt, check the [document](/ARM-ASM/resources/DUI0204J_rvct_assembler_guide.pdf)

## Start
```
        AREA ProgramName, CODE, READONLY
        ENTRY
        
        ;(your code here)

        END
stop    B   stop
```
## Directive

### Shifting (4.3.12)
```
op{S}{cond} Rd, Rm, Rs
op{S}{cond} Rd, Rm, #sh
RRX{S}{cond} Rd, Rm
```
-  ASR
   -  Arithmetic shift right
-  LSL
   -  logical shift left
-  LSR
   -  logical shift right
-  ROR
   -  rotate right
-  RRX
   -  rotate right with extend


