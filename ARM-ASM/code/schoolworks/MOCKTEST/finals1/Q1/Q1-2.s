MEM_ADD EQU     0x40000020
        AREA Q1_2, CODE
        ENTRY
        ; r0 = 0xBBBBBBBB
        ; r1 = 0xFFFFFFFF
        ; r2 = 0xEEEEEEEE
        ; r3 = 0xDDDDDDDD
        ; r8 -> holds the address to be stored
        ; use STMIB and LDRIB to complete the task
        LDR     r0, =0xBBBBBBBB
        LDR     r1, =0xFFFFFFFF
        LDR     r2, =0xEEEEEEEE
        LDR     r3, =0xDDDDDDDD
        LDR     r8, =MEM_ADD
		SUB 	r8, r8, #4
        STMIB   r8, {r0,r1,r2,r3}
        ADD     r8, r8, #0x14
        LDMDB   r8, {r4,r5,r6,r7}
stop    B       stop
        END
