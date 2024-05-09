IntDefaultHandler

	; let's read the Usage Fault Status Register
	
	LDR		r7, =Usagefault
	LDRH	r1, [r6, r7]
	TEQ		r1, #0x200
	IT		NE
	LDRNE	r9, =0xDEADDEAD
	
	; r1 should have bit 9 set indicating
	; a divide-by-zero has taken place
	
	; switch to user Thread mode
	MRS		r8, CONTROL
	ORR		r8, r8, #1
	MSR		CONTROL, r8
	BX 		LR
	
	ALIGN