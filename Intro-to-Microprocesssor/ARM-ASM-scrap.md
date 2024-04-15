# Fuck it we ball

> Scrap for ARM ASM cuz I forgot everything


# Cortex M4

- Interrupt handling is in `3. Cortex-M4 Peripherals`
- Vector table is initialized at memory address 0x0
  - Each entry is 4 bytes (32 bits, 2 halfwords)

- The vector names are predefined
  - They all correspond to a value (see disassembly)

- NVIC (Nested Vector Interrupt Controller)

> Astelor: I WANNA SLEEEEEEEEEEEEEEEEEEEEEEEEEEEP