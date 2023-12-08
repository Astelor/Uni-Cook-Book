		AREA midterm_2_1, CODE, READONLY
		ENTRY	;411440117 Aster Chen
		MOV		r2, #7
		MOV		r3, #6
		MOV		r4, #5
		MOV		r0, #1
		ADD		r5, r5, r0, LSL r2 ;Q1
		ADD		r5, r5, r0, LSL r3
		SUB		r5, r5, r0, LSL r4
		SUB		r5, r5, #48
stop	B 		stop
		END		;411440117 Aster Chen