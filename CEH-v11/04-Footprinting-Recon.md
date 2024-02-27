# Chapter 4, Footprinting and Reconnaissance
> gathering information about your target, one of the phases in the ATT&CK Framework

- [Chapter 4, Footprinting and Reconnaissance](#chapter-4-footprinting-and-reconnaissance)
- [Key](#key)
- [Tools bracket](#tools-bracket)
- [Funny term bracket](#funny-term-bracket)
- [Open Source Intelligence](#open-source-intelligence)
  - [Companies](#companies)
    - [Database: EDGAR](#database-edgar)
    - [Domain Registrars](#domain-registrars)
- [Domain Name System](#domain-name-system)
  - [Name Lookups](#name-lookups)
    - [Tool: host](#tool-host)
    - [Tool: nslookup](#tool-nslookup)
    - [Tool: dig](#tool-dig)

# Key
- Open Source Intelligence
  - Companies
  - People
  - Social Networking
- Domain Name System
  - Name Lookups
  - Zone Transfers
  - Passive DNS
- Passive Reconnaissance
- Website Intelligence
- Technology Intelligence
  - Google Hacking
  - Internet of Things (IoT)

# Tools bracket

# Funny term bracket
- Securities and Exchange Commission (SEC)
- Electronic Data Gathering, Analysis, and Retrieval (EDGAR)
- Internet Corporation for Assigned Names and Numbers (ICANN)
- Internet Assigned Numbers Authority (IANA)
- regional Internet registry (RIR)
- 

# Open Source Intelligence
> The records maintained by a third-party, scavenge the open internet for information. some commonly used tools are mentioned in this chapter too.

- offense: (attacker)
  - as much information and as detailed as it can
- defense: (organization)
  - giving limited(or "not real") information on the registry
  - or redacting the info and not showing it at all

## Companies
> Public companies are required by the government to provide information about themselves, the info can be found on databases maintained by the governments.

### Database: EDGAR
Electronic Data Gathering, Analysis, and Retrieval system, maintained by the U.S. Securities and Exchange Commission (SEC), the federal agency's purpose is to 

https://www.sec.gov/edgar/search-and-access

### Domain Registrars
> "god of the Internet" Jon Postel

# Domain Name System
> Humans are bad at remembering numbers, so we dub names to the numbers, which are domain names. Instead of typing an IPv4 address, all you need to remember is a string of characters.

an example of a "fully qualified domain name" (FQDN)
```
 www.ee.tku.edu.tw
+---+--+-------+--+

[hostname].([subdomain name].)[domain name].[top-level domains(TLDs)]
```

## Name Lookups
> translating domain names to numbers, by asking a server what name belongs to what IP/server

```
[your PC] (idk where www.ee.tku.edu.tw is)
|  |
| [caching DNS]
|  | | |
|  | | +->[root server] (where's tku.edu.tw?)
|  | +->[tku.tw] (where's ee.tku.edu.tw?)
|  +->[ee.tku.tw] (where's www.ee.tku.edu.tw?)
| 
+-->[www.ee.tku.tw]
```
> Astelor: tbf, a leaked home router public ip cannot do much, you can maybe crowd up its traffic by sending junk, as long as its configured correctly, I don't think much can be done.
> I'm still looking into if a public ip can be used to pin point the user's precise geographical location.
> And how bad the internet architecture is in Taiwan.

### Tool: host

### Tool: nslookup
> query Internet name servers interactively
### Tool: dig

