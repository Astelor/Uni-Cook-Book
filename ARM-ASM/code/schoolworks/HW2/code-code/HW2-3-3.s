    AREA HW2_part3_3, CODE, READONLY
    ENTRY
    LDR     r1, =0xFFFFFFFF     ; 1. caculate 2's complement of r6
    LDR     r6, =0xABCD8765     ;    and put the result in r7
    EOR     r7, r1, r6
    ADD     r7, r7, #1
                                
    LDR     r2, =0x2022         ; 2.
    ORR     r6, r2, r6          ; mask 2
             
    LDR     r3, =0xEFEE         ; 3.
    AND     r6, r3, r6          ; mask 3
                                
    LDR     r4, =0x0910         ; 4.
    EOR     r6, r4, r6          ; mask 4
                                
    LDR     r0, =0xBEEFABCD   	; 5.
    LDR     r5, =0xFFFF0000     ; mask 5
    LDR     r8, =0x5555         ; 
    AND     r0, r5, r0          ;
    ADD     r0, r8
stop B stop
    END ;   [REDACTED] Aster Chen, verified (I think) 