SRAM_BASE	EQU		0x40000000		; start of SRAM for LPC2104
			AREA	StrCopy, CODE
			ENTRY
Main		ADR		r1, srcstr
			LDR		r0, =SRAM_BASE
strcopy
			LDRB	r2, [r1], #1
			STRB	r2, [r0], #1
			CMP		r2, #0
			BNE		strcopy
stop		B		stop
srcstr		DCB		"This is my (source) string", 0
			END