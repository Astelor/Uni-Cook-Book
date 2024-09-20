# Project idea proposing

short list:
- side channel attack resistant RSA ASIC
- hardware root of trust
	- IoT?
nope, not really:
- HSM
	- cryptoprocessor + key locker + key generater
	- > this is a cluster, pick one function
	- > does cryptoprocessor have key generating capabilities
	
# Side Channel Attack Resistant RSA Cryptographic Hardware Accelerator

encryption + hardware acceleration + security

> so this is just a processor?
> maybe I can do key management and areas of HSM if I had more time?

## Goal of this project

Making the computation of the RSA computation circuit resistant to side-channel attacks such as power and timing analysis

> wait, but the circuit is simulated on FPGA, can power and timing analysis be done on programmable hardware?

## Areas of knowledge
- RSA algorithm
- Verilog HDL
- Side Channel Attacks methods on RSA
	- `Cryptanalytic Attacks on RSA` has a chapter on this 
	- Power analysis
	- Timing analysis
- A random number generator
	- for the keys

## What would this project have?
- A working RSA ASIC
	- encryption/ decryption
	- key generation <- random number generator goes here
	- *key management
		- > the key would be stored in this IC, so it should harden against side channel attack
		- HSM covers key management
- Red teaming & Blue teaming
	- attack simulation
	- > simulation goes in the test bench
	- > I need to find or build a more efficient testbench param logger, hand calculating all the clock and signal is annoying and SLOW. OOOOOo it would be fun
	- attack defending mechanism/ implementation
	
> A colab is more optimal but a fight would be due :')

I'm not sure about the following:
- Intrusion detection
	- > this one's more HSM
	- event logging?
	
## Why this project

### General
- Implementing security on the hardware level make it less likely to be vulnerable to software-based attacks
- Hardware level security can be implemented in areas that requires high level of confidentiality.
	- servers, military, government, intelligence, business, data center
	- anything that need encryption protocols can can be compromised with hardware level intrusion.

### Personal
- I like hardware and software and security.
- I'm interested in purple teaming.
	- > breaking stuff and hardening it from myself lol

> I'm yapping here lol

## Future prospect

Expanding the RSA computation core into the **Hardware Security Module**

- The former is focused on the computation
- The latter is focused on physical temperment resistant (bus probing), access control, and event logging

> And it'll all be written in HDL WOOOOOOOOOOOOOOOOOO
> well oh well isn't this the dawn of death for me

> I'm already out of ideas lmao

