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
- 
- Protocol -> a set of rules or conventions that dictate communication.


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