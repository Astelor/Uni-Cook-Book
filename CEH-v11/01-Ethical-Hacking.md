# Chapter 1, Ethical Hacking
> Basic Code of conduct if one were to practice cyber security.
> very important when acquiring a job/ leaving good track record.

- [Chapter 1, Ethical Hacking](#chapter-1-ethical-hacking)
- [Keys](#keys)
- [Funny term bracket](#funny-term-bracket)
- [Overview of Ethics](#overview-of-ethics)
- [Overview of Ethical Hacking](#overview-of-ethical-hacking)
- [Methodologies](#methodologies)
  - [Cyber Kill Chain](#cyber-kill-chain)
  - [Attack Lifecycle](#attack-lifecycle)

# Keys
- Overview of Ethics
- Overview of Ethical Hacking 
- Methodologies
  - Cyber Kill Chain
  - Attack Lifecycle
- Methodology of Ethical Hacking
  - Reconnaissance and Footprinting
  - Scanning and Enumeration
  - Gaining Access
  - Maintaining Access
  - Covering Tracks

# Funny term bracket
- Computer emergency response team (CERT)
- Rain Forest Puppy Policy (RFP or RFPolicy) (a legendary security researcher)

# Overview of Ethics

> No breaking the law, keeping good paperwork, being trustworthy

- keep information you obtain from your work private
- disclose information that needs to be disclosed to the people who have engaged your services

# Overview of Ethical Hacking

# Methodologies

> like a good experiment, you gotta follow the steps and test the same scope. for consistency and repeatability.

Stages of penetration testing

0. Getting permission

1. Information Gathering
   - Collecting as much publically accessible information as possible
   - Note that this does *not* involve scanning systems.
2. Enumeration/ Scanning
   - **Discovering applications and services** running the systems.
3. Exploitation
   - **Leveraging vulnerabilities** discovered on a system or application.
4. Privilege Escalation
   - Once you have successfully exploited a system or application (aka foothold)
   - Attempt to **expand your access to a system**, you can move horizontally or vertically.
5. Post-exploitation
   - What other hosts can be targeted (**pivoting**)
   - What additional information can we gather from the host now that we are a privileged user
   - Covering your ~~ass~~ tracks.
   - Reporting



reference: https://tryhackme.com/r/room/pentestingfundamentals

> The TryHackMe room above contains write-ups and links on many free/ publically available resources (frameworks, manuals, etc). 100/10 room.

## Cyber Kill Chain

> identify where the attacker is and adapt your response.

Lockheed Martin (defense contractor) military concept of kill chain -> information security

Phases of the Intrusion Kill Chain:
- Reconnaissance
- Weaponization
- Delivery
- Exploitation
- Installation
- Command & Control
- Actions on Objective

## Attack Lifecycle
From security and consulting company FireEye Mandiant





