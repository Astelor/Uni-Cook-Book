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
			LDR		r8, =0x1F		; sub-priority bits mask (5)
			LDR		r9, =0x4B		; IRQ 0100 1011
			LDR		r10, =0x4		; priority group number
			BL		Question1
			BL		Question2
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
; output: none
Question3
			STMDA	sp!, {r5, r6, r7, LR} ; empty descending stack
			
			; r5 - pre-emption priority [7:(r10)+1]
			; r6 - sub-priority group [r10:0]
			; r7 - scrap
			
			; r8 - sub-priority bit mask
			; r9 - IRQ
			; r10- priority group number
			
			MVN		r7, r8
			AND		r5, r9, r7
			
			AND		r6, r9, r8
			
			LDMIB	sp!, {r5, r6, r7, PC}
			END