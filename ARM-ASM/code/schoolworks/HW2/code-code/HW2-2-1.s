		AREA HW2_part2_1, CODE, READONLY
		ENTRY
		ADR		r1, data1
		ADR		r2, data2
		ADR		r3, data3
		ADR		r4, data4
		ADR		r5, data5
		ADR		r6,	data6
		ADR		r7, data7
		ADR		r8, data8
		ADR		r9, data9
		ADR		r10,data10
stop 	B 		stop
data1   DCW     0x8ECC, 0xFE37, -149 
data2   DCD     0xFE37, 1, 5, 20 
data3   DCB     0xCF, 23, 39, 0x54, 250
data4   DCWU    0x1234
data5   DCB     255 
data6   DCDU    0x12345678, -4321
data7   DCB     0xA3 
		ALIGN 	4,3 
data8   DCWU    0xFC25 
        ALIGN
data9   DCB     "MVP_N. Jokic", 0
data10  DCW     0xEF12
        END;   [REDACTED] Aster Chen, verified