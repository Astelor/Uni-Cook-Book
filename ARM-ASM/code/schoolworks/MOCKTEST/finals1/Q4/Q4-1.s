MEM_ADD EQU 0x40000000
        AREA Q4_1, CODE
        ENTRY
        ; r0 -> holds the address of memory
        ; r1 -> temp
        ; r2 -> temp
        LDR r0, =MEM_ADD
        ADR r1, data
        LDR r2, [r1], #4
        STR r2, [r0]
        LDR r2, [r1], #4
        STR r2, [r0, #4]
        LDR r2, [r1], #4
        STR r2, [r0, #8]
        LDR r2, [r1], #4
        STR r2, [r0, #12]

		BL  sub1
		BL  sub2
stop    B   stop
; even parity for bits 3, 4, 5, 9 and 11 of the 
; word at memory address 0x40000000 into bit 8 of the word at memory address 0x40000008 
; (Note: Be sure to use TST and do not use EOR.)
; TST must, EOR no.
        ; r0 -> holds the address of memory (no change thanks)
        ; r1 -> hold the data (at 0x40000000, 0x40000008)
        ; r2 -> number of 1
        ; r3 -> temp
        ; r4 -> the parity
sub1    
        ; count the number of 1s
        LDR r1, [r0]
        MOV r2, #0
        ROR r3, r1, #3          ; get bit 3
        AND r3, r3, #1          ; isolate bit
        ADD r2, r2, r3 
        
        ROR r3, r1, #4          ; get bit 4
        AND r3, r3, #1          ; isolate bit
        ADD r2, r2, r3 
        
        ROR r3, r1, #5          ; get bit 5
        AND r3, r3, #1          ; isolate bit
        ADD r2, r2, r3

        ROR r3, r1, #9          ; get bit 9
        AND r3, r3, #1          ; isolate bit
        ADD r2, r2, r3  
        TST r2, #1              ; test if r2 is odd
        
        MOVNE r4, #0            ; if Z flag is clear NE, even
        MOVEQ r4, #1            ; if Z flag is set EQ, odd

        ; place the parity to the data (at 0x40000008)
        LDR r1, [r0, #8]
        ROR r3, r1, #8          ; get bit 8
        BIC r3, #1
        ADD r3, r3, r4          ; place the parity
        ROR r1, r3, #24         ; rotate the data back in place
        STR r1, [r0, #8]
        
        BX  lr
sub2
; odd parity for bits 6, 9, 13. 16 and 19 of the word at memory address 
; 0x40000000 into bit 20 of the word at memory address 0x40000008.
; (Note: Do not use TST and EOR.)
; TST no, EOR no. fuck you :D

; count the number of 1s
        LDR r1, [r0]
        MOV r2, #0
        ROR r3, r1, #6          ; get bit 6
        AND r3, r3, #1          ; isolate bit
        ADD r2, r2, r3 
        
        ROR r3, r1, #9          ; get bit 9
        AND r3, r3, #1          ; isolate bit
        ADD r2, r2, r3 
        
        ROR r3, r1, #13          ; get bit 13
        AND r3, r3, #1          ; isolate bit
        ADD r2, r2, r3

        ROR r3, r1, #16          ; get bit 16
        AND r3, r3, #1          ; isolate bit
        ADD r2, r2, r3  
        
        ROR r3, r1, #19          ; get bit 19
        AND r3, r3, #1          ; isolate bit
        ADD r2, r2, r3 

        ANDS r2, r2, #1         ; test if r2 is odd

        MOVNE r4, #1            ; if Z flag is clear NE, even
        MOVEQ r4, #0            ; if Z flag is set EQ, odd

        ; place the parity to the data (at 0x40000008)
        LDR r1, [r0, #8]
        ROR r3, r1, #20          ; get bit 20
        BIC r3, #1
        ADD r3, r3, r4          ; place the parity
        ROR r1, r3, #12         ; rotate the data back in place
        STR r1, [r0, #8]
        BX  lr

data    DCD 0x8765ABCD, 0xCDEF6543, 0xFACEBEEF, 0x87654321

        END