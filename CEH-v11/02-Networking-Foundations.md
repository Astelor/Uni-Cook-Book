# Chapter 2, Networking Foundations

ugly ass table of contents

- [Chapter 2, Networking Foundations](#chapter-2-networking-foundations)
- [Funny term bracket](#funny-term-bracket)
- [Keys](#keys)
- [Communication Models](#communication-models)
  - [Open Systems Interconnection (OSI)](#open-systems-interconnection-osi)
  - [TCP/IP Architecture](#tcpip-architecture)
- [Topologies](#topologies)
  - [Bus Network](#bus-network)
  - [Star Network](#star-network)
  - [Ring Network](#ring-network)
  - [Mesh Network](#mesh-network)
  - [Hybrid](#hybrid)
- [Physical Networking](#physical-networking)
  - [Addressing](#addressing)
  - [Switching](#switching)
- [IPv4 (Internet Protocol)](#ipv4-internet-protocol)
- [TCP (Transmission Control Protocol)](#tcp-transmission-control-protocol)
- [Internet Control Message Protocol](#internet-control-message-protocol)
  - [Ping (ICMP Echo Request)](#ping-icmp-echo-request)
- [Network Architectures](#network-architectures)
  - [Network Types](#network-types)
    - [Local Area Network (LAN)](#local-area-network-lan)
    - [Virtual Local Area Network (VLAN)](#virtual-local-area-network-vlan)
    - [Wide Area Network (WAN)](#wide-area-network-wan)
    - [Metropolitan Area Network (MAN)](#metropolitan-area-network-man)
  - [Isolation](#isolation)
    - [Demilitarized zone (DMZ)](#demilitarized-zone-dmz)
    - [Enclaves](#enclaves)
  - [Remote Access](#remote-access)
- [Cloud Computing](#cloud-computing)
  - [Advantage for cloud computing](#advantage-for-cloud-computing)
  - [Storage as a Service (STaaS)](#storage-as-a-service-staas)
  - [Infrastructure as a Service (IaaS)](#infrastructure-as-a-service-iaas)
  - [Platform as a Service (PaaS)](#platform-as-a-service-paas)
  - [Software as a Service (SaaS)](#software-as-a-service-saas)
  - [Internet of Things](#internet-of-things)

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
- Message Queuing Telemetry Transport (MQTT)
- Simple Mail Transfer Protocol (SMTP)
- 

# Keys 
(table of content, sort of)
> the things that has yet to be documented
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

- Protocol -> a set of rules or conventions that dictate communication.
# Communication Models
> modularize functions into layers, making it easier to debug, develop

## Open Systems Interconnection (OSI)
> the first ever conceptual model for better interoperability between vendors, created by International Organization for Standardization (ISO) in 1970s.

```
                 PDU name
7 Application  - data
6 Presentation - data
5 Session      - data
4 Transport    - segments
3 Network      - packets
2 Data Link    - frames
1 Physical     - bits
```

their usages
- 7 Application
  - e.g. Hyper Text Transfer Protocol (HTTP)
  - communication needs of the application -> e.g. identify and manage interacting with the resources 
- 6 Presentation
  - e.g. ASCII, unicode, JPEG
  - make sure that data is formatted correctly -> e.g. character encoding formats
- 5 Session 
  - manage the communication between the end-points and applications -> ensure data is transmitted successfully
- 4 Transport
  - e.g. Transmission Control Protocol (TCP), User Datagram Protocol(UDP)
  - segmenting messages for transmission
- 3 Network
  - e.g. Internet Protocol (IP)
  - get messages from A to B, with addressing and routing
- 2 Data Link
  - Media Access Control (MAC)
  - transmission of data frames between two nodes connected by a physical layer (a local network) 
- 1 Physical
  - you
  - how the pulses on the wire are handled

MISC
- different layer have different protocols handling a specific task
- the model separates functionalities and help you better identify the problems

## TCP/IP Architecture

```
Application 7~5
Transport   4
Internet    3
Link        2~1
```
- the functions from teh collapsed layers exist on the TCP/IP model
- "as-built" design -> describes something spe

# Topologies
> conceptual models for networks, to help isolate potential issues (like OSI model)

## Bus Network
```
     [machine A]   [B]
             |      |
[terminator]-+--+---+--[terminator]
                |
               [C]
```
- no mediating device -> all the computers are connected directly to one another by that singular cable
- message collision

## Star Network
```
    [A]
     |
   [hub]
  /     \
[B]    [C]
```
hub -> every device gets the same data
- same issue as the bus network
```
 [A]
  |
[switch]
 ⁝    ⁝
[B]  [C]
```
switch -> data only goes to the selected port
- slightly better than the previous two (no collision)
- layer 2 (Data link) of OSI model -> MAC address

## Ring Network
```
       [A]
        |
[B]--[ring]--[C]
     /    \
   [D]    [E]
```
- its logical representation, because they're not physically wired like this
  - "wired like star but doesn't behave like one"
- star network with hub medium, uses token to avoid message collision
- **token**: a talking stick -> multistation access units (MAUs)
```
does [A] has message to send? no→ pass token
↓ yes
does [A] has token no→ wait for one
↓ yes
sends message
```
- exceptions
  - if token is lost -> generates new one
  - it's possible for the old token to suddenly be found

- (Q: is the Ring Network the best one?) the cons can be fixed with proper protocols, so there's no definite superior topology.

## Mesh Network
```
 +-----[C]---+
 |      |    |
[A]--+  +-+  |
 |   |    |  |
 |   +---[D] |
 |        |  |
[B]-------+  |
 |           |
 +-----------+
```
a full mesh -> every node is connected
- peer-to-peer (decentralized)
- redundancy (more than one way to go to a machine)
- data pass through other systems
- the systems act like terminators
- it's increasingly expensive as you add systems `n(n-1)/2`

## Hybrid
```
[switch 1]--[switch 2]--[switch 3]
    |           |           |  
[64 ports]  [64 ports]  [64 ports]
```
because of technical limitations of hardware (a 192 ports? no)

# Physical Networking

## Addressing
 
## Switching

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




# Internet Control Message Protocol
> when IP fails you, ICMP got you

`ICMP -> RFC792`
"ICMP, uses the basic support of IP as if it were a higher level protocol, however, ICMP is actually an integral part of IP, and must be implemented by every IP module." -RFC792 (page 1)

- generate types of ICMP messages when exceptions happen

"The Internet Protocol is not designed to be absolutely reliable. The purpose of these control messages is to provide feedback about
problems in the communication environment, not to make IP reliable."

- doesn't carry user data.
- is considered a part of the Internet layer as IP 
  - it sits above the Internet layer, but isn't a Transport layer protocol

## Ping (ICMP Echo Request)
`RFC 792 page 14`
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
  - to connect to VMs, SSH(Secure Shell) for linux, RDP(Remote Desktop Protocol) for windows
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
## Advantage for cloud computing
- cost effective
  - servers are handled by the host provider (good for small businesses)
  - pay-as-you-go
- security concerns
  - again, to keep the corporate network off internet facing systems.

```
Overview of "as a Services" (from microsoft azure)
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
From small to large scope(what the server handles):
## Storage as a Service (STaaS)
> a box that holds your things, and portal them to you over the Internet
- e.g. google drive, one drive, github, iCloud
- pro: access data on any device
- con: compromise/ theft of personal data (photos, documents)
- server side: prevent unauthorized access
- client side: prevent data leakage (authorized user getting unauthorized data)

## Infrastructure as a Service (IaaS)
> an empty box for developers
- uses virtual machines to provide the hardware, like a brand-new set of computer, with nothing inside.

## Platform as a Service (PaaS)
> a box with toys for the less experienced
- like IaaS, but the operating system, software necessary to manage the machine are handled by the server host provider.
- businesses don't have to hire skilled technicians to maintain the system or spend more $ on the dev tools -> cost effective 

## Software as a Service (SaaS)
> apps but on browsers
- e.g. google docs, office online
- application developed to run inside a web browser -> you use the application provided and hosted by the server
- pro: no need for automatic updates on user's end -> no one will be running out-of-date software
- con: sensitive data being transported through the internet.
  - data will be encrypted with SSL/TLS, but data transmitted across the Internet can be captured and analyzed.

## Internet of Things
> connect devices to network so humans don't need to be on-site
- network of interconnected physical devices
  - with network connectivity, allowing them to collect and exchange data.
- can be reached over the network that doesn't have a built-in screen or the ability to take direct user interactions(input/output devices) is part of the IoT.
- IS part of IoT:
  - home automation devices: cable/satellite set-top boxes(your TVs)
- NOT part of IoT:
  - Smartphones, laptops -> can take direct user interactions
