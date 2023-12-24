MEM_ADD EQU     0x40000030
        AREA Q1_4, CODE
        ENTRY
        ; r0 = 0xBBBBBBBB
        ; r1 = 0xFFFFFFFF
        ; r2 = 0xEEEEEEEE
        ; r3 = 0xDDDDDDDD
        ; r8 -> holds the address to be stored
        ; use STMIA and LDRIA to complete the task
        ; store r0, r1, r2, r3 into memory with addresses 
        ; 0x40000020, 0x40000024, 0x40000028, 0x4000002C respectively
        LDR     r0, =0xBBBBBBBB
        LDR     r1, =0xFFFFFFFF
        LDR     r2, =0xEEEEEEEE
        LDR     r3, =0xDDDDDDDD
        LDR     r8, =MEM_ADD
        STMDB   r8, {r0,r1,r2,r3}
        SUB     r8, r8, #0x14
        LDMIB   r8, {r4,r5,r6,r7}
stop    B       stop
        END
