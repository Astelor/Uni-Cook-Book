    AREA HW2_part3_1_2, CODE, READONLY
    ENTRY
    LDR     r3, =0x40000000
    LDR     r6, =0xDEADBEE
    STR     r6, [r3]
    LDRB    r4, [r3]
stop B stop
    END ;   [REDACTED] Aster Chen, verified