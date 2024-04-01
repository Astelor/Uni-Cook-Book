# Chapter 5, Scanning Networks
> Using the data gathered from footprinting and recon, get permission, establish the scope and scale of the engagement, and don't move beyond what was agreed to with your target.

> MUST get permission before touching the system, it's possible for a simple scan to knock over a system (e.g. fragile systems, older embedded devices) -> permission from client and they have an understanding of what may happen.

- [Chapter 5, Scanning Networks](#chapter-5-scanning-networks)
- [Keys](#keys)
- [Funny term bracket](#funny-term-bracket)
- [Ping Sweeps](#ping-sweeps)
  - [Tool: fping](#tool-fping)
- [Port Scanning](#port-scanning)
  - [Tool: nmap](#tool-nmap)

# Keys
- Ping Sweeps
  - using fping
  - using MegaPing
- Port Scanning
  - Nmap
  - masscan
  - MegaPing
  - Metasploit
- Vulnerability Scanning
  - OpenVAS
  - Nessus
  - Looking for Vulnerabilities with Metasploit
- Packet Crafting and Manipulation
  - hping
  - packetETH
  - fragroute
- Evasion Techniques
- Protecting and Detecting

# Funny term bracket

# Ping Sweeps
> Identify systems that are alive with ICMP echo request.

- ICMP echo request
  - common message to be sent
  - hard to notice when you're not sending unusual number or size of them
  - firewall rules may block ICMP messages from outside the network

## Tool: fping
> send ICMP ECHO_REQUEST packets to network hosts.

```
fping -aeg 192.168.86.0/24
```
- -a, --alive
  - Show systems that are alive
- -e, -- elapsed
  - Show elapsed (round-trip) time of packets
- -g, --generate addr/mask
  - Generate a target list from a supplied IP netmask, or a starting and ending IP.

# Port Scanning

- Application with network service functionality
  - -> binds to a port
  - reserves the port 
  - registers the application to get messages that come in on that port

- Application listening on a port
  - -> the port is open
- Port -> transport layer
  - using TCP or UDP

## Tool: nmap
>