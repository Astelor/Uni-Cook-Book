# Chapter 3, Security Foundations
> Astelor: imma skip ahead when I'm bored, and come back later when the skipped become relevant.
> the later parts became a bit too abstract for me to map into real life scenarios

talbe of contents
- [Chapter 3, Security Foundations](#chapter-3-security-foundations)
- [Funny term bracket](#funny-term-bracket)
- [Keys](#keys)
- [The Triad (CIA)](#the-triad-cia)
  - [Confidentiality](#confidentiality)
  - [Integrity](#integrity)
  - [Availability](#availability)
  - [Parkerian Hexad](#parkerian-hexad)
- [Risk](#risk)
- [Policies, Standards, and Procedures](#policies-standards-and-procedures)
  - [Security Policies](#security-policies)
  - [Security Standards](#security-standards)
  - [Procedures](#procedures)
  - [Guidelines](#guidelines)
- [Organizing Your Protections](#organizing-your-protections)
- [Security Technology](#security-technology)
  - [Firewalls](#firewalls)
  - [Intrusion Detection Systems](#intrusion-detection-systems)

# Funny term bracket
the terms and things I don't know
there are so many...
- National Institute of Standards and Technologies (NIST)
- service level agreement (SLA)
- Lockheed Martin
- FireEye Mandiant
- MITRE ATT&CK Framework
- common tactics, techniques, and procedures (TTPs)
- advanced persistent threats (APTs)
- Windows Management Instrumentation (WMI)
- File Transfer Protocol (FTP)
- voice over IP (VoIP)
- session border controller (SBC)
- H.323
- Session Initiation Protocol (SIP)
- Real-time Transport Protocol (RTP)
- Intrusion detection systems (IDSs)
- web application firewall (WAF)
- Snort (IDS software owned by Cisco)
- 

# Keys
cuz why not

- The Triad
  - Confidentiality
  - Integrity
  - Availability
  - Parkerian Hexad
- Risk
- Policies, Standards, and Procedures
  - Security Policies
  - Security Standards
  - Procedures
  - Guidelines
- Organizing Your Protections
- Security Technology
  - Firewalls
  - Intrusion Detection Systems
  - Endpoints Detection and Response
  - Security Information and Event Management
- Being Prepared
  - Defense in Depth
  - Defense in Breadth
  - Defensible Network Architecture
  - Logging
  - Auditing

# The Triad (CIA)
> all three sides are equally important
```
this is an equilateral triangle :>
   /\   
  /  \        
 /____\
```
## Confidentiality
> keeping secrets, and make sure no one get unauthorized access
- type: static -> "at rest"
  - stored on a disk and not being used/ manipulated
- type: dynamic -> "in motion"
  - transmitted from one place to another, but not necessarily altered
- Defense: encryption
  - Secure Sockets Layer/ Transport Layer (SSL/TLS) -> both specify the generation of encryption keys
  - data need the key to be decrypted
- Offense: lock-picking or key theft 
  - attack against the encryption mechanisms
  - encryption keys theft

## Integrity
> the data is the same as it was intended to be

locally e.g. data corrupted because of bad physical components (drive, memory), unintended alternation of the data (over-written document by accident)

not locally e.g. corrupted during transit, signatures abused by attacker

- Defense: back-ups and digital signature
- Offense: man-in-the-middle attack

## Availability
> the data/service is THERE when you need it

e.g. misconfiguration -> changing the service config without testing -> the service broke

- Defense: stage changes
- Offense: denial-of-service (DoS) attack
  - attacker sends mass amount of request to overwhelm the service, make legitimate traffic difficult to go through the noise.

## Parkerian Hexad
> for specific cases, if it's useful to you.

in 1998, Donn Parker added 3 more to extend the initial 3 properties, the addition is not considered standard.

These additions can fit into the CIA triad.
- Possession (or Control)
  - physically holding the device
  - e.g. if you give someone you usb, you lose the possession to it.
- Authenticity
  - aka nonrepudiation
  - the source of the data is what it purports to be.
- Utility
  - e.g. modern devices can't read floppy disk, even if the data is intact, it cannot be used.

# Risk
> probability of an event to bad outcomes, quantify the value of bad outcomes(time, money etc) to identify what data is important(valuable to threat agents and to you), in order to effectively distribute resources on security protection.

`$risk = probability * loss`

- Defense:
  - understand every possible events, probabilities and aftermaths
  - using loss of money is one way to evaluate the aftermath(outcome)
- Offense:
  - find vulnerabilities and exploit them

```
[vulnerability]
 |
[threat vector] <- triggered <- [threat actor]
 |
 ▼
[exploit]
```

- threat:
  - something that has the possibility to incur a breach of the CIA triad
  - one way a breach may take is a vulnerability (e.g. or physically intrude the data center or work station)
- vulnerability:
  - a weakness in a system (software, config, algorithms etc)
  - when a vulnerability is triggered, it becomes an exploit
  - not all vulnerabilities can be exploited by everyone (physical limitations etc)

# Policies, Standards, and Procedures

```
        [policy]<--------[guidelines]
         /    \
[standard A] [standard B]
 |                  |
 |-[procedure A-1]  |-[procedure B-1]
 |-[procedure A-2]  |-[procedure B-2]
```

## Security Policies
> constitutional law of security(high-level), help classify and prioritize the information assets, to achieve the desired CIA triad balance

- what an organization considers security
  - what resources needed to be protected
  - how resources should be utilized in a proper manner
  - how resources can or should be accessed
  - -> drawn by management and board of directors -> responsible to the investors
- setting expectation of employees
  - define what users can and cannot do.
  - what information security technology/ staff should do.
- human resources
  - protect personnel from danger

- MISC
  - not all information should always be confidential, have integrity, and be available.
  - Policies should be revisited on a regular basis.
  - they don't provide specifics (like constitutional law)

## Security Standards
> direction about how policies should be implemented

- to define anything that was vague in the policies (define "up-to-date", or "systems") to make it relevant to the operational staff

## Procedures
> the implementations in the act

- what to do to achieve the standard at a granular level
  - step-by-step instructions
  - multiple procedures combined
- MISC
  - change to technology my result in an update to standards, and lead to more regular update to procedures
  - feedback loops built in to revise procedures to be more efficient
  - more regular updates as we get to the specific steps in implementation and administration.

## Guidelines
> not required but they are suggestion on how policies my be implemented (e.g. best practices)

# Organizing Your Protections
> Know yourself, know your enemies. 

Please refer to chapter 1 for methodologies

The ATT&CK Framework:
(Adversarial Tactics, Techniques, and Common Knowledge)
- Reconnaissance
- Resource Development
- Initial Access
- Execution
- Persistence
- Privilege Escalation
- Defense Evasion
- Credential Access
- Discovery
- Lateral Movement
- Collection
- Command and Control
- Exfiltration
- Impact

# Security Technology
> 100% prevention is impossible -> detection and multilayered defense+countermeasures

## Firewalls
> the wall that keeps the fire at bay, word was taken in 1980s to apply to nascent network protection technologies.

- Packet Filters
- Stateful Filtering
- Deep Packet Inspection
- Application Layer Firewalls
- Unified Threat Management

## Intrusion Detection Systems

- host-based IDS (HIDS)
- network IDS (NIDS)

