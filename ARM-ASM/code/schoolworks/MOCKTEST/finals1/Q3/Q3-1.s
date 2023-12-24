MEM_ADD EQU     0x40000000
        AREA Q3_1, CODE
        ENTRY
        ; r0 -> holds the memory address
        ; r1 -> holds the address of data
        ; r2 -> temp
        ; r3 -> temp
        ; r4 -> holds the address of data2
        ; r5 -> holds the address for parity checker
        LDR r0, =MEM_ADD
        ADR r1, data
        ADR r4, data2
        LDR r5, =0x40000030

        LDR r2, [r1] ,#4
        STR r2, [r0]

        LDR r2, [r1] ,#4
        STR r2, [r0, #4]
        
        LDR r2, [r1] ,#4
        STR r2, [r0, #8]
        
        LDR r2, [r1] ,#4
        STR r2, [r0, #12]

        BL  CheckParity
        STR	r11, [r5],#4
        BL  CheckParity
        STR	r11, [r5],#4
        BL  CheckParity
        STR	r11, [r5],#4
        BL  CheckParity
        STR	r11, [r5],#4
		
stop    B   stop
        ; r10 -> holds the data to be checked
        ; r11 -> odd: 0xFACEFACE, even: 0xBEEFBEEF
CheckParity
        MOV r3, #1
        LDR  r2, [r0]
        LDR r10, [r0,#4]

loop1   CMP r3, #32
        EOR r2, r2, r10, ROR r3
        ADD r3, r3, #1
        BNE loop1
        TST r2, #1              ; test the bit
        LDRNE	r11, [r4]       ; if teh Z flag is not set NE -> odd
        LDREQ	r11, [r4,#4]    ; if the Z flag is set EQ -> even
        BX  lr

data    DCD 0xCDEF5678, 0x5678CDEF, 0xBEEFFACE, 0xFACEBEEF
            ; 0,  4, 8, 12
data2 	DCD 0xFACEFACE, 0xBEEFBEEF
        END