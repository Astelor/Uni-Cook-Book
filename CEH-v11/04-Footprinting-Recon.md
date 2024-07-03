# Chapter 4, Footprinting and Reconnaissance

> gathering information about your target, one of the phases in the ATT&CK Framework

- [Chapter 4, Footprinting and Reconnaissance](#chapter-4-footprinting-and-reconnaissance)
- [Key](#key)
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
- [Technology Intelligence](#technology-intelligence)
  - [Google Hacking](#google-hacking)
  - [Internet of Things (IoT)](#internet-of-things-iot)

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

# Funny term bracket

- Securities and Exchange Commission (SEC)
- Electronic Data Gathering, Analysis, and Retrieval (EDGAR)
- Internet Corporation for Assigned Names and Numbers (ICANN)
- Internet Assigned Numbers Authority (IANA)
- regional Internet registry (RIR)
- GTE Internetworking

# Open Source Intelligence

> The records maintained by a third-party, you can scavenge the open internet for information.

- 🔴: (attacker)
  - (Wants) as much information and as detailed as it can be.
- 🔵: (organization)
  - Giving limited (or "not real") information on the registry.
  - or redacting the info and not showing it at all.

## Companies

> Public companies are required by the government to provide information about themselves, the info can be found on **databases maintained by the governments**.

- 🟣: (purple team)
  - Gather info about a company's organizational structure.
  - Who has what position.

### Database: EDGAR

> "Electronic Data Gathering, Analysis, and Retrieval system, maintained by the U.S. Securities and Exchange Commission (SEC)"

reference: https://www.sec.gov/edgar/search-and-access

### Domain Registrars

> "god of the Internet" Jon Postel

Organizations responsible for managing IP address, ports, protocols etc: 
- Internet Corporation for Assigned Names and Numbers (ICANN)
- Internet Assigned numbers Authority (IANA)

> Just know the existence of these orgs.

# Domain Name System

> Humans are bad at remembering numbers, so we dub names to the numbers, which are domain names. Instead of typing an IPv4 address, all you need to remember is a string of characters.

An example of a "fully qualified domain name" (FQDN)
```
www.labs.domain.com
+---+--+-------+--+

[hostname].([subdomain name].)[domain name].[top-level domains(TLDs)]
```
www is a hostname

## Name Lookups

> Translating domain names to numbers, by asking a server what name belongs to what IP/server

```
[your PC] (idk where www.labs.domain.com is)
|  |
| [caching DNS]
|  | | |
|  | | +->[root server] (where's domain.com?)
|  | +->[domain.com] (where's labs.domain.com?)
|  +->[labs.domain.com] (where's www.labs.domain.com?)
| 
+-->[www.labs.domain.com] (connection request)
```

### Tool: host

> DNS lookup utility

> `host` is a simple utility for performing DNS lookups. It is normally used to convert names to IP addresses and vice versa. When no arguments or options are given, `host` prints a short summary of its command-line arguments and options.

```
host example.com
host 93.184.216.34 4.2.2.1
```

`4.2.2.1` is a caching server available for anyone, created by GTE Internetworking. Its role is the caching DNS in the diagram above. We can issue request to it as if it were our own caching server.

### Tool: nslookup

> Query Internet name servers interactively

```
nslookup
set type=ns
example.com
```

`set type=ns` -> 

### Tool: dig

> DNS lookup utility

> surely learning about tools is like learning English, you get the basic meanings of the word you encounter, and not cram your brain with extra infos about that word, so you don't get tired of writing things you might not use.

# Technology Intelligence

> Web interfaces is not the only place to look for vulnerabilities, look else where.

## Google Hacking

> Improve the search responses, save time and become more efficient.

[Google Hacking Database (GHDB)](https://www.exploit-db.com/google-hacking-database): 
A collection of Google dorks (string using Google keywords to search for useful responses) identified by someone as a way to search for a number of things.

## Internet of Things (IoT)

> Good starting points into the enterprise network.

Reasoning:
- Many company use IoT devices in different automation capacities.
- Once infected, the devices can be used to attack other systems.

[Shodan](https://www.shodan.io/): A search engine for IoT devices.


