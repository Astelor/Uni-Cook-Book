# Questions
If you're not Astelor, ignore this file.
- [ ] What defines an unpredictable behavior?
  - Any examples?
- [x] How large is an ARM7TDMI register?
  - 32 bits?
  - **YES** it's 32 bits, a word, 8 bytes, go see your keil tool
    - the processor is 32 bits wide in general-purpose register(the register in question), so it's also a 32-bit processor, 32 bits also means the address width it can access(4GB), because if there's not a number large enough for it to tag data beyond address 2^31, it literally can't use it.

- [ ] Can I tell the system to treat the value as unsigned and in turn affect the conditional code flag results?
  - such as, 0x7FFFFFFF+0x00000001=2^27+1 and make it 2^27+1 instead of -2^31 (signed overflow)
- [ ] What exactly is a pseudo instruction?
  - is it like a macro? an extended instruction set to make coding easier?
- [ ] How exactly does (external) memory work in keil tool? or any processor types
  - I know you can define a data, but where is it placed? and how exactly is it accessed?

