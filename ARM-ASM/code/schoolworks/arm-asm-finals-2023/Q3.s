MEM_ADD EQU 0x40000040
        AREA Q3_1, CODE
        ENTRY
 
        LDR r8, =MEM_ADD
        ADR r9, data
		LDMIA r9, {r0-r3}
		STMIA r8, {r0-r3} 	; initialize poggg
q_1		LDR r7, =MEM_ADD	; make a copy
		LDMIA r7, {r0-r3}
		
q_2		SUB r7, r8, #4
		LDMIB r7, {r1-r4}  ; 411440117 Aster Chen
		
q_3		ADD r7, r8, #12
		LDMDA r7, {r2-r5}
		
q_4		ADD r7, r8, #16
		LDMDB r7, {r3-r6}
		
		LDMIA r9, {r0-r3}	; initialize
q_5		LDR r8, =0x40000058
		STMIA r8, {r0-r3}
		
q_6		ADD r8, r8, #16
		SUB r7, r8, #4
		STMIB r7, {r0-r3}
		
q_7		ADD r8, r8, #16
		ADD r7, r8, #12
		STMDA r7, {r0-r3}
		
q_8		ADD r8, r8, #16
		ADD r7, r8, #16
		STMDB r7, {r0-r3}

stop 	B stop ; 411440117 Aster Chen
data    DCD 0x87654321, 0x12345678, 0xFACEBEEF, 0xBEEFFACE
        END ; 411440117 Aster Chen