 			AREA   AIRCRTest, CODE, READONLY
AIRCR		EQU 0x40000400
RAMSTART	EQU	0x400000B0

		ENTRY
start
		LDR     sp, =RAMSTART
		LDR 	r0, =AIRCR

		MOV		r2, #0x1F; r2 = 0b 0001 1111 (AIRCR width = 5)
		STRB	r2, [r0]
		LDRB	r2, [r0]

		MOV		r10, #0
		
		BL	with_test_pattern_LSR
		MOV		r3, r10
		BL	with_test_pattern_LSL
		MOV		r4, r10
		BL	without_test_pattern_LSR
		MOV		r5, r10
		BL	without_test_pattern_LSL
		MOV		r6, r10
		
stop	B	stop

; Conditional execution:
; Suffix | Flags
; EQ	 | Z set	(the result is 0)
; NE	 | Z clear	(the result is not 0)


; Subroutine: (a) using LSR with test pattern LSR
; r1 - width counter
; r2 - scrap
; r3 - test pattern
; r4 - AIRCR value
; input: none
; output: r10 (AIRCR width)

with_test_pattern_LSR
		STMED   sp!, {r1-r4, lr}
		MOV		r3, #0x80 ; r3 = 0b 1000 0000 (test pattern)
		LDR		r2, =AIRCR
		LDRB	r4, [r2]  ; r4 = 0b 0011 1111 (AIRCR width = 6)
; LSR pattern until the pattern touches the first 1 in AIRCR
test1
		TST		r4, r3
		LSREQ	r3, #1
		BEQ		test1

		MOV		r1, #0 	; reset tally
LOOP1
		CMP		r1, #8 	; if reach max_width?
		BEQ		OUT1 	; yes -> test finish ->> width = max_width
		TST		r4, r3	; test pattern & AIRCR != 0?
		BEQ		OUT1 	; NE (result is not 0 before reach max_width) ->> width = width_counter
		ADD		r1, #1 	; 
		LSR		r3, #1 	; right slide test pattern
		B	LOOP1
OUT1
		MOV		r10, r1	; move the tally to output register
		LDMED	sp!, {r1-r4, pc}

; Subroutine: (b) using LSL with test pattern LSL
; r1 - width counter
; r2 - scrap
; r3 - test pattern
; r4 - AIRCR value
; input: none
; output: r10 (AIRCR width)

with_test_pattern_LSL
		STMED   sp!, {r1-r4, lr}
		MOV		r3, #0x1 ; r3 = 0b 0000 0001 (test pattern)
		LDR		r2, =AIRCR
		LDRB	r4, [r2] ; r4 = 0b 0011 1111 (AIRCR width = 6)
		
		MOV		r1, #0 	; reset tally
LOOP2
		CMP		r1, #8 	; if reach max_width?
		BEQ		OUT2 	; yes -> test finish ->> width = max_width
		TST		r4, r3	; test pattern & AIRCR != 0?
		BEQ		OUT2 	; NE (result is not 0 before reach max_width) ->> width = width_counter
		ADD		r1, #1 	; 
		LSL		r3, #1 	; left slide test pattern
		B	LOOP2
OUT2
		MOV		r10, r1	; move the tally to output register
		LDMED	sp!, {r1-r4, pc}

; Subroutine: (c) using LSR without test pattern LSR
; r1 - width counter
; r2 - scrap
; r3 - test pattern
; r4 - AIRCR value
; input: none
; output: r10 (AIRCR width)

without_test_pattern_LSR
		STMED   sp!, {r1-r4, lr}
		MOV		r3, #0x1; r3 = 0b 0000 0001 (test pattern)
		LDR		r2, =AIRCR
		LDRB	r4, [r0]; r4 = 0b 0011 1111 (AIRCR width = 6)
		
		MOV		r1, #0	; reset tally
LOOP3
		CMP		r1, #8 	; if reach max_width?
		BEQ		OUT3 	; yes -> test finish ->> width = max_width
		TST		r4, r3 	; test pattern & AIRCR != 0?
		BEQ		OUT3 	; NE (result is not 0 before reach max_width) ->> width = width_counter
		ADD		r1, #1 	; width_counter++
		LSR		r4, #1 	; right slide AIRCR data
		B		LOOP3
OUT3
		MOV		r10, r1 ; move tally to output register
		LDMED   sp!, {r1-r4, pc}
		
; Subroutine:(d) using LSR without test pattern LSR
; r1 - width counter
; r2 - scrap
; r3 - test pattern
; r4 - AIRCR value
; input: none
; output: r10 (AIRCR width)

without_test_pattern_LSL
		STMED   sp!, {r1-r4, lr}
		MOV		r3, #0x80	; r3 = 0b 1000 0000 (test pattern)
		LDR		r2, =AIRCR
		LDRB	r4, [r0]	; r4 = 0b 0011 1111 (AIRCR width = 6)
; LSL AIRCR until the AIRCR touches the pattern
test4
		TST		r3, r4
		LSLEQ	r4, #1
		BEQ		test4

		MOV		r1, #0	; reset tally
LOOP4
		CMP		r1, #8 	; if reach max_width?
		BEQ		OUT4 	; yes -> test finish ->> width = max_width
		TST		r3, r4 	; test pattern & AIRCR != 0?
		BEQ		OUT4 	; NE (result is not 0 before reach max_width) ->> width = width_counter
		ADD		r1, #1 	; width_counter++
		LSL		r4, #1 	; right slide AIRCR data
		B		LOOP4
OUT4
		MOV		r10, r1 ; move tally to output register
		LDMED   sp!, {r1-r4, pc}
		
		END