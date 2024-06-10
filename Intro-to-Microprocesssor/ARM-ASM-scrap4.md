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

 