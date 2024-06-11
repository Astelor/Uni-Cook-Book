RAMSTART    EQU     0x40000000      ; start of onboard RAM for 2104	
SPoint		EQU		0x40000A00
AIRCR		EQU		0x400000C8

			AREA	HW2_3, CODE, READONLY
			ENTRY
Start			
			LDR		sp, =SPoint
			
			; (1)
			; IRQ = 0b 1110 1111
			; priority grouping = 3
			; 7 implemented bits
			; [xxx,yyyyo] x: group. y: sub-priority
			; [111,01111] x: 0b 111, y: 0b 0111
			; group priority: 7, sub-priority: 7
			; priority group number should be a 3 bit number
			LDR		r8, =0x7		; 4 implemented bits
			LDR		r9, =0xEF		; IRQ 1011 1010
			LDR		r10, =0x3		; priority grouping number
			
			BL		Priority
			
done		B		done

; Subroutine: Question 3
; input: r8, r9, r10
; output: r1, r2
; silver bullet (sort of)
Priority
			STMDA	sp!, {r5, r6, r7, LR} ; empty descending stack
			
			; r1 - pre-emption priority [7:(r10)+1]
			; r2 - sub-priority group [r10:0]
			; r5 - scrap
			; r6 - scrap
			; r7 - scrap
			; r8 - 4 implemented bits
			; r9 - IRQ
			; r10- priority group number (determines the split point)

			MOV		r6, #8
			SUB		r5, r6, r8	; width of the un-implemented lower part
			
			LSR		r7, r9, r5	; clear the un-implemented lower part
								; r7 is set here to preserve the values of r5 and r6 below
			;MOV		r5, #8
			;SUB		r6, r5, r8
			SUB		r5, r8, r10	; width of sub-priority bits
			MOV		r6, #0
; generate mask for subpriority bits 
loop		
			CMP		r5, #0
			LSLGT	r6, r6, #1
			SUBGT	r5, #1
			ORRGT	r6, #1
			BGT		loop
			
			AND		r2, r7, r6	; use the mask on sub-priority group
			MVN		r5, r6		; invert the mask for group priority
			AND		r7, r5
			
			
			SUB		r6, r8, r10	; width of sub-priority bits
			MOV		r5, #8
			SUB		r6, r5, r6
			LSR		r1, r7, r6
			
			LDMIB	sp!, {r5, r6, r7, PC}
			END