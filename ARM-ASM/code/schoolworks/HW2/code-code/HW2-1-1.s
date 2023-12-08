    AREA HW2_part1_1, CODE, READONLY
    ENTRY
    LDR     r3, =731
	LDR		r7, =0xFFFFFFFF	; -1
	LDR		r8, =6
	LDR		r9, =9
    MUL     r1, r3, r3      ; x^2 -> temp
    MUL     r4, r1, r8      ; 6x^2
    MUL     r1, r3, r9      ; 9x -> temp
    MUL		r5, r1, r7		; -9x
	MOV     r6, #2          ; 2
    
	ADD     r2, r2, r4
    ADD     r2, r2, r5
    ADD     r2, r2, r6
stop B stop
    END	;	[REDACTED] Aster Chen, verified