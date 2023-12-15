        AREA    hw4, CODE
        ENTRY
        ; registers used:
        ; r0 - temp 1
        ; r1 - used to hold address of cmasks
        ; r2 - used to hold address of data
        ; r3 - (change to holding the incorrect checksum)used to hold the location of the incorrect bit
        ; r4 - temp 2
        ; r5 - used to hold the location of the incorrect bit
        ; r6 - holds the 8-bit data

        ADR     r1, cmask
        ADR     r2, data
main    
        MOV     r3, #0
        MOV     r5, #0
        MOV     r6, #0
        LDR     r0, [r2,#4]
        
        ; check c0 ----------------------------------------------|
        MOV     r4, r0              ; makes a copy
        EOR     r4, r4, r0, ROR #2
        EOR     r4, r4, r0, ROR #4
        EOR     r4, r4, r0, ROR #6
        EOR     r4, r4, r0, ROR #8
        EOR     r4, r4, r0, ROR #10
        ANDS    r4, r4, #1          ; isolate bit

        ;LDR     r4, [r1], #4
        ; if the Z flag is clear(not zero), the c0 parity isn't even
        ORRNE     r3, #1, r3        ; AND the bits to find the matching ones
        ;ORREQ     r3, r3, r4


        ; check c1 ----------------------------------------------|
        ROR     r4, r0, #1          ; get bit 1
        EOR     r4, r4, r0, ROR #2  ; 2 XOR 1
        EOR     r4, r4, r0, ROR #5
        EOR     r4, r4, r0, ROR #6
        EOR     r4, r4, r0, ROR #9
        EOR     r4, r4, r0, ROR #10
        ANDS    r4, r4, #1          ; isolate bit

        ;LDR     r4, [r1], #4
        ; if the Z flag is clear, the c1 parity isn't even
        ORRNE     r3, #1, r3, ROR #1 
        ;ORREQ   r3, r3, r4

        ; check c2 ----------------------------------------------|
        ROR     r4, r0, #3          ; get bit 3
        EOR     r4, r4, r0, ROR #4  ; 3 XOR 4
        EOR     r4, r4, r0, ROR #5
        EOR     r4, r4, r0, ROR #6
        EOR     r4, r4, r0, ROR #11
        ANDS    r4, r4, #1          ; isolate bit
        
        ;LDR     r4, [r1], #4
        ; if the Z flag is clear, the c2 parity isn't even
        ORRNE     r3, #1, r3, ROR #2
        ;ORREQ   r3, r3, r4

        ; check c3 ----------------------------------------------|
        ROR     r4, r0, #7          ; get bit 7
        EOR     r4, r4, r0, ROR #8
        EOR     r4, r4, r0, ROR #9
        EOR     r4, r4, r0, ROR #10
        EOR     r4, r4, r0, ROR #11
        ANDS    r4, r4, #1

        ;LDR     r4, [r1], #4
        ; if the Z flag is clear, the c3 parity isn't even
        ORRNE     r3, #1, r3, ROR #3
		;ORREQ   r3, r3, r4


        BIC     r3, r3, r3          ; invert bits in r3, now r3 contains set bits
                                    ; that is un-confirmed to be correct or not.
        AND     r5, r3, r3          ; mask r3 onto r5, r5 now contains only incorrect bits
        ; fetch the 8-bit data if there's no error
		;TST		r5, #0
		;ORR     r6, r6, r0, LSR #4
        ;ORR     r4, r4, r0, ROR #1
        ;AND     r4, r4, #1
		
        ; if there's a fixable error, fix it here

        ALIGN
stop 	B		stop
cmask   DCD     0x555, 0x666, 0x878, 0xF80
data    DCD     0xBA6 ; 12 bit data for 0xB5
        DCD     0xB26
        END