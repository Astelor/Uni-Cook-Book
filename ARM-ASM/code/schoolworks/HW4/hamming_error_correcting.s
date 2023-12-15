        AREA    hw4, CODE
        ENTRY
        ; registers used:
        ; r0 - used to hold the 12-bit data
        ; r1 - temp
        ; r2 - used to hold address of data
        ; r3 - used to hold the faulty checksum index
        ; r4 - temp
        ; r5 - hold the index of the faulty bit (12 bit)
        ; r6 - holds the 8-bit data
        ; r7 - temp
        ; r8 - big counter
		; 411440117 Aster Chen
        MOV     r8, #7
        ADR     r2, data
main    
        MOV     r3, #0
        MOV     r6, #0
        LDRH     r0, [r2], #2
        
        MOV     r4, r0              ; makes a copy
        ; check c0 ----------------------------------------------|
        EOR     r4, r4, r0, ROR #2
        EOR     r4, r4, r0, ROR #4
        EOR     r4, r4, r0, ROR #6
        EOR     r4, r4, r0, ROR #8
        EOR     r4, r4, r0, ROR #10
        ANDS    r4, r4, #1          ; isolate bit

        ; if the Z flag is clear(not zero), the c0 parity isn't even
        ORRNE   r3, r3, #1        ; AND the bits to find the matching ones

        ; check c1 ----------------------------------------------|
        ROR     r4, r0, #1          ; get bit 1
        EOR     r4, r4, r0, ROR #2  ; 2 XOR 1
        EOR     r4, r4, r0, ROR #5
        EOR     r4, r4, r0, ROR #6
        EOR     r4, r4, r0, ROR #9
        EOR     r4, r4, r0, ROR #10
        ANDS    r4, r4, #1          ; isolate bit

        ; if the Z flag is clear, the c1 parity isn't even
        ORRNE   r3, r3, #2

        ; check c2 ----------------------------------------------|
        ROR     r4, r0, #3          ; get bit 3
        EOR     r4, r4, r0, ROR #4  ; 3 XOR 4
        EOR     r4, r4, r0, ROR #5
        EOR     r4, r4, r0, ROR #6
        EOR     r4, r4, r0, ROR #11
        ANDS    r4, r4, #1          ; isolate bit
        
        ; if the Z flag is clear, the c2 parity isn't even
        ORRNE   r3, r3, #4

        ; check c3 ----------------------------------------------|
        ROR     r4, r0, #7          ; get bit 7
        EOR     r4, r4, r0, ROR #8
        EOR     r4, r4, r0, ROR #9
        EOR     r4, r4, r0, ROR #10
        EOR     r4, r4, r0, ROR #11
        ANDS    r4, r4, #1

        ; if the Z flag is clear, the c3 parity isn't even
        ORRNE   r3, r3, #8

        ; checking stage... -------------------------------------|
        ; check how many faulty checksums there are
        ;(if r4==0|1->build, 2|3->fix, 4->unfixable)
        MOV     r4, #0              ; clear r4
        MOV     r7, #0              ; clear r7
errcnt    ; 411440117 Aster Chen
        CMP     r7, #3
        ROR     r5, r3, r7          ; get bit
        AND     r5, r5, #1          ; isolate bit
        ADD     r4, r4, r5
        ADD     r7, r7, #1
        BNE     errcnt

        CMP     r4, #0              ; there's no error here
        BEQ     build
        CMP     r4, #1
        BEQ     build
        CMP     r4, #4              ; too many errors, terminates program
        BEQ     stop

        ; find the faulty bit-------------------------------------|
        MVN     r5, #0              ; set to -1
        MOV     r7, #0              ; clear r7
findb   
        CMP     r7, #3
        ROR     r4, r3, r7          ; get bit
        AND     r4, r4, #1          ; isolate bit
        ADD     r5, r5, r4, LSL r7
        ADD     r7, r7, #1
        BNE     findb
        ; r5 now has the index of faulty bit

        ROR     r4, r0, r5          ; get the faulty bit
        EOR     r4, r4, #1          ; invert the faulty bit
        SUB     r7, r5, #32
        MVN     r1, r7              ; idk how to do it better
        ADD     r7, r1, #1
        ROR     r0, r4, r7

        ; build the 8-bit data
        ; if there's any error in the 12-bit data, it should've been fixed
build   ROR     r4, r0, #2          ; (1)get bit 2 from 12 bit data
        AND     r6, r4, #1          ; isolate bit and emplace to 8 bit data

        ROR     r4, r0, #3          ; (2)get bit 4~6 to the correct place
        AND     r4, r4, #0xE        ; isolate bit
        ORR     r6, r6, r4          ; emplace the 3~1 bits into 8 bit data

        ROR     r4, r0, #4          ; (3)get bit 8~11 to the correct place
        AND     r4, r4, #0xF0       ; isolate bit
        ORR     r6, r6, r4          ; emplace the 4~7 bits into 8-bit data
        ; r6 now has the correct 8-bit data
        
        CMP     r8, #0              ; big counter
        SUB     r8, #1
        BNE     main
        ALIGN
stop 	B		stop; 411440117 Aster Chen
data    
		DCW     0xA3E ; 12 bit data for 0xA7
		DCW     0xA3F, 0xA3C, 0xA36, 0xABE, 0xA2E, 0x83E
        END