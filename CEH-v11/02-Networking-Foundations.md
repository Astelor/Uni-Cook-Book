# Chapter 2, Networking Foundations

# Funny term bracket
These are the terms that can be abbreviated.
or simply something I barely know

- Internet Protocol (IP)
- Transmission Control Protocol (TCP)
- User Datagram Protocol (UDP)
- Hypertext Transfer Protocol (HTTP)
- Extended Binary Coded Decimal Interchange Code (EBCDIC)
8-bit character encoding used mainly on IBM mainframe operating systems (the big boy you see in labs) in 1950s~1960s
In some legacy systems, EBCDIC encoding continues to be used for compatibility reasons.
- Joint Photographic Express Group (JPEG)
- Remote procedure calls (RPCs)
- Media(medium) Access Control (MAC)
- Address Resolution Protocol (ARP)
- virtual local area networks (VLANs)
- 10BaseT, 10Base2, 100BaseTX, 1000BaseT
- Secure Shell protocol (SSH)
- Interface Message Processor (IMP)
- Network Control Program (NCP)
- ARPAnet
- Multistation access units (MAU) 

- Frame Relay
- Asynchronous Transfer Mode
- Fiber Distributed Data Interface
- Ethernet
- protocol data units (PDUs)
- content-addressable memory (CAM)


- Internet Packet Exchange (IPX)
- Internet Engineering Task Force (IETF)
- Classless Interdomain Routing (CIDR) notation
- Internet Security Alliance (ISA)
- Dynamic Host Configuration Protocol (DHCP)
  
- Internet Message Control Protocol (IMCP)
- 


- Protocol -> a set of rules or conventions that dictate communication.

# IPv4 (Internet Protocol)
```
    0                   1                   2                   3
    0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1
   +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
   |Version|  IHL  |Type of Service|          Total Length         |
   +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
   |         Identification        |Flags|      Fragment Offset    |
   +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
   |  Time to Live |    Protocol   |         Header Checksum       |
   +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
   |                       Source Address                          |
   +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
   |                    Destination Address                        |
   +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
   |                    Options                    |    Padding    |
   +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+

                    Example Internet Datagram Header
```


# TCP (Transmission Control Protocol)
```
    0                   1                   2                   3   
    0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 
   +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
   |          Source Port          |       Destination Port        |
   +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
   |                        Sequence Number                        |
   +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
   |                    Acknowledgment Number                      |
   +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
   |  Data |           |U|A|P|R|S|F|                               |
   | Offset| Reserved  |R|C|S|S|Y|I|            Window             |
   |       |           |G|K|H|T|N|N|                               |
   +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
   |           Checksum            |         Urgent Pointer        |
   +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
   |                    Options                    |    Padding    |
   +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
   |                             data                              |
   +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+

                            TCP Header Format

          Note that one tick mark represents one bit position.
```


# Useful Commands

## WHOIS
- who's this public address? (linux/unix)
```
whois <IP_address>
```
https://whois.domaintools.com/

