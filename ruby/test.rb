blah = <<EOF


Operate servers at scale
 
-  Find bottlenecks using metrics (sysstat)
Memory
CPU
Network I/O
Disk I/O
-  Use Config Management tools – Cattle not Pets
-  SSL offload to speed up web servers
-  Create Rest APIs to backend services allows backend to be changed without recoding the front-end


-  GEO DNS Route53 or GTM F5
- Anycast
-  refactor expensive db calls (use NewRelic etc)
- implement a service model
- Swagger or RAML API’s and API gateways (horizontally scaled) creating a common 
- use Consul for service discovery and present name resolution using health of services
- implement a caches layer e.g. memcache/ redis to cache   
- CDN Akami/Cloudfront to offload content or set cache expiry headers
- use asynchronous web pages to not hold 
- pre-cache user details on logon (create a queue)
- DDOS protection

RestAPI vs Database calls
- Rest can add a cache layer to the calls
- multile clients (Web, Mobile, desktop etc) can call all get centralised, 
  security
  versioned
  chaging the backed doesnt require to recode the client application
- Rest version
- Scales better than db calls
- Rest has a performance hit at the expense for scaliability
- fewer connection to the db


Message Queue vs RestAPI/Web Service
Webservice: 
- client server relationship
- If the server fails the client must take responsibility to handle the error.
- when the server is working again the client is responsible of resending it.
- If the server gives a response to the call and the client fails the operation is lost.
- You don't have contention, that is: if million of clients call a web service on one server in a second, most probably your server will go down.
- you can expect an immediate response from the server, but you can handle asynchronous calls too.
Message Queues:
- If the server fails, the queue persist the message (optionally, even if the machine shutdown).
- When the server is working again, it receives the pending message.
- If the server gives a response to the call and the client fails, if the client didn't acknowledge the response the message is persisted.
- If you have contention, you can decide how many requests are handled by the server (call it worker instead).
- You don't expect an immediate synchronous response, but you can implement/simulate synchronous calls.

- Message Queues has a lot more features, if you want to handle error conditions yourself or leave them to the message queue.


 
 
IP ADDRESSING
24     25  26  27  28  29  30  31   32
256  128   64  32  16  8    4    2  1    n-2 Addresses per Network
1    2     4   8   16  32  64  128  256  Networks
0    128   192 224 240 248 252 254  255
 
Class 1st Octet Decimal Range
A    1 – 126*
B    128 – 191
C    192 – 223
D    224 – 239
E    240 – 254
Private Address Range
Class Private Networks    Subnet Mask
A    10.0.0.0                 255.0.0.0
B    172.16.0.0 - 172.31.0.0  255.240.0.0
C    192.168.0.0              255.255.0.0
 
 
 
How to debug a problem in a network.
-  Wireshark
-  Tcpdump
-  Netcat
-  Ifconfig
-  Arp
-  Route
 
 
Fork vs Exec
-  a process had two parts read only memory (application code “Text”), read write (“Data”)
-  Fork clones the read-write, mark it as Copy-On-Write (COW) and clone if changed
-  Exec replaces the read only (text)  
 
Thread
 
 
 
TCP Header
-  source TCP port number (2 bytes)
-  destination TCP port number (2 bytes)
-  sequence number (4 bytes) - numbers to mark the ordering of a group of messages.
-  acknowledgement number (4 bytes) - acknowledgement numbers field to communicate the sequence numbers of messages that are either recently received or expected to be sent.
-  TCP data offset (4 bits)
-  reserved data (3 bits)
-  control flags (up to 9 bits)
-  window size (2 bytes) - regulate how much data they send to a receiver before requiring an acknowledgement in return
-  TCP checksum (2 bytes)
-  urgent pointer (2 bytes)
-  TCP optional data (0-40 bytes)
 
 
 
