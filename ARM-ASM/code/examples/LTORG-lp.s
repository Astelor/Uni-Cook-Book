		AREA Example, CODE
		ENTRY 				; mark first instruction
		BL func1 			; call first subroutine
		BL func2 			; call second subroutine
stop 	B 		stop 		; terminate the program
func1 	LDR r0, =42 		; => MOV r0, #42
		LDR r1, =0x12345678 ; => LDR r1, [PC, #N]
							; where N = offset to literal pool 1
		LDR r2,=0xFFFFFFFF 	; => MVN r2, #0
		BX lr 				; return from subroutine
		LTORG 				; literal pool 1 has 0x12345678
func2 	LDR r3, =0x12345678 ; => LDR r3, [PC, #N]
							; N = offset back to literal pool 1
		;LDR r4, =0x87654321; if this is uncommented, it fails.
							; Literal pool 2 is out of reach!
		BX lr 				; return from subroutine
BigTable
		SPACE 4200 			; clears 4200 bytes of memory, <-making it outta reach
							; starting here
		END 				; literal pool 2 empty