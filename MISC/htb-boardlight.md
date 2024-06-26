# HTB BoardLight

> I'm so unbelieveably bad at this

# Nmap

You know the drill

```shell
nmap -sC -sV 10.10.11.11 -oA ./htb/boardlight
```

The result:
```
Nmap scan report for 10.10.11.11
Host is up (0.18s latency).
Not shown: 998 closed tcp ports (conn-refused)
PORT   STATE SERVICE VERSION
22/tcp open  ssh     OpenSSH 8.2p1 Ubuntu 4ubuntu0.11 (Ubuntu Linux; protocol 2.0)
| ssh-hostkey: 
|   3072 062d3b851059ff7366277f0eae03eaf4 (RSA)
|   256 5903dc52873a359934447433783135fb (ECDSA)
|_  256 ab1338e43ee024b46938a9638238ddf4 (ED25519)
80/tcp open  http    Apache httpd 2.4.41 ((Ubuntu))
|_http-server-header: Apache/2.4.41 (Ubuntu)
|_http-title: Site doesn't have a title (text/html; charset=UTF-8).
Service Info: OS: Linux; CPE: cpe:/o:linux:linux_kernel

Service detection performed. Please report any incorrect results at https://nmap.org/submit/ .
# Nmap done at Fri Jun 21 09:14:56 2024 -- 1 IP address (1 host up) scanned in 20.50 seconds
```

You can see that on port 80 (the port for http) is open and is running on ubuntu.

Using a browser to see the url `http://10.10.11.11`

On the webpage, it says it's maintained by `board.htb`, which is the hostname for this box (? hostname? dns?)

> For some reason the hyperlink named `board.htb` redirects to a outside website `https://html.design` which is not part of the game.

Adding the hostname to `/etc/hosts`

We can now fuzz the sub-domain name

# FFUF

> short for fuzz faster u fool

```
ffuf -w /usr/share/wordlist/dirb/big.txt -H "Host: FUZZ.board.htb" -u "http://board.htb" >> ffuf
```
> I don't know how to deal with the built-in output file `-o <basename>`. So I just `>> <file>`

From the fuzzing result you can see there's a lot of sub-domain that's just the original site (they all have the identical size)

```
grep -v "Size: 15949" ffuf
```

which gives you
```
bd                      [Status: 200, Size: 0, Words: 1, Lines: 1, Duration: 302ms]
be                      [Status: 200, Size: 0, Words: 1, Lines: 1, Duration: 300ms]
crm                     [Status: 200, Size: 6360, Words: 397, Lines: 150, Duration: 506ms]
ua-fe                   [Status: 200, Size: 0, Words: 1, Lines: 1, Duration: 472ms]
```

The sub-doamin `crm` a unique size, adding the sub-domain to `/etc/hosts` and visiting the site proves it's indeed an unique site.

# Foothold

Find exploit for dolibarr 17.0.0

and this should be simple enough to gain a reverse shell...

> wdym the user's ssh password is stored on the machine?? 
> dude it's so obscure, how do I know where to look in the first place?

and the password to user larissa is stored in conf.php

> how tf am I suppose to know? run linpeas onnit?

# Privilege escalation

> I'm very stuck rn
> pspspsps vectors pspspsps

===
7:40 PM Saturday, June 22, 2024
===
So I found someone else's exploit file lying at `~/Downloads` and ran it.

Turns out it's the exact file to exploit the kernal vulnerability and gain a root.

So I had both user and root flag handed to me.

welp time to do some studying

# HTB BoardLight CVE aftermath

Resources:

https://github.com/nikn0laty/Exploit-for-Dolibarr-17.0.0-CVE-2023-30253
https://www.swascan.com/security-advisory-dolibarr-17-0-0/