Three Way handshake
SYN-SYNACK-SYN

    NS (1 bit): ECN-nonce concealment protection (experimental: see RFC 3540).
    CWR (1 bit): Congestion Window Reduced (CWR) flag is set by the sending host to indicate that it received a TCP segment with the ECE flag set and had responded in congestion control mechanism (added to header by RFC 3168).
    ECE (1 bit): ECN-Echo has a dual role, depending on the value of the SYN flag. It indicates:

        If the SYN flag is set (1), that the TCP peer is ECN capable.
        If the SYN flag is clear (0), that a packet with Congestion Experienced flag set (ECN=11) in IP header received during normal transmission (added to header by RFC 3168). This serves as an indication of network congestion (or impending congestion) to the TCP sender.

    URG (1 bit): indicates that the Urgent pointer field is significant
    ACK (1 bit): indicates that the Acknowledgment field is significant. All packets after the initial SYN packet sent by the client should have this flag set.
    PSH (1 bit): Push function. Asks to push the buffered data to the receiving application.
    RST (1 bit): Reset the connection
    SYN (1 bit): Synchronize sequence numbers. Only the first packet sent from each end should have this flag set. Some other flags and fields change meaning based on this flag, and some are only valid for when it is set, and others when it is clear.
    FIN (1 bit): Last package from sender
 
Common port numbers
Port Number Description
21  FTP -- Control
22  SSH Remote Login Protocol
23  Telnet
25  Simple Mail Transfer Protocol (SMTP)
53  Domain Name System (DNS)
69  Trivial File Transfer Protocol (TFTP)
80  HTTP
110    POP3
137    NetBIOS Name Service
139    NetBIOS Datagram Service
143    Interim Mail Access Protocol (IMAP)
150    NetBIOS Session Service
161    SNMP
179    Border Gateway Protocol (BGP)
190    Gateway Access Control Protocol (GACP)
389    Lightweight Directory Access Protocol (LDAP)
443    HTTPS
445    Microsoft-DS
546    DHCP Client
547    DHCP Server
1080  Socks
 
 
basic linux commands
-  sar: collects and reports system activity information;
-  iostat: reports CPU utilization and disk I/O statistics;
-  free
-   
 
 

 
 
Encryption
==========
 
after building a tcp connection,
a SSH handshake is started
ClientHello
-  Random key generated
-  a cipher suite is negotiated
ServerHello
-  Server agrees to the TLS version
-  Random key received
-  Receive a certificate
-  Server Hello Done
 
Validation
-  Browser figures out if cert is valid
-  Sends out the last unencrypted message changeCipherSpec
 
Switch to the PFS Session or Symmetric secret
 
 
 
 
TLS happens before the Application layer
- TLS makes user of multiple crypto paradigms,
  - Public Key Cryptography for shared secret generation and authentication (making sure you are who you say you are).
  - Symmetric Key Cryptography using shared secrets for encrypting requests and responses.
 
Asymmetric Algorithms
- RSA
- uses two separate keys one to encrypt and one to decrypt
 
Symmetric Algorithms
- AES and 3DES
- uses a single key for encryption and decryption
- computationally faster
- know as session keys, used for a single session
 
Hashing
- mainly used for data integrity purposes and to verify the authenticity of communication. The main use in SSH is with HMAC, or hash-based message authentication codes
 
 
 
RSA
- is two algorithms
  - asymmetric encryption
  - digital signatures
 
Diffie-Hellman
- is a key exchange algorithm
 
 
 
 
 
Large file transfer
==============
/// You need to distribute a terabyte of data from a single server to 10,000 nodes,
/// and then keep that data up to date. It takes several hours to copy the data just to one server.
/// How would you do this so that it didn't take 20,000 hours to update all the servers? Also,
/// how would you make sure that the file wasn't corrupted during the copy?
 
- how many times will this be repeated/ongoing?
- will you be adding files to your set of file later on
- why is it taking several hours to copy 1 tb? do all experience the same issues
 
:peer to peer
the files will look corrupted until the peer to peer transfer is 100% complete
you would need to implement a staging transfer dir will be duplicated on each server,
one for staging area and peering and one for live since
- firewall issues, every server needs to be able to talk to other servers
- if you change the data you need to create a new torrent
 
 
:rsync, lsyncd
 
- key words, corrupt.
- possibility the use of a git repository
- being in banking, firewalls are always an issue
- break it down into regions
but then it comes from
- runs
 
once the data is in the regions or sub regions then use a peer to peer protocol
- firewalls are less of an issue in the intra region communication
- speed of networks are usually faster
 
What if the servers are in the same location
- then the servers would be constraint by the same networks
- if all servers are on local
 
