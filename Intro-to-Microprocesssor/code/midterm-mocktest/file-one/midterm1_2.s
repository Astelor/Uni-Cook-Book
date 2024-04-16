		AREA 	midterm1_2, CODE, READONLY
SPSTART EQU		0x40000020
		ENTRY
		LDR		r0, =0xBEEFFACE
		LDR		sp, =SPSTART		; initialize stack pointer
		BL		Compute

done 	B		done

; Subroutine: Compute
; input: r0
; output: r1
; register used:
; r5 - scratch
; r6 - scratch

Compute
		STMDB	sp!, {r5, r6, LR}	; empty descending stack
		; (a)
		MOV		r5, r0 			; make a copy of r0
		ROR		r5, #16			; rotate r5 by 4 bytes
		BIC		r5, #0xFF		; clear out the lower quarter
		ADD		r5, #0xDD		; insert the value
		ROR		r5, #16			; rotate r5 by 4 bytes (back to normal)
		MOV		r0, r5			; place the result back to r0
		
		; (b)
		MOV		r5, r0			; make a copy of r0
		ROR		r5, #20			; get bit 20
		AND		r5, #0xFF		; clear out the upper nibbles
		MOV		r1, r5			; place the result to r1
		
		; (c)
		LDR		r5, =0x8300
		EOR		r0, r5			; change bits 8 9 15 of r0

		LDMIA	sp!, {r5, r6 ,PC}

		END