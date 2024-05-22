; okay how tf do I write this from scratch?
; do I need all the exception handling stuffs?
; wait wdym AIRCR is at 0x400000C8?
; so I use ARM to do this?

			AREA	HW2_3, CODE, READONLY
RAMSTART    EQU     0x40000000      ; start of onboard RAM for 2104	
SPoint		EQU		0x40000A00
AIRCR		EQU		0x400000C8
			ENTRY
Start			
			LDR		sp, =SPoint
			
			; priority group number should be a 3 bit number
			LDR		r8, =0x5		; 4 implemented bits
			LDR		r9, =0xBA		; IRQ 1011 1010
			LDR		r10, =0x5		; priority grouping number
			;BL		Question1
			;BL		Question2
			BL		Question3
			
done		B		done


; Subroutine: Question 1
; input: r10
; output: none
Question1
			STMIA	sp!, {r5, r6, r7, LR} ; empty ascending stack
			
			; r5 - address of AIRCR
			; r6 - value of AIRCR
			; r7 - scrap
			
			LDR		r5, =AIRCR
			LDR		r6, [r5]
			ROR		r6, #8
			
			BIC		r6, #7		; clear out the nibble
			ORR		r6, r10
			
			ROR		r6, #24
			STR		r6, [r5]
			LDMDB	sp!, {r5, r6, r7, PC}

; Subroutine: Question 2
; input: none
; output: none
Question2
			STMIB	sp!, {r5, r6, r7, LR} ; full ascending stack
			
			; r5 - address of AIRCR
			; r6 - value of AIRCR
			; r7 - scrap
			
			LDR		r5, =AIRCR
			LDR		r6, [r5]
			LSR		r6, #8
			AND		r6, #7
			
			LDMDA	sp!, {r5, r6, r7, PC}

; Subroutine: Question 3
; input: r8, r9, r10
; output: r1, r2
Question3
			STMDA	sp!, {r5, r6, r7, LR} ; empty descending stack
			
			; r1 - pre-emption priority [7:(r10)+1]
			; r2 - sub-priority group [r10:0]
			;
			; r5 - scrap
			; r6 - scrap
			; r7 - scrap
			;
			; r8 - 4 implemented bits
			; r9 - IRQ
			; r10- priority group number (determines the split point)

			; silver bullet (sort of)
			MOV		r6, #8
			SUB		r5, r6, r8	; width of the un-implemented lower part
			
			LSR		r7, r9, r5	; clear the un-implemented lower part
			
			MOV		r5, #8
			SUB		r6, r5, r8
			SUB		r5, r10, r6	; width of sub-priority bits
			MOV		r6, #0
			; generate mask for subpriority bits 
loop		
			CMP		r5, #0
			LSLGE	r6, r6, #1
			SUBGE	r5, #1
			ORRGE	r6, #1
			BGE		loop
			
			AND		r2, r7, r6
			MVN		r5, r6		; invert the mask for group priority
			AND		r7, r5
			
			MOV		r5, #8
			SUB		r6, r5, r8
			CMP		r10, r6
			SUBGE	r5, r10, r6
			ADDGE	r5, #1
			LSRGE	r1, r7, r5
			; surely it works
			
			LDMIB	sp!, {r5, r6, r7, PC}
			END