# Chapter 5, Scanning Networks

> Using the data gathered from footprinting and recon, **get permission** from the client, establish the scope and scale of the engagement, and don't move beyond what was agreed to with your client.

> It's possible for a **simple scan to knock over a system** (e.g. fragile systems, older embedded devices) -> obtaining permission from client, and inform what may happen.
>
> Astelor: YES it happened, fragile embedded system cannot stand rigorous scanning.

- [Chapter 5, Scanning Networks](#chapter-5-scanning-networks)
- [Keys](#keys)
- [Funny term bracket](#funny-term-bracket)
- [Ping Sweeps](#ping-sweeps)
  - [Tool: fping](#tool-fping)
- [Port Scanning](#port-scanning)
  - [Tool: nmap](#tool-nmap)
    - [SYN Scan](#syn-scan)
    - [Full Connect Scan](#full-connect-scan)

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
  - **common message** to be sent
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

- Application listening on a port -> the port is open
- Port -> transport layer
  - using TCP or UDP

## Tool: nmap

TCP Scanning:

- **2 bytes for port number** in the transport protocol (layer 4) header
  - 65536 possible ports (0~65535, 0x0000 ~ 0xFFFF)

### SYN Scan

> Sometimes called a *half-open scan*, connections are left half open.
>
> A "knocks on the doors and goes *sike* and leaves" scan.

Nmap process:
1. Nmap sends a SYN message.
2. If the port is open, it'll respond with SYN+ACK.
3. Nmap responds with a **RST**, ending the connection.

- If the port is closed, the target system will respond with its own RST message.

```bash
$ nmap -sS 192.168.86.32
```

### Full Connect Scan

```bash
$ nmap -sT -p 80,443 192.168.86.0/24
```
- scan the subnet (192.168.86.0-254)
- scan port 80 and 443