# Scrap 4
> I don't wanna edit the scrap 3 so here we are
 
 
- **Important**
  > When dealing with the System Control Register on tm4c1233h6pm, which has the base address `0x400FE000`, the debugger by default doesn't give read/write permission to it while it's *definitely* read/write'able
  
  - Do this after initiating the debugging session, and BEFORE executing any instructions
  - go to `Debug` -> `Memory Map`
  - enter `0x40000000, 0x41000000` in the memory rnage
  - click `read` and `write` checkboxes
  - click `Map Range`
 > now enjoy manually setting it for the rest of your debugging session :)
 
- Quick list for the tm4c1233h6pm manual 
 
- System Control Registers
  - RCC: Run-Mode Clock Configuration (RCC)
  > This thing's value is usually  
 
- value dump(ster fire):
 
```ASM
SysCtrlBase EQU		0x400FE000
RCC			EQU		0x60
RCGCGPIO	EQU		0x608

GPIOPFBase	EQU		0x40025000
GPIODIR		EQU		0x400
GPIODEN		EQU		0x51C

0xE000E000
```

 
- Bit-Banded Memory
> In short, changing a word in a chunk of memory to access a bit in another chunk of memory

bit-banded alias: 0x42000000 0x43FFFFFF 
the offending address: 0x40000000 0x400FFFFF 

Equation:
alias = alias base + (byte offset x 32) + (bit number x 4)

In this case:
alias = 0x42000000 + (byte offset x 32) + (bit number x 4)

```
if the alias is 0x43070010
0x0107.0010 -> 0x0107.0000 + 0x10

byte offset = 0x8.3800
bit number = 0x4
```

```
if the bit address is 0x40038000
and we want bit 1

byte offset = 0x38000
bit number = 0x1

the alias = 0x4200.0000 + (0x38000 x 0x20) + (0x1 x 4)
= 0x4270.0004

```