"It's a query response protocol that is used for querying databases that store an internet resource's registered users or assignees. These resources include domain names, IP address blocks and autonomous systems, but it is also used for a wider range of other information."
[WHOIS Protocol Specification: RFC3912](https://datatracker.ietf.org/doc/html/rfc3912)


# Keys 
(table of content, sort of)

- OSI model (Open Systems Interconnection)
- TCP/IP Architecture
- Topologies
  - Bus Network
  - Star Network
  - Ring Network
  - Mesh Network
  - Hybrid
- Physical Networking
  - Addressing
  - Switching
- IP
  - Headers
  - Addressing
  - Subnets

- TCP (header)
- UDP (header)
- Internet Control Message Protocol (ICMP)
- Network Architectures
  - Network Types
  - Isolation
  - Remote Access


# Internet Control Message Protocol
ICMP -> RFC792
> "ICMP, uses the basic support of IP as if it were a higher
level protocol, however, ICMP is actually an integral part of IP, and
must be implemented by every IP module." -RFC792 (page 1)

- generate types of ICMP messages when exceptions happen
> "The Internet Protocol is not designed to be absolutely reliable. The
purpose of these control messages is to provide feedback about
problems in the communication environment, not to make IP reliable."
- doesn't carry user data.
- is considered a part of the Internet layer as IP 
  - it sits above the Internet layer, but isn't a Transport layer protocol

## Ping (ICMP Echo Request)
-> RFC 792 page 14
Sends a packet using the Internet Protocol topping an additional ICMP message.
Because it's an IP packet, you can modify the its header such as its Time To Live. use `man ping` for more options, or `ping -help`.
```
ping <IP address> -t <ttl>
```

# Network Architectures

## Network Types
The network implementation can be flexible.

### Local Area Network (LAN)
Covers a limited geographic area, typically confined to a single building or on the same floor. The systems would be in the same broadcast domain or collision domain.

The systems can communicate using the data link layer.

```
[ME (192.168.0.123)]--+--[machine A (192.168.0.179)]
                      |
                   [modem]
                      |
             [Router (192.168.0.1)]
```

### Virtual Local Area Network (VLAN)
VLAN is a LAN where the isolation at layer 2 is handled by software/firmware rather than physically.

The traffic would cross over a layer 3 boundary (the router) for the VLAN to get to each other.

VLANs allow network admins to group hosts together even if the hosts are not directly connected to the same network switch. (because it's configured through software)

```
             [Router]
                 |
  [switch 1]-----+-----[switch 2]
       |                   |
  +----+----+         +----+----+
  |         |         |         |
[VLAN 1] [VLAN 2]  [VLAN 3] [VLAN 2]
```

### Wide Area Network (WAN)
WAN extends over a large geographic area.
Any ISP would have a WAN.

### Metropolitan Area Network (MAN)
MAN sits between a LAN and a WAN.
Connections of LANs would be a MAN, anything smaller than WAN but spreads across a larger geographic area than a LAN.

```
[LAN 1]---[LAN 2]---[LAN 3]
```

## Isolation
Separating network elements(services intended to interact with the Internet(web server, email, systems anyone from the Internet can get access to)) to protect sensitive data(internal server, user desktops).

### Demilitarized zone (DMZ)

```
      [the Internet]
	         |
        [Firewall]
        /    |   \   
       /     |    \
[Desktops] [DMZ] [Internal Servers]
```
### Enclaves

## Remote Access
- Virtual Private Networks (VPNs)
- Multiprotocol Label Switching (MPLS)
- IP Security (IPSec)
- Transport Layer Security (TLS)
  - current implementation of encryption for web traffic
  - commonly used method of encryption.
  - "a cryptographic protocol" (e.g. certificates handed from Microsoft)
- Secure Sockets Layer (SSL)
  - predecessor to TTL

# Cloud Computing
```
     (outsource) ->
+------------------+
| Mainframe 1970   |--for mass data processing
| large, expensive |
+------------------+
  |
  | more affordable computers
  |
  |  (in-house) <-
+------------------+
| PCs              |--floppy disks local storage
| storage system   |
+------------------+
  |
  | World Wide Web
  |
  |  (outsource) ->
+------------------+
| hosting provider |--laborless marketing on the web!
| websites         |  
+------------------+
  |
  | Internet Acess became cheap
  |
  |  (in-house) <-
+------------------+
| hosting websites |--again, money
| themselves       |
+------------------+
  |
  | Security concerns & traffic 
  |
  |  (outsource) -> now
+------------------+
| cloud computing  |--keep externally accessible
|                  |  system off corporate network
+------------------+
```
Advantage for cloud computing
- cost effective
  - hardware, software, maintenance are handled by the host provider (good for small businesses)
- 


from small to large scope(what the client need to/can do):

- Storage as a Service (STaaS)
  - e.g. google drive, one drive, github, iCloud
  - pro: access data on any device
  - con: compromise/ theft of personal data (photos, documents)
  - server side: prevent unauthorized access
  - client side: prevent data leakage (authorized user getting unauthorized data)
- Infrastructure as a Service (IaaS)
  - e.g. 
  - 
  - pro: cost effective (server host do all the maintenance and management)

- Platform as a Service (PaaS)

- Software as a Service (SaaS)


```
(from microsoft azure)

SaaS-+--[Hosted applications]
     |  
     | PaaS-+--[dev tools, database management, analytics]
     |      |
     |      |  [operating systems]
     |      |
     |      |  IaaS-+--[servers and storage]
     |      |       |
     |      |       |  [networking firewalls/ security]
     |      |       |
     +------+-------+--[data center physical plant]
```