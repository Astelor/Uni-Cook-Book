# Bandit

My notes on a wargame called [Bandit](https://overthewire.org/wargames/bandit), on OverTheWire.

> Spoilers! 
>
> Astelor: This file is intended to be my own writeup. I'm just learning linux terminal. 
> Astelor: I don't intend this file to be github-markdown friendly, but it's written with markdown stylers. 

0~5's passwords are easliy found with simple linux file discovery commands. 

bandit.labs.overthewire.org:2220

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

===============================
10:28 PM Tuesday, June 25, 2024
===============================

Update:

After using the command `openssl s_client -connect localhost:31790` and giving the system your password. It stubbornly returns you:

```
(info from the server)
---
read R Block
(Your password)
KEYUPDATE
```

I thought it was a bug at first, or there's something wrong with the box. But when further reading the maunal using `man openssl s_client`.

It tells me this:
```
CONNECTED COMMANDS
       If  a  connection  is  established with an SSL server then any data received from the server is displayed and any key presses will be sent to the
       server. If end of file is reached then the connection will be closed down. When used interactively (which means neither -quiet nor -ign_eof  have
       been  given),  then  certain  commands are also recognized which perform special operations. These commands are a letter which must appear at the
       start of a line. They are listed below.

       Q   End the current SSL connection and exit.

       R   Renegotiate the SSL session (TLSv1.2 and below only).

       k   Send a key update message to the server (TLSv1.3 only)

       K   Send a key update message to the server and request one back (TLSv1.3 only)
```

I didn't know this until banging my head at the wall trying different arguments. And this one works.

> openssl s_client -connect localhost:31790 -nocommands

It's just the server is interpreting the password as a command because it starts with a **k**.

Okay let's move on.

# Bandit17

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

```
Puzzle:
To gain access to the next level, you should use the setuid binary in the homedirectory. 

Execute it without arguments to find out how to use it. The password for this level can be found in the usual place (/etc/bandit_pass), after you have used the setuid binary.
```

what the heck is setuid?

UID (User Identifier). It's a unique identifier assigned to each user in a system.

```
aster:x:1000:1000",,,"/home/aster:/bin/bash
```
- username: `aster`
- password: `x`
- UID: `1000`
- GID: `1000`
- user info: `,,,`
- home directory: `/home/aster`
- login shell: `/bin/bash`

I think you can `setuid` with chmod?

so uhhh, it gives me this 
```
bandit19@bandit:~$ file bandit20-do
bandit20-do: setuid ELF 32-bit LSB executable, Intel 80386, version 1 (SYSV), dynamically linked, interpreter /lib/ld-linux.so.2, BuildID[sha1]=037b97b430734c79085a8720c90070e346ca378e, for GNU/Linux 3.2.0, not stripped
```

do I just run it? 
YES you just run it

> ./bandit20-do whoami
It give you `bandit20`, which means it IS running the command `whoami` as another user, which is bandit20. 
So now I just have to cat the password at `/ect/bandit_pass/bandit20` out as bandit20 the user.

> ./bandit20-do cat /etc/bandit_pass/bandit20

# Bandit20

```
Puzzle:
There is a setuid binary in the homedirectory that does the following: it makes a connection to localhost on the port you specify as a commandline argument. 

It then reads a line of text from the connection and compares it to the password in the previous level (bandit20). If the password is correct, it will transmit the password for the next level (bandit21).
```

So this one requires you to have two terminals, login as bandit20 on another terminal. 
Port numbers range from 0 to 65535

> nc -l 12345

Start up netcat to listen to inbound connection on port 12345.

Now type this command on another terminal as bandit20@bandit
> ./suconnect 12345

It will connect to localhost:12345

Now you can enter the current password on the terminal that's listening to inbound connection. Upon entering the password, it will give you the password to the next level.

# 20-Use tmux

Terminal multiplexer: it enables a number of terminals to be created, accessed, and controlled from a single screen. tmux may be detached from a screen and continue runnig in the background, then later reattached.

> So that you don't NEED to connect to the same host at once!

# Bandit21

> password: NvEJF7oVjkddltPSrdKEFOllh9V1IBcq

```
Puzzle:
A program is running automatically at regular intervals from cron, the time-based job scheduler. Look in /etc/cron.d/ for the configuration and see what command is being executed.
```

so it looks like this

```
bandit21@bandit:~$ ls -la /etc/cron.d
total 56
drwxr-xr-x   2 root root  4096 Oct  5  2023 .
drwxr-xr-x 106 root root 12288 Oct  5  2023 ..
-rw-r--r--   1 root root    62 Oct  5  2023 cronjob_bandit15_root
-rw-r--r--   1 root root    62 Oct  5  2023 cronjob_bandit17_root
-rw-r--r--   1 root root   120 Oct  5  2023 cronjob_bandit22
-rw-r--r--   1 root root   122 Oct  5  2023 cronjob_bandit23
-rw-r--r--   1 root root   120 Oct  5  2023 cronjob_bandit24
-rw-r--r--   1 root root    62 Oct  5  2023 cronjob_bandit25_root
-rw-r--r--   1 root root   201 Jan  8  2022 e2scrub_all
-rwx------   1 root root    52 Oct  5  2023 otw-tmp-dir
-rw-r--r--   1 root root   102 Mar 23  2022 .placeholder
-rw-r--r--   1 root root   396 Feb  2  2021 sysstat
```

Wait I think I have permission to read them? cool

The cron configs that have read permission to everyone (and are probably relavent)

etc/cron.d/sysstat
```
bandit21@bandit:~$ cat /etc/cron.d/sysstat
# The first element of the path is a directory where the debian-sa1
# script is located
PATH=/usr/lib/sysstat:/usr/sbin:/usr/sbin:/usr/bin:/sbin:/bin

# Activity reports every 10 minutes everyday
5-55/10 * * * * root command -v debian-sa1 > /dev/null && debian-sa1 1 1

# Additional run at 23:59 to rotate the statistics file
59 23 * * * root command -v debian-sa1 > /dev/null && debian-sa1 60 2
```

e2scrub_all:
```
bandit21@bandit:~$ cat /etc/cron.d/e2scrub_all
30 3 * * 0 root test -e /run/systemd/system || SERVICE_MODE=1 /usr/lib/x86_64-linux-gnu/e2fsprogs/e2scrub_all_cron
10 3 * * * root test -e /run/systemd/system || SERVICE_MODE=1 /sbin/e2scrub_all -A -r
```

```
bandit21@bandit:~$ cat /etc/cron.d/.placeholder
# DO NOT EDIT OR REMOVE
# This file is a simple placeholder to keep dpkg from removing this directory
```

Do I just assume those with comments are the ones I seek?


Why are cron config files so hard to read??
```
# m h dom mon dow usercommand
```

what the heck, I'm gonna throw commands at it irresponsibly until it works 

## 21-Use cron

daemon to execute scheduled commands

> `daemon` is a type of background process in Unix-like operating systems that runs continuously, typically without any direct user interaction.

alright time to understand what in the world cron is:
```
* * * * * command_to_run
- - - - -
| | | | |
| | | | +----- Day of week (0 - 7) (Sunday is 0 or 7)
| | | +------- Month (1 - 12)
| | +--------- Day of month (1 - 31)
| +----------- Hour (0 - 23)
+------------- Minute (0 - 59)
```

Each asterisk `*` is a wildcard, meaning "every"

Let's look at `/etc/cron.d/sysstat` first:

```
bandit21@bandit:~$ cat /etc/cron.d/sysstat
# The first element of the path is a directory where the debian-sa1
# script is located
PATH=/usr/lib/sysstat:/usr/sbin:/usr/sbin:/usr/bin:/sbin:/bin

# Activity reports every 10 minutes everyday
5-55/10 * * * * root command -v debian-sa1 > /dev/null && debian-sa1 1 1

# Additional run at 23:59 to rotate the statistics file
59 23 * * * root command -v debian-sa1 > /dev/null && debian-sa1 60 2
```

so `5-55/10` in the minute field means
- `5-55` specifies a range from the 5th minute to the 55th minute of the hour
- `/10` indicates the command should run every 10 minutes with in that range

## 21-Use command

Execute a simple command or display information about commands.

use `command --help` to see more information about this command :). 

And it's used to check the exisitence on that command without executing it.

> HUH so I don't have to spam `man` everytime I wanna check if I have a specific thing installed.


AHHHHHHHHHH this means there must be a file somewhere that I'm able to write

oh wait I have execute permisison, and the last line passes a parameter to `sa1`


## 21- Use sadc

System activity data collector.

`-F`

The creattion of outfile will be forced. If the file already exists and has a format unknown to sadc then it will be truncated.

`-L`

sadc will try to get an exclusive lock on the outfile before writing to it or truncating it. Failure to get the lock is fatal, except in the case of trying to write a normal (i.e. not a dummy and not a header) record to an existing file, in ally, the only reason a lock would fail would be if another sadc process were also writing to the file.

> wait I can execute sadc anyway, its perm is read-execute to everyone.
>
> wait no, sadc is the backend binary file, so is it a pipebomb? do I need to reverse shell it?


wait, if I LEARN what these shell scripts are in order to solve the puzzle, I can gain some knowledge about shell script and write one of my own. pog

what the actual fuck are these?? if I can't pass commands into the sysstat executable, what the heck am I supposed to do with these?

---

UM, I went the exact opposite direction, sysstat is not the clue. The clue is

```
-rw-r--r--   1 root root   120 Oct  5  2023 cronjob_bandit22
```

Where we have read permission
```
bandit21@bandit:/etc/cron.d$ cat cronjob_bandit22
@reboot bandit22 /usr/bin/cronjob_bandit22.sh &> /dev/null
* * * * * bandit22 /usr/bin/cronjob_bandit22.sh &> /dev/null
```

And here we can see it runs a bash file every minute, and we have read permission to the `/usr/bin` directory

```
bandit21@bandit:$ cat /usr/bin/cronjob_bandit22.sh
#!/bin/bash
chmod 644 /tmp/t7O6lds9S0RqQh9aMcz6ShpAoZKF7fgv
cat /etc/bandit_pass/bandit22 > /tmp/t7O6lds9S0RqQh9aMcz6ShpAoZKF7fgv
```

and it literally modifies the permission to `rw-r--r--` to this file, and cat the passkey to the next level to said file.

AND THAT'S IT.

# Bandit22

welp

```
Puzzle:
A program is running automatically at regular intervals from cron, the time-based job scheduler. Look in /etc/cron.d/ for the configuration and see what command is being executed.
```

Same thing, the clue is in `/etc/cron.d/cronjob_bandit23`

```
bandit22@bandit:~$ cat /etc/cron.d/cronjob_bandit23
@reboot bandit23 /usr/bin/cronjob_bandit23.sh  &> /dev/null
* * * * * bandit23 /usr/bin/cronjob_bandit23.sh  &> /dev/null
```

## 22-Use stat

I'm just tired of using `ls -la <directory> | grep <name>` to check permissions

```
bandit22@bandit:~$ stat /usr/bin/cronjob_bandit23.sh
  File: /usr/bin/cronjob_bandit23.sh
  Size: 211             Blocks: 8          IO Block: 4096   regular file
Device: 10301h/66305d   Inode: 77149       Links: 1
Access: (0750/-rwxr-x---)  Uid: (11023/bandit23)   Gid: (11022/bandit22)
Access: 2024-05-17 06:53:01.138587458 +0000
Modify: 2023-10-05 06:19:35.003293863 +0000
Change: 2023-10-05 06:19:35.007293872 +0000
 Birth: 2023-10-05 06:19:35.003293863 +0000
```

And we have read and execute permission to this file.
```
bandit22@bandit:~$ cat /usr/bin/cronjob_bandit23.sh
#!/bin/bash

myname=$(whoami)
mytarget=$(echo I am user $myname | md5sum | cut -d ' ' -f 1)

echo "Copying passwordfile /etc/bandit_pass/$myname to /tmp/$mytarget"

cat /etc/bandit_pass/$myname > /tmp/$mytarget
```

Let's try executing it
```
bandit22@bandit:~$ /usr/bin/cronjob_bandit23.sh
Copying passwordfile /etc/bandit_pass/bandit22 to /tmp/8169b67bd894ddbb4412f91573b38db3
```
wait if it's executing it in cron as bandit23, this means `/usr/bin/cronjob_bandit23.sh` has already been executed as user bandit23, and the password is in the file with this name: /tmp/`echo I am user $myname | md5sum | cut -d ' ' -f 1` 

sooooo
```
bandit22@bandit:~$ echo I am user bandit23 | md5sum | cut -d ' ' -f 1
8ca319486bfbbc3663ea0fbe81326349
```

```
bandit22@bandit:~$ cat /tmp/8ca319486bfbbc3663ea0fbe81326349
QYw0Y2aiA672PsMmh9puTQuhoz8SyR2G
```

# Bandit23

pog!

cron again
```
Puzzle:
A program is running automatically at regular intervals from cron, the time-based job scheduler. Look in /etc/cron.d/ for the configuration and see what command is being executed.

NOTE: This level requires you to create your own first shell-script. This is a very big step and you should be proud of yourself when you beat this level!

NOTE 2: Keep in mind that your shell script is removed once executed, so you may want to keep a copy around…
```

omg omg omg omg omg

```
bandit23@bandit:~$ cat /etc/cron.d/cronjob_bandit24
@reboot bandit24 /usr/bin/cronjob_bandit24.sh &> /dev/null
* * * * * bandit24 /usr/bin/cronjob_bandit24.sh &> /dev/null
```

Checking the perms
```
bandit23@bandit:~$ stat /usr/bin/cronjob_bandit24.sh
  File: /usr/bin/cronjob_bandit24.sh
  Size: 384             Blocks: 8          IO Block: 4096   regular file
Device: 10301h/66305d   Inode: 77152       Links: 1
Access: (0750/-rwxr-x---)  Uid: (11024/bandit24)   Gid: (11023/bandit23)
Access: 2024-05-17 06:56:01.382583766 +0000
Modify: 2023-10-05 06:19:36.111296412 +0000
Change: 2023-10-05 06:19:36.111296412 +0000
 Birth: 2023-10-05 06:19:36.111296412 +0000
```

```
bandit23@bandit:~$ cat /usr/bin/cronjob_bandit24.sh
#!/bin/bash

myname=$(whoami)

cd /var/spool/$myname/foo
echo "Executing and deleting all scripts in /var/spool/$myname/foo:"
for i in * .*;
do
    if [ "$i" != "." -a "$i" != ".." ];
    then
        echo "Handling $i"
        owner="$(stat --format "%U" ./$i)"
        if [ "${owner}" = "bandit23" ]; then
            timeout -s 9 60 ./$i
        fi
        rm -f ./$i
    fi
done
```
A loop. i is the variable for filenames, so I need to write a script to cat out the password in `/etc/bandit_pass/$myname`, and let `/etc/cron.d/cronjob_bandit24` the handle the job, since it'll be executed as bandit24.

Script crafting...
```
#!/bin/bash

cat /etc/bandit_pass/bandit24 > /tmp/astelor123
```

Checking the perms
```
bandit23@bandit:~$ stat /var/spool/bandit24/foo/
  File: /var/spool/bandit24/foo/
  Size: 249856          Blocks: 496        IO Block: 4096   directory
Device: 10301h/66305d   Inode: 517739      Links: 20
Access: (0773/drwxrwx-wx)  Uid: (    0/    root)   Gid: (11024/bandit24)
Access: 2024-05-17 20:33:01.407320761 +0000
Modify: 2024-05-17 20:35:11.279318102 +0000
Change: 2024-05-17 20:35:11.279318102 +0000
 Birth: 2023-10-05 06:19:36.099296385 +0000
```

we have write permission to this directory

So let's make a temporary directory first...
```
bandit23@bandit:~$ mktemp -d
/tmp/tmp.3TQWDB7Fhs
```

Create a file and write the script innit
```
bandit23@bandit:/tmp/tmp.3TQWDB7Fhs$ nano this.sh
```

**AND MOST IMPORTANTLY, MAKE IT EXECUTABLE TO ALL USERS**

```
bandit23@bandit:/tmp/tmp.3TQWDB7Fhs$ chmod 777 this.sh
bandit23@bandit:/tmp/tmp.3TQWDB7Fhs$ ls -la
total 10292
drwx------   2 bandit23 bandit23     4096 May 17 20:58 .
drwxrwx-wt 330 root     root     10526720 May 17 20:59 ..
-rwxrwxrwx   1 bandit23 bandit23       61 May 17 20:58 this.sh
```

Then move it to the desired directory
```
bandit23@bandit:/tmp/tmp.3TQWDB7Fhs$ mv this.sh /var/spool/bandit24/foo/
```

Wait for a few minutes
```
bandit23@bandit:/tmp/tmp.3TQWDB7Fhs$ cat /tmp/astelor123
```
It should give you the passkey.

Using `echo` in the script doesn't do much, since all standard outputs will go to `/dev/null` (linux dumpster fire) once `cronjob_bandit24.sh` is executed by cron. This is specified in `/etc/cron.d/cronjob_bandit24`.

# Bandit24

YES

```
Puzzle:
A daemon is listening on port 30002 and will give you the password for bandit25 if given the password for bandit24 and a secret numeric 4-digit pincode. There is no way to retrieve the pincode except by going through all of the 10000 combinations, called brute-forcing.
You do not need to create new connections each time
```

oooooooooooo, brute forcing

time to write a script that uses for loop heheheh

## 24-Shell script, for loop

```
for variable in list
do
  commands
done

```

testing...
```
#!/bin/bash

exec 3<>/dev/tcp/localhost/30002

read response <&3
echo "$response"

exec 3>&-
```

```
#!/bin/bash

exec 3<>/dev/tcp/localhost/30002

p="VAfGXJ1PBSsPSnvsjI8p759leLZ9GGar"

read res<&3

for a in {0..9}
do
        for b in {0..9}
        do
                for c in {0..9}
                do
                        for d in {0..9}
                        do
                                pin=$a$b$c$d
                                r="$p $pin"

                                echo "$r" >&3
                                read res <&3
                                echo $res >> /tmp/astelorrr123
                                echo "$pin $res"
                        done
                done
        done
done

exec 3>&-
```


result:
```
...
9012 Wrong! Please enter the correct pincode. Try again.
9013 Wrong! Please enter the correct pincode. Try again.
9014 Wrong! Please enter the correct pincode. Try again.
9015 Correct!
9016 The password of user bandit25 is p7TaowMYrmu23Ol8hiZh9UvD0O9hpx8d
9017
9018 Exiting.
9019
9020
```

The iteration took 30 minutes...

===============================
11:10 PM Tuesday, June 25, 2024
===============================

Update:

Thanks for making the iteration faster!

# Bandit25

```
Puzzle:
Logging in to bandit26 from bandit25 should be fairly easy… The shell for user bandit26 is not /bin/bash, but something else. Find out what it is, how it works and how to break out of it.
```

In the home directory we have this:
```
-r--------  1 bandit25 bandit25 1679 Oct  5  2023 bandit26.sshkey
```

the CLUE

I already forgot how to use a RSA key to ssh

## 25-What login shell does it use?

by examining the user's entry in the `/etc/passwd` file


```
bandit25@bandit:~$ cat /etc/passwd | grep bandit26
bandit26:x:11026:11026:bandit level 26:/home/bandit26:/usr/bin/showtext
```
while all the others use `/bin/bash`. Bandit26 uses `/usr/bin/showtext`

```
bandit25@bandit:~$ ls -la /usr/bin | grep showtext
-rwxr-xr-x  1 root     root           58 Oct  5  2023 showtext
```

And wtf is it??

```
bandit25@bandit:~$ cat /usr/bin/showtext
#!/bin/sh

export TERM=linux

exec more ~/text.txt
exit 0
```

it uses `/bin/sh` that reads the file `text.txt` in the home directory?

```
bandit25@bandit:~$ stat /bin/sh
  File: /bin/sh -> dash
  Size: 4          Blocks: 0          IO Block: 4096   symbolic link
Device: 10301h/66305d Inode: 1582        Links: 1
Access: (0777/lrwxrwxrwx)  Uid: (    0/    root)   Gid: (    0/    root)
Access: 2024-05-18 06:12:39.770608520 +0000
Modify: 2023-09-19 02:19:06.808836743 +0000
Change: 2023-09-19 02:22:57.101013755 +0000
 Birth: 2023-09-19 02:22:57.101013755 +0000
```

> wait wait wait, wdym I have write permission to /bin/sh ?????
> and wtf is a symbolic link?
> it's just a link, damnnit. but what can I do with it? point it to another file?

And we can see `/bin/sh` points to `/bin/dash`, which means they're the same thing

but what in the world does it have to do with a login shell?

```
ssh -i ~/bandit26.sshkey bandit26@localhost -p 2220 -o StrictHostKeyChecking=no
```

And it gives me this
```
...

  _                     _ _ _   ___   __
 | |                   | (_) | |__ \ / /
 | |__   __ _ _ __   __| |_| |_   ) / /_
 | '_ \ / _` | '_ \ / _` | | __| / / '_ \
 | |_) | (_| | | | | (_| | | |_ / /| (_) |
 |_.__/ \__,_|_| |_|\__,_|_|\__|____\___/
Connection to localhost closed.
```

Does this mean `/usr/bin/showtext` was successfully executed?

but sending things along with `ssh` doesn't work, since it's not exactly interactive

```
ssh -i ~/bandit26.sshkey bandit26@localhost -p 2220 -o StrictHostKeyChecking=no -t '/bin/sh -c "whoami"'
```

it doesn't wooorrrrrrrrrrrrrrrrrrrrrrrk

wdym breaking out of the non-interactive shell man? send it into a loop?

EHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH

So when I have the `/etc/motd` message, that means I have successfully logged into the session. But it jumps straight into the login shell. wtf can I do with it? modify the login shell? pwn the machine? reverse shell it? I don't have the shell to work with first.

If `/etc/motd` is executed, does that mean "some" bash must be present to do it, but how do I mess with a ssh session to gain a shell?

>  ssh -i ~/bandit26.sshkey bandit26@localhost -p 2220 -o StrictHostKeyChecking=no -vvv -f /bin/bash

> echo "echo "$-"; whoami" | ssh -i ~/bandit26.sshkey bandit26@localhost -p 2220 -o StrictHostKeyChecking=no -vvv


> echo "whoami" | ssh -i ~/bandit26.sshkey bandit26@localhost -p 2220 -o StrictHostKeyChecking=no -vvv

> ./script.sh | ssh -i ~/bandit26.sshkey bandit26@localhost -p 2220 -o StrictHostKeyChecking=no -vvv '!whoami'

| ssh -i ~/bandit26.sshkey bandit26@localhost -p 2220 -o StrictHostKeyChecking=no

`SET SHELL=/bin/bash` in vi editing for `more`

================================
7:24 AM Wednesday, June 26, 2024
================================

Update: Just beat bandit, the rest are just git log scavenging.

