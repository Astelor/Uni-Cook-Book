        AREA    midterm1, CODE, READONLY
ADD1    EQU     0x40000020
        ENTRY
        LDR     r0, =0x12345678
        LDR     r1, =0x87654321
        LDR     r2, =0xBEEFFACE
        LDR     r3, =0xDEADBEEF

        ; just shuffle these to get results
        ; (1)
        LDR     r9, =ADD1
        STMIA   r9, {r0-r3}		; increase after
        LDR     r9, =ADD1
		ADD		r9, #12
        LDMDA   r9, {r4-r7}		; decrease after
		
        ; (2)
		LDR		r9, =ADD1
		SUB		r9, #4
		STMIB	r9, {r0-r3}		; increase before

		LDR		r9, =ADD1
		ADD		r9, #16
		LDMDB	r9,	{r4-r7}		; decrease before
		
        ; (3)
		LDR		r9, =ADD1
		ADD		r9, #12
		STMDA	r9, {r0-r3} 	; decrease after

		LDR		r9, =ADD1
		LDMIA	r9, {r4-r7}		; increase after
		
        ; (4)
		LDR		r9, =ADD1
		ADD		r9, #16
		STMDB	r9, {r0-r3}		; decrease before
		
		LDR		r9, =ADD1
		SUB		r9, #4
		LDMIB	r9, {r4-r7}		; increase before

done	B 	done
		
        END
        