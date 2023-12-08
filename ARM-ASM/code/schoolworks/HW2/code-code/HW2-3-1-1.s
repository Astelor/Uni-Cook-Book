    AREA HW2_part3_1, CODE, READONLY
    ENTRY
    LDR     r3, =0x40000000
    LDR     r4, =0x60
    STR     r6,  [r3, #8]
    STRB    r7,  [r3], #12
    LDRH    r5,  [r3], #12
    LDR     r12, [r3, #4]!
    LDR     r6,  [r3, r4, ROR #28]!    
    LDR     r0,  [r3, r4, LSL #2]
stop B stop
    END ;   [REDACTED] Aster Chen, verified