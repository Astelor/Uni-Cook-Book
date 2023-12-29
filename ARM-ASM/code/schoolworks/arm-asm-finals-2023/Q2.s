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
		
		BL func1 ; 411440117 Aster Chen
		BL func2a
		BL func2b
		BL func3
		BL func4
		BL func5
		
stop    B   stop

; func1 uses EOR to put even parity for bits 3, 4, 5, 9 and 11 of the word 
; at memory address 0x40000000 into bit 8 of the word at memory address 0x40000004
; 411440117 Aster Chen
		; r0 -> holds the address of memory (no change thanks)
        ; r1 -> hold the data (at 0x40000000, 0x40000004)
        ; r2 -> number of 1
        ; r3 -> temp
        ; r4 -> the parity
func1  
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
		
		ROR r3, r1, #9          ; get bit 11
        AND r3, r3, #1          ; isolate bit
        ADD r2, r2, r3  
        TST r2, #1              ; test if r2 is odd
        
        MOVNE r4, #0            ; if Z flag is clear NE, even
        MOVEQ r4, #1            ; if Z flag is set EQ, odd

        ; place the parity to the data (at 0x40000004)
        LDR r1, [r0, #4]
        ROR r3, r1, #8          ; get bit 8
        BIC r3, #1
        ADD r3, r3, r4          ; place the parity
        ROR r1, r3, #24         ; rotate the data back in place
        STR r1, [r0, #4]
        BX  lr
; func2a and func2b put odd parity for bits 2, 4, 6 and 8 of the word
; at memory address 0x40000000 into bit 9 of the word at memory address 0x40000004.
; (a) use EOR
; (b) use TST no EOR
; 411440117 Aster Chen
func2a
		
		LDR r1, [r0]
		ROR r2, r1, #2 				; get bit 2
		EOR	r2, r2, r1, ROR #4
		EOR	r2, r2, r1, ROR #6
		EOR	r2, r2, r1, ROR #8
		
		AND r2, r2, #1 				; isolate bit
		EOR	r2, r2, #1				; invert the bit for odd parity
		LDR r1, [r0, #4]
		ROR r3, r1, #9
		BIC r3, #1
		ADD r3, r3, r2
		ROR r1, r3, #23
		STR r1, [r0, #4]
		
        BX  lr
func2b
		; r0 -> holds the address of memory (no change thanks)
        ; r1 -> hold the data (at 0x40000000, 0x40000008)
        ; r2 -> number of 1
        ; r3 -> temp
        ; r4 -> the parity
        ; count the number of 1s
        LDR r1, [r0]			; 411440117 Aster Chen
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
        
        MOVNE r4, #1            ; if Z flag is clear NE, even
        MOVEQ r4, #0            ; if Z flag is set EQ, odd

        ; place the parity to the data (at 0x40000008)
        LDR r1, [r0, #8]
        ROR r3, r1, #9         ; get bit 8
        BIC r3, #1
        ADD r3, r3, r4          ; place the parity
        ROR r1, r3, #23         ; rotate the data back in place
        STR r1, [r0, #4]
        
        BX  lr

; func3 puts bits 30, 29, 28, 27, 15, 14, 13, 10 of the word 
; at memory address 0x40000000 into bits 23~16 of the word 
; at memory address 0x40000004 respectively
; 411440117 Aster Chen
func3
		; r0 -> address of the data
		; r1 -> data
		; r2 -> data 2
		; r3 -> temp
		; r4 -> output
		; r5 -> temp
		LDR r0, =MEM_ADD
		MOV r4, #0				; the output
		LDR r1, [r0]
		ROR r3, r1, #10          ; get bit 10
        AND r3, r3, #1         	 ; isolate bit
        ADD r4, r4, r3
		
		LSL r4, r4, #1
		ROR r3, r1, #13          ; get bit 13
        AND r3, r3, #0x7         ; isolate bit 13~15
        ADD r4, r4, r3
		
		LSL r4, r4, #3
		ROR r3, r1, #27          ; get bit 27
        AND r3, r3, #0xF         ; isolate bit
        ADD r4, r4, r3
		
		LDR r2, [r0, #4]
		ROR r3, r2, #16
		LDR r5, =0xFF
		BIC r3, r5
		ADD r3, r3, r4
		ROR r5, r3, #16
		STR r5, [r0, #4]
		
        BX  lr
		
; func4 puts the number of different bits between the word 
; at memory address 0x40000008 and the word at memory address 0x4000000C 
; into the word at memory address 0x40000010.
; 411440117 Aster Chen
func4
		; r0 -> address of data
		; r1 -> data 1
		; r2 -> data 2
		; r3 -> eor
		; r4 -> counter
		; r5 -> temp
		LDR r0, =MEM_ADD
		LDR r1, [r0, #8]
		LDR r2, [r0, #12]
		EOR r3, r1, r2
		MOV r4, #0
loop4	
		LSR r5, r3, r4
		TST r5, #1
		ADDNE r6, r6, #1		; z flag not set -> not zero
		ADD r4, r4, #1
		CMP r4, #32
		BNE loop4
		STR r6, [r0, #10]
		
		BX lr
; func5 puts the different bit numbers between the word 
; at memory address 0x40000008 and the word at memory address 0x4000000C 
; one by one in the words started from memory address 0x40000070.
; 411440117 Aster Chen
func5	
		; r0 -> address of data
		; r1 -> data 1
		; r2 -> data 2
		; r3 -> eor
		; r4 -> counter
		; r5 -> temp
		
		LDR r0, =MEM_ADD
		LDR r1, [r0, #8]
		LDR r2, [r0, #12]
		EOR r3, r1, r2
		MOV r4, #0
		ADD r0, r0, #0x70
loop6	
		LSR r5, r3, r4
		
		ANDS r5, #1
		STRBNE r4, [r0], #1
		
		ADD r4, r4, #1
		CMP r4, #32
		BNE loop6
        BX  lr	
		
data    DCD 0x6543CDEF, 0xABCD8765, 0x12345678, 0xBEEFFACE 
        END ; 411440117 Aster Chen