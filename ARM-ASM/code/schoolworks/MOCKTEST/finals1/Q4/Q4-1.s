MEM_ADD EQU 0x40000000
        AREA Q4_1, CODE
        ENTRY
        ; r0 -> holds the address of memory
        ; 
        LDR r0, =MEM_ADD
        

data 
        END