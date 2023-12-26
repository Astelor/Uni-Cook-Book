MEM_ADD EQU 0x40000000
        AREA Q4_1, CODE
        ENTRY
        ; r0 -> holds the address of memory
        ; r1 -> holds the address of data
        ; r2 -> temp
        LDR r0, =MEM_ADD
        ADR r1, data
		LDMIA r1, {r2-r5}
		STMIA r0, {r2-r5}
        MOV r2, #0
		MOV r3, #0
		MOV r4, #0
		MOV r5, #0

		;BL  sub1
		;BL  sub2
		BL sub6

stop    B   stop
; sub1 puts even parity for bits 4, 5, 6, 10 and 12 of the word at memory address 0x40000000 
; into bit 9 of the word at memory address 0x40000004 
; (Note: Be sure to use TST and do not use EOR.)
; TST must, EOR no.
        ; r0 -> holds the address of memory (no change thanks)
        ; r1 -> hold the data (at 0x40000000, 0x40000004)
        ; r2 -> number of 1
        ; r3 -> temp
        ; r4 -> the parity
sub1    
        ; count the number of 1s
        LDR r1, [r0]
        MOV r2, #0
        ROR r3, r1, #4          ; get bit 3
        AND r3, r3, #1          ; isolate bit
        ADD r2, r2, r3 
        
        ROR r3, r1, #5          ; get bit 4
        AND r3, r3, #1          ; isolate bit
        ADD r2, r2, r3 
        
        ROR r3, r1, #6          ; get bit 5
        AND r3, r3, #1          ; isolate bit
        ADD r2, r2, r3

        ROR r3, r1, #10          ; get bit 9
        AND r3, r3, #1          ; isolate bit
        ADD r2, r2, r3 
		
		ROR r3, r1, #12          ; get bit 9
        AND r3, r3, #1          ; isolate bit
        ADD r2, r2, r3 
		
        TST r2, #1              ; test if r2 is odd
        
        MOVNE r4, #0            ; if Z flag is clear NE, even
        MOVEQ r4, #1            ; if Z flag is set EQ, odd

        ; place the parity to the data (at 0x40000004)
        LDR r1, [r0, #4]
        ROR r3, r1, #9          ; get bit 8
        BIC r3, #1
        ADD r3, r3, r4          ; place the parity
        ROR r1, r3, #13         ; rotate the data back in place (32-bit)
        STR r1, [r0, #4]
        
        BX  lr
sub2
; odd parity for bits 6, 9, 13. 16 and 19 of the word at memory address 
; 0x40000000 into bit 20 of the word at memory address 0x40000008.
; (Note: Do not use TST and EOR.)
; TST no, EOR no.

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
        LDR r1, [r0, #4]
        ROR r3, r1, #20          ; get bit 20
        BIC r3, #1
        ADD r3, r3, r4          ; place the parity
        ROR r1, r3, #12         ; rotate the data back in place
        STR r1, [r0, #4]
        BX  lr
		
; sub3 puts bits 30, 29, 28, 27, 15, 14, 12, 11, 10 
; of the word at memory address 0x40000000 
; into bits 24~16 of the word at memory address 0x40000004 respectively,
sub3
		; r0 -> address of the data
		; r1 -> data
		; r2 -> data 2
		; r3 -> temp
		; r4 -> output
		; r5 -> temp
		LDR r0, =MEM_ADD
		MOV r4, #0				; the output
		LDR r1, [r0]
		ROR r3, r1, #10          ; get bit 9
        AND r3, r3, #0x7         ; isolate bit
        ADD r4, r4, r3
		
		LSL r4, r4, #3
		ROR r3, r1, #14          ; get bit 9
        AND r3, r3, #0x3         ; isolate bit
        ADD r4, r4, r3
		
		LSL r4, r4, #2
		ROR r3, r1, #27          ; get bit 9
        AND r3, r3, #0xF         ; isolate bit
        ADD r4, r4, r3
		
		LDR r2, [r0, #4]
		ROR r3, r2, #16
		LDR r5, =0x1FF
		BIC r3, r5
		ADD r3, r3, r4
		ROR r5, r3, #16
		STR r5, [r0, #4]
		
		BX lr

; sub4 puts the number of different bits between the word 
; at memory address 0x40000008 and the word at memory address 0x4000000C into r0 
; using TST
sub4	
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
		MOV r0, #0
loop4	
		LSR r5, r3, r4
		TST r5, #1
		ADDNE r0, r0, #1		; z flag not set -> not zero
		ADD r4, r4, #1
		CMP r4, #32
		BNE loop4
		BX lr
		
; sub5 puts the number of different bits between the word 
; at memory address 0x40000008 and the word at memory address 0x4000000C into r1 
; without using TST.
sub5
		; r0 -> address of data
		; r1 -> data 1
		; r2 -> data 2
		; r3 -> eor
		; r4 -> counter
		; r5 -> temp
		; 
		LDR r0, =MEM_ADD
		LDR r1, [r0, #8]
		LDR r2, [r0, #12]
		EOR r3, r1, r2
		MOV r4, #0
		MOV r1, #0
loop5
		LSR r5, r3, r4
		AND r5, r5, #1
		ADD r1, r5, r1
		ADD r4, r4, #1
		CMP r4, #32
		BNE loop5
		BX lr

; sub6 puts the different bit numbers between the word
; at memory address 0x40000008 and the word at memory address 0x4000000C one by one 
; in the words started from memory address 0x40000070.
sub6	
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

		BX lr

data    DCD 0x8765ABCD, 0xCDEF6543, 0xFACEBEEF, 0x87654321

        END