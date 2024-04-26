# Bandit

My notes on a wargame called Bandit.

> Spoilers! 
> **If you somehow find this file, and you're not Astelor, please kindly frick off :)**
>
> Astelor: This file is intended to be my own writeup. I'm just learning linux terminal. 
> Astelor: I don't intend this file to be github-markdown friendly, but it's written with markdown stylers. 

0~5's passwords are easliy found with simple linux file discovery commands. 

bandit.labs.overthewire.org:2220

> so apparently git keeps all the history, huh.
>
> And apparently they change the password regularly, the password in there may not be valid after a year.
> But still, please kindly frick off.

# Bandit5

```
Puzzle requirements:
	human-readable
	1033 bytes in size
	not executable
```

## 5-Use find

`-perm -mode`

File's permission bits are exactly *mode*

Permission bits:
```
9 876 543 210
d rwx r-x r-x
```
- 9: file type
  - d: directory
  - -: file
- rwx: read, write, execute
- 8 ~ 6: user permissions
- 5 ~ 3: group permissions
- 2 ~ 0: other (everyone) permissions

`-perm /mode`

> find -type f ! -perm /u=x,g=x,o=x

Find files without executable permissions. 
The command does not like spaces.

`-type c`

- c: character (unbuffered) special
- d: directory
- f: regular file

`-ls`

List current file in `ls -dils` format on standard output.

`-size n[cwbkMG]`

File uses less than, more than or exactly n units of space, rounding up.

Usable suffixes:
- b: for 512-byte blocks (the default if no suffix is used)
- **c**: for bytes
- w: for two-byte words
- k: for kBs (1024 bytes)
- M: for MBs (1024 x 1024 bytes)
- G: for GBs (1024 x 1024 x 1024 bytes)

## 5-Use file

Determine file type

> I don't think this is a default command in the kali-linux minimum pack.

`-exec *command* {} \;`

> find -exec file {} \;

= First try: = 
> Command crafting...
> find -type f -size 1033c ! -perm /u=x,g=x,o=x -exec file {} \; | grep ASCII

= Second try: = 
> find -type f -size 1033c ! -perm /u=x,g=x,o=x -exec file {} \; -ls

Bruh there's only one file with 1033 bytes of size

And there you have it! NEXT LEVEL

# Bandit6

```
Requirements:
	owned by user bandit7
	owned by group bandit6
	33 bytes in size
"Somewhere on the server"
```

## 6-Use find

`-group *gname*`

`-user *uname*`

= First try: =
> Command crafting...
> find / -type f -size 33c -user bandit7 -group bandit6

It give a lot of permission denied. But I eyed out the file, it doesn't count.

Imma try pipelining it and do other stuff to clean it up. 

- `2>&1`: Redirects the stderr (error output) to stdout (standard output), so that error messages are included in the pipeline

- `2`: File descriptor for standard error
- `>`: Indicates redirection
- `/dev/null`: The special device file that discards all data written to it.

= Second try: =
> Command crafting...
> find / -type f -size 33c -user bandit7 -group bandit6 2>/dev/null

It now gives you the desired file directory. 

# Bandit7

```
Requirements:
"The password for the next level is stored in the file data.txt next to the word millionth"
```
## 7-Use grep

`grep pattern filename`

as simple as that!

> Command crafting...
> grep millionth data.txt

# Bandit8

```
Puzzle:
"the only line of text that occurs only once"
```

Do I need to write a script? 
I guess I can count the number of each entries?

