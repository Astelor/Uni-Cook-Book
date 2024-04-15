		AREA 	midterm1_1, CODE, READONLY
ADD0	EQU		0x40000000
ADD1	EQU 	0x40000060
		ENTRY
		LDR		r0, =data1
		LDMIA	r0, {r4-r7}
		LDR		r1, =ADD1
		STMIA	r1, {r4-r7}
		
		LDR		r2, =ADD0		; reset r4-r7
		LDMIA	r2, {r4-r7}
		
		; (a)
		MOV		r2, r1			; make a copy of ADD1
		ADD		r2, #0xC		; decrease "after"
		LDMDA	r2, {r4-r7}
		
		; (b)
		MOV 	r2, r1			; make a copy of ADD1
		ADD		r2, #0x10		; decrease "before"
		LDMDB	r2, {r4-r7}
		
		; (c)
		MOV		r2, r1			; make a copy of ADD1
		LDMIA	r2, {r4-r7}		; increase "after"
		
		; (d)
		MOV		r2, r1			; make a copy of ADD1
		SUB		r2, #4
		LDMIB	r2, {r4-r7}		; increase "before"
		
		; (e)
		MOV		r2, r1			; make a copy of ADD1
		ADD		r2, #0xC
		STMDA	r2, {r4-r7}
		
		; (f)
		MOV		r2, r1			; make a copy of ADD1
		ADD		r2, #0x10
		STMDB	r2, {r4-r7}
		
		; (g)
		MOV		r2, r1			; make a copy of ADD1
		STMIA	r2, {r4-r7}
		
		; (h)
		MOV		r2, r1			; make a copy of ADD1
		SUB		r2, #4
		STMIB	r2, {r4-r7}
		
done 	B		done
data1	DCD 	0xFACEBEEF, 0xBEEFFACE, 0x87654321, 0x12345678
		END