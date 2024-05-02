# Bandit

My notes on a wargame called [Bandit](https://overthewire.org/wargames/bandit).

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

> password: VxCazJaVykI6W36BkBU0mJTCM8rR95XT

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

```
bandit21@bandit:~$ ls -la /usr/lib/sysstat
total 108
drwxr-xr-x  2 root root  4096 Oct  5  2023 .
drwxr-xr-x 87 root root  4096 Oct  5  2023 ..
-rwxr-xr-x  1 root root   446 Feb  2  2021 debian-sa1
-rwxr-xr-x  1 root root  1746 Jun  6  2023 sa1
-rwxr-xr-x  1 root root  1572 Jun  6  2023 sa2
-rwxr-xr-x  1 root root 87296 Jun  6  2023 sadc
```

debian-sa1
```
bandit21@bandit:~$ cat /usr/lib/sysstat/debian-sa1
#!/bin/sh
# vim:ts=2:et
# Debian sa1 helper which is run from cron.d job, not to needlessly
# fill logs (see Bug#499461).

set -e

# Skip in favour of systemd timer
[ ! -d /run/systemd/system ] || exit 0

# Our configuration file
DEFAULT=/etc/default/sysstat
# Default setting, overridden in the above file
ENABLED=false

# Read defaults file
[ ! -r "$DEFAULT" ] || . "$DEFAULT"

[ "$ENABLED" = "true" ] || exit 0

exec /usr/lib/sysstat/sa1 "$@"
```
AHHHHHHHHHH this means there must be a file somewhere that I'm able to write

oh wait I have execute permisison, and the last line passes a parameter to `sa1`

sa1
```
bandit21@bandit:~$ cat /usr/lib/sysstat/sa1
#!/bin/sh
# /usr/lib/sysstat/sa1
# (C) 1999-2020 Sebastien Godard (sysstat <at> orange.fr)
#
#@(#) sysstat-12.5.2
#@(#) sa1: Collect and store binary data in system activity data file.
#

# Set default value for some variables.
# Used only if ${SYSCONFIG_DIR}/${SYSCONFIG_FILE} doesn't exist!
HISTORY=0
SADC_OPTIONS=""
SA_DIR=/var/log/sysstat
SYSCONFIG_DIR=/etc/sysstat
SYSCONFIG_FILE=sysstat
UMASK=0022
LONG_NAME=n

[ -r ${SYSCONFIG_DIR}/${SYSCONFIG_FILE} ] && . ${SYSCONFIG_DIR}/${SYSCONFIG_FILE}

umask ${UMASK}

# If the user-supplied value for SA_DIR in sysconfig file is not a directory
# then fall back on default directory. Create this default directory if it doesn't exist.
[ -d ${SA_DIR} ] || SA_DIR=/var/log/sysstat
[ -d /var/log/sysstat ] || mkdir /var/log/sysstat

if [ ${HISTORY} -gt 28 ]
then
        SADC_OPTIONS="${SADC_OPTIONS} -D"
        LONG_NAME=y
fi

ENDIR=/usr/lib/sysstat
cd ${ENDIR}
[ "$1" = "--boot" ] && shift && BOOT=y || BOOT=n
[ "$1" = "--sleep" ] && shift && SLEEP=y || SLEEP=n

ROTATE=n
[ "$1" = "--rotate" ] && shift && ROTATE=y && [ "$1" = "iso" ] && shift && LONG_NAME=y
if [ "${ROTATE}" = "y" ]
then
        if [ "${LONG_NAME}" = "y" ]
        then
                DATE=`date --date=yesterday +%Y%m%d`
        else
                DATE=`date --date=yesterday +%d`
        fi
        SA_DIR=${SA_DIR}/sa${DATE}
fi

if [ "${SLEEP}" = "y" ]
then
        exec ${ENDIR}/sadc -F -L ${SADC_OPTIONS} -C "LINUX SLEEP MODE ($*)" ${SA_DIR}
elif [ $# = 0 ] && [ "${BOOT}" = "n" ]
then
# Note: Stats are written at the end of previous file *and* at the
# beginning of the new one (when there is a file rotation) only if
# outfile has not been explicitly specified on the command line...
        exec ${ENDIR}/sadc -F -L ${SADC_OPTIONS} 1 1 ${SA_DIR}
else
        exec ${ENDIR}/sadc -F -L ${SADC_OPTIONS} $* ${SA_DIR}
fi
```

## 12- Use sadc

System activity data collector.

`-F`

The creattion of outfile will be forced. If the file already exists and has a format unknown to sadc then it will be truncated.

`-L`

sadc will try to get an exclusive lock on the outfile before writing to it or truncating it. Failure to get the lock is fatal, except in the case of trying to write a normal (i.e. not a dummy and not a header) record to an existing file, in ally, the only reason a lock would fail would be if another sadc process were also writing to the file.

> wait I can execute sadc anyway, its perm is read-execute to everyone.
>
> wait no, sadc is the backend binary file, so is it a pipebomb? do I need to reverse shell it?


sa2
```
bandit21@bandit:~$ cat /usr/lib/sysstat/sa2
#!/bin/sh
# /usr/lib/sysstat/sa2
# (C) 1999-2020 Sebastien Godard (sysstat <at> orange.fr)
#
#@(#) sysstat-12.5.2
#@(#) sa2: Write a daily report
#
S_TIME_FORMAT=ISO ; export S_TIME_FORMAT
prefix=/usr
exec_prefix=${prefix}
SA_DIR=/var/log/sysstat
SYSCONFIG_DIR=/etc/sysstat
SYSCONFIG_FILE=sysstat
HISTORY=7
COMPRESSAFTER=10
ZIP="xz"
UMASK=0022
ENDIR=
DELAY_RANGE=0

# Read configuration file, overriding variables set above
[ -r ${SYSCONFIG_DIR}/${SYSCONFIG_FILE} ] && . ${SYSCONFIG_DIR}/${SYSCONFIG_FILE}

umask ${UMASK}

# Wait for a random delay if requested
if [ ${DELAY_RANGE} -gt 0 ]
then
        RANDOM=$$
        DELAY=$((${RANDOM}%${DELAY_RANGE}))
        sleep ${DELAY}
fi

[ -d ${SA_DIR} ] || SA_DIR=/var/log/sysstat

# if YESTERDAY=no then today's summary is generated
if [ x$YESTERDAY = xno ]
then
        DATE_OPTS=
else
        DATE_OPTS="--date=yesterday"
fi

if [ ${HISTORY} -gt 28 ]
then
        DATE=`date ${DATE_OPTS} +%Y%m%d`
else
        DATE=`date ${DATE_OPTS} +%d`
fi
CURRENTFILE=sa${DATE}
CURRENTRPT=sar${DATE}

RPT=${SA_DIR}/${CURRENTRPT}
DFILE=${SA_DIR}/${CURRENTFILE}
if [ -z "${ENDIR}" ];
then
       ENDIR=${exec_prefix}/bin
fi

[ -f "${DFILE}" ] || exit 0
cd ${ENDIR}
if [ x${REPORTS} != xfalse ]
then
        ${ENDIR}/sar.sysstat "$@" -f ${DFILE} > ${RPT}
fi

SAFILES_REGEX='/sar?[0-9]{2,8}(\.(Z|gz|bz2|xz|lz|lzo))?$'

find "${SA_DIR}" -type f -mtime +${HISTORY} \
        | egrep "${SAFILES_REGEX}" \
        | xargs   rm -f

UNCOMPRESSED_SAFILES_REGEX='/sar?[0-9]{2,8}$'

find "${SA_DIR}" -type f -mtime +${COMPRESSAFTER} \
        | egrep "${UNCOMPRESSED_SAFILES_REGEX}" \
        | xargs -r "${ZIP}" > /dev/null

exit 0
```

The config files here
```
bandit21@bandit:/usr/lib/sysstat$ cat /etc/sysstat/sysstat
# sysstat configuration file. See sysstat(5) manual page.

# How long to keep log files (in days).
# Used by sa2(8) script
# If value is greater than 28, then use sadc's option -D to prevent older
# data files from being overwritten. See sadc(8) and sysstat(5) manual pages.
HISTORY=7

# Compress (using xz, gzip or bzip2) sa and sar files older than (in days):
COMPRESSAFTER=10

# Parameters for the system activity data collector (see sadc(8) manual page)
# which are used for the generation of log files.
# By default contains the `-S DISK' option responsible for generating disk
# statisitcs. Use `-S XALL' to collect all available statistics.
SADC_OPTIONS="-S DISK"

# Directory where sa and sar files are saved. The directory must exist.
SA_DIR=/var/log/sysstat

# Compression program to use.
ZIP="xz"

# By default sa2 script generates yesterday's summary, since the cron job
# usually runs right after midnight. If you want sa2 to generate the summary
# of the same day (for example when cron job runs at 23:53) set this variable.
#YESTERDAY=no

# By default sa2 script generates reports files (the so called sarDD files).
# Set this variable to false to disable reports generation.
#REPORTS=false

# Tell sa2 to wait for a random delay in the range 0 .. ${DELAY_RANGE} before
# executing. This delay is expressed in seconds, and is aimed at preventing
# a massive I/O burst at the same time on VM sharing the same storage area.
# Set this variable to 0 to make sa2 generate reports files immediately.
DELAY_RANGE=0

# The sa1 and sa2 scripts generate system activity data and report files in
# the /var/log/sysstat directory. By default the files are created with umask 0022
# and are therefore readable for all users. Change this variable to restrict
# the permissions on the files (e.g. use 0027 to adhere to more strict
# security standards).
UMASK=0022
```

wait, if I LEARN what these shell scripts are in order to solve the puzzle, I can gain some knowledge about shell script and write one of my own. pog


what the actual fuck are these?? if I can't pass commands into the sysstat executable, what the heck am I supposed to do with these?