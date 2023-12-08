    AREA HW2_part3_2, CODE, READONLY
    ENTRY
    LDR     r2, =0x12345678
    LDR     r3, =0x87654321
    LDR     r4, =0x12

    BIC r2, r2, #0xFF000000 
    LSL r2, r3, #4 
    LSL r2, r2, r4
    ROR r2, r2, #12 ;
    AND r2, r2, r3 
    ORR r2, r2, r4 
    EOR r2, r2, r4
    BIC r2, r2, r4 
    EOR r2, r2, r3, ROR #7
stop B stop
    END ; [REDACTED] Aster Chen, verified
