# Operating Servers at Scale

First thing you need to do is find bottlenecks using metrics, (sysstat is a good tool for this)
you will want to analyse: 
- Memory
- CPU
- Network I/O
- Disk I/O
 
## Comparing architectures
There are many approaches, this next step attempts to compare the various pros and cons for the different approcahes


### Message Queue vs RestAPI/Web Service
Message Queues have a lot more features, 
Webservices: if you want to handle error conditions yourself or leave them to the message queue.

##### Web Service: 
- Client server relationship
- If the server fails the client must take responsibility to handle the error.
- When the server is working again the client is responsible of resending it.
- If the server gives a response to the call and the client fails the operation is lost.
- If million of clients call a web service on one server in a second, most probably your server will go down.
- You can expect an immediate response from the server, but you can handle asynchronous calls too.

##### Message Queues:
- If the server fails, the queue persist the message (optionally, even if the machine shutdown).
- When the server is working again, it receives the pending message.
- If the server gives a response to the call and the client fails the message is persisted.
- If you have contention, you can decide how many requests are handled by the server (call it worker instead).
- You don't expect an immediate synchronous response, but you can implement/simulate synchronous calls.


#### RestAPI vs Database Calls
The question of whether to add a RestAPI layer infornt of a database tier or allow your clients to make database calls
Rest has a performance hit at the expense for scaliability


##### RestAPI
- can add a caching layer to speed up the calls
- allows for multiple clients (Web, Mobile, desktop etc) calls all get centralised, 
- security both with access to the API and limiting raw database access
- versioned, changing the backend database schema doesnt require to recode the client application (just the RestAPI)
- Scales greater than direct database calls

##### Database
- Rest has a performance hit on the call however makes up for it in being more scaliability
- fewer connection to the db


#### GeoDNS vs Anycast

##### GeoDNS
- GeoDNS resolves the same name to different IP addresses based on the requester's IP address.
- GeoDNS uses a map of resource locations and performs logic to determine which of those resources is closest to a given requesting IP address, and then returns that IP address.
- Suited for web applications scattered all over the world to make sure a given client will stick to a specific instance/region;

##### AnyCast
- To use anycast you advertise the same network in multiple spots of the Internet using BGP, and rely on shortest-path calculations to funnel clients to your multiple locations
- An Anycasted DNS server will return the same IP address regardless of who is doing the asking.
- Anycast doesnt know the users location 
- BGP AnyCast works well for stateless protocols like DNS, where there is no connection or session persistence
- generally not used for web servers since routing changes in the global BGP table mid-connection break TCP connections, break web application sessions, and generally cause havoc if anycast is used

> [tcp over ip anycast](http://blog.catchpoint.com/2015/09/24/tcp-over-ip-anycast/)
>- DNS assignment is based on the IP address of the user’s DNS resolver and not the user’s device. So, if a user in New York is using a California DNS resolver, they are assigned to our West Coast PoP instead of the East Coast PoP.
>- The database used by DNS providers for converting an IP address to a location might not be completely accurate. Their country-level targeting is generally much better than their city-based targeting.



# TODO
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
 
 
 