[Piping and Redirection](https://ryanstutorials.net/linuxtutorial/piping.php)

I want a single command that does what I want maaaaaaaan.

Is there a thing that tracks all occurences with a variable in linux bash like I can do in C++?

Traversing each lines in the file. Upon each new lines, traverse the known texts file, if the "newline" is a new occurance, append it to the known text file.

Wait you can sort lines of text??

Alright there are commands in place to help me with stuffs, I don't have to write everything from scratch. POG

## 8-Use sort

sort lines of text files

## 8-Use uniq

report or omit repeated lines

`-c, --count`

prefix lines by the number of occurrences

`-i, --ignore-case`

ignore differences in case when comparing

`-u, --unique`

only print unique lines

> The commands give the result using standard output, like the command echo.
> So I should be able to pipleline them.

= First try =
> Command crafting...
> uniq data.txt | sort

Bruh I eyed the password out, doesn't count.

= Second try =
> Command crafting...
> sort data.txt | uniq -c | sort

- You need to sort the text file first for `uniq -c` to work properly.
- The password is the one with a prefix of 1.

# Bandit9

```
Puzzle:
- In the file data.txt
- One of the human-readable strings
- Preceded by several '=' characters
```

## 9-Use strings

Print the sequences of printable characters in files.

> Command crafting...
> strings data.txt | grep '==='

# Bandit10

```
Puzzle:
- In the file data.txt
- Which contains base64 encoded data
```

## 10- Use base64

Base64 encode/decode data and print to standard output

The command is 

`-d, --decode`

> Command crafting...
> cat data.txt | base64 -d

# Bandit11

```
Puzzle:
- In the file data.txt
- ROT13
```

## 11-Use tr

Translate or delete characters

> Command crafting...
> cat data.txt | tr 'A-Za-z' 'N-ZA-Mn-za-m'

Map upper case A-Z to N-ZA-M and lower case a-z to n-za-m

# Bandit12

```
Puzzle:
- In data.txt
"A hexdump of file that has been repeatedly compressed."
```

## 12-Use xxd

Make a hex dump or do the reverse.

`-r, -revert`

Reverse Operation: convert (or patch) hex dump into binary.

## 12-Use gzip

`-d, --decompress, --uncompress`

- Magic number at the header can determine which compressing method a compressed hex used (?)
- [List of file signatures](https://en.wikipedia.org/wiki/List_of_file_signatures)


> Command crafting...

I copied the hexdump to my local machine, since ssh is kinda laggy.

- magic numbers:
	- gzip: `1F 8B`
	- bzip2: `42 5A 68`

> xxd -r data.txt > bandit12.xd

> gzip -dck bandit12.xd

> dd if=right3 of=right3-extract bs=1 skip=1024 count=224


Basically, it's just first `xxd -revert` the data.txt to binary file, which is the file that the machine can read.

And uses pipeline, `| xxd` to read the human-readable hexdump when inspecting the magic numbers (file signature) which is a header.

Decompressing the file with it's respective compress-tool (gzip or bzip2 in this case).

In the last two case, the header is replaced by something funny. You need to use `dd` to extract the parts with gzip or bzip2 headers.

(It's so annoying I don't wanna do it again. bandit12.txt should be on your local machine)

# Bandit13

```
Puzzle:
The password for the next level is stored in /etc/bandit_pass/bandit14 and can only be read by user bandit14. 

For this level, you don’t get the next password, but you get a private SSH key that can be used to log into the next level.

Note: localhost is a hostname that refers to the machine you are working on
```

WHAT??
Relavent readings: https://help.ubuntu.com/community/SSH/OpenSSH/Keys

SSH keys:
> Public and private key encryting technique is used in different applications. (i.e. TLS/SSL(Transport Layer Security/Secure Sockets Layer)) not just SSH.
- Public keys
- Private keys

> I get a private key that can log into the level? howtf do I use a private key to log ssh?

SSH can either use
- RSA key: (Rivest-Shamir-Adleman)
- DSA key: (Digital Signature Algorithm)

## Key-based SSH logins

- Most secure of several mode of authentication usable with OpenSSH

> Can you ssh to another user on the same "machine" (bandit.labs.overthewire.org)?
> -- YES, you can ssh to another user on the same machine.
>
> So I just use the ssh private key to log into bandit14, and get its password at `/etc/bandit_pass/bandit14` ?

## 13-Use ssh

`-i` identity_file

Selects a file from which the identity (private key) for public key authetication is read.

Okay it needs to be done **on the bandit13**, not on my client.

> Command: (on bandit13@bandit)
> ssh -i sshkey.private bandit14@bandit.labs.overthewire.org -p 2220

But how exactly tf does ssh work?

# Bandit14

```
Puzzle:
The password for the next level can be retrieved by submitting the password of the current level to port 30000 on localhost.
```

heh?

Submit with what?? is there a command that can let me send stuff?

with netcat?

## 14-Use netcat (nc)

TCP/IP swiss army knife

"'nc host port' creasts a TCP connection to the given port on the given target host. Your standard input is then sent to the host, and anything that comes back across the connection is sent to your standard output."

So, as simple as that? 
Ok how tf do I use it then?

> Command crafting...
> nc localhost 30000
> (and send the password through standard input)
> (it'll spit out the result through standard output)

# Bandit15

> password: jN2kgmIXJ6fShzhT2avhotn4Zcka6tnt

```
Puzzle:
The password for the next level can be retrieved by submitting the password of the current level to port 30001 on localhost using SSL encryption.
```

what??

Do I send it with netcat? or can ssl send stuff as well?

I never ran nmap to see what port the machine has before. maybe I shoud.

## 15-Use openssl

`s_client`

This implements a generic SSL/TLS client which can establish a transparent connect to a remote server speaking SSL/TLS. It's intended for testing purposes only and provides only rudmentary interface functionality but internally uses mostly all functionality of the OpenSSL `ssl` library.

> Command: openssl s_client -connect localhost:30001

It gives a lot of info dump too, what are those?

You can see the full options of `s_client` with `openssl s_client --help`

# Bandit16

> password: JQttfApK4SeyHwDlI9SXGR50qclOAil1

```
Puzzle:
The credentials for the next level can be retrieved by submitting the password of the current level to a port on localhost in the range 31000 to 32000. 

First find out which of these ports have a server listening on them. Then find out which of those speak SSL and which don’t. There is only 1 server that will give the next credentials, the others will simply send back to you whatever you send to it.
```

nmap I guess? but how do I ping only the ports in range?

## 16-Use nmap

bruh there are so many stuffs and configs.

`-p, port ranges`

This option specifies which ports you want to scan and overrides the default. Individual port numbers are OK, as are ranges separated by a hypen (e.g. 1-1023)

Scan port range 31000~32000

> You just need a dash, as simple as that.

and what else? ssl? server?

Do I just use `openssl s_client -connect localhost:port`?

= Commands here! =
> Command crafting...
> nmap -sV -sC -p 31000-32000 localhost

```
31518/tcp open  ssl/echo
| ssl-cert: Subject: commonName=localhost
| Subject Alternative Name: DNS:localhost
| Not valid before: 2024-04-25T21:07:55
|_Not valid after:  2024-04-25T21:08:55

31790/tcp open  ssl/unknown
| fingerprint-strings:
|   FourOhFourRequest, GenericLines, GetRequest, HTTPOptions, Help, Kerberos, LDAPSearchReq, LPDString, RTSPRequest, SIPOptions, SSLSessionReq, TLSSessionReq, TerminalServerCookie:
|_    Wrong! Please enter the correct current password
| ssl-cert: Subject: commonName=localhost
| Subject Alternative Name: DNS:localhost
| Not valid before: 2024-04-25T21:07:55
|_Not valid after:  2024-04-25T21:08:55
```

> openssl s_client -connect localhost:31790

Send the current level's password through standard input, it gives you the credentials through standard output.

Save it (`touch` + `nano`) and CHANGE ITS PERMISSION

> chmod 600 bandit17.key

This change the file permission to read-write to owner. (the box forbids connecting with a key that has readable by everyone permission)

> ssh -i /tmp/HardToGuessName/bandit17.key bandit17@bandit.labs.overthewire -p 2220

# Bandit17

> password: VwOSWtCA7lRKkTfbr2IDh6awj9RNZM5e

```
Puzzle:
There are 2 files in the homedirectory: passwords.old and passwords.new. The password for the next level is in passwords.new and is the only line that has been changed between passwords.old and passwords.new

NOTE: if you have solved this level and see ‘Byebye!’ when trying to log into bandit18, this is related to the next level, bandit19
```
So I need to compare the new files and see what's different

## 17-Use diff

Compare files line by line

`-y --side-by-side`

output in two columns

> diff passwords.new passwords.old

```
< change-in-passwords.new
---
> counterpart-in-passwords.old
```

# Bandit18

> password: hga5tuuCLF6fFzUpnagiMN8ssu9LFrdg

```
Puzzle:
The password for the next level is stored in a file readme in the homedirectory. Unfortunately, someone has modified .bashrc to log you out when you log in with SSH.
```

okay dude, how tf do I login without using ssh? and the hint are ssh, ls, cat.

Are they forcing me to use other methods, other than ssh

Alright nmap time I guess, time to discover available services

nope there's no other services to connect to.

## 18-Use ssh

So apparently you can append a command behind ssh

> ssh bandit18@bandit.labs.overthewire.org -p 2220 'cat readme'

It executes the command and logs you out.

> This means an automatic "logs you out" script won't save you from keeping your contents from intruders.
> It means you're "in and out" lmao.

# Bandit19

> password: awhqfNnAbc1naukrpqDYcF95h7HoMTrC

