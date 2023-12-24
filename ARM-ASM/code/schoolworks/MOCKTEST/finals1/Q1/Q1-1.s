MEM_ADD EQU     0x40000020
        AREA Q1_1, CODE
        ENTRY
        ; r0 = 0xBBBBBBBB
        ; r1 = 0xFFFFFFFF
        ; r2 = 0xEEEEEEEE
        ; r3 = 0xDDDDDDDD
        ; r8 -> holds the address to be stored
        ; use STMIA and LDRIA to complete the task
        LDR     r0, =0xBBBBBBBB
        LDR     r1, =0xFFFFFFFF
        LDR     r2, =0xEEEEEEEE
        LDR     r3, =0xDDDDDDDD
        LDR     r8, =MEM_ADD
        STMIA   r8, {r0,r1,r2,r3}
        ADD     r8, r8, 0xC
        LDMDA   r8, {r4,r5,r6,r7}
stop    B       stop
        END
