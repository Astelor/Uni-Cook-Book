# Linux Command Book

I keep forgetting important linux commands, it's annoying.
Should I include tools to another section?

> Astelor: understand the effects of the commands and use them responsibly, can perhaps keep me out of trouble. please use it within your own network or a HTB machine before understanding fully.

You can find the details of each commands using `man <command name>` or `<command name> --help`
You can find detailed information at https://www.gnu.org/software/ or the developers' website of choice

# Enumeration

## Nmap 

[The official Nmap Project guide to Network Discovery and Security Scanning](https://nmap.org/book/toc.html)
> "Nmap (“Network Mapper”) is an open source tool for network exploration and security auditing."

```bash
nmap -sC -sV -oA <directory>/<filename> <target IP address>
```

- -sC : (Script Scan)  
  - equivalent to --script=default
- -sV : (Service/Version Detection) 
  - probe open ports to determine service/version info
- -oA : (Output) 
  - output in the three major formats at once 
  - formats: gnmap, nmap, xml

- you can specify ports or addresses to avoid probing unauthorized area.

# Documentation

## Man (Manual Pager utils)
> an interface to the system reference manuals

```
man <tool>
```

## Info (GNU Info System)

```
info <tool>
```

# File Handling

## Touch

```
Usage: touch [OPTION]... FILE...
Update the access and modification times of each FILE to the current time.
```

- can create empty file with arbitrary file name

## Mv

```
Usage: mv [OPTION]... [-T] SOURCE DEST
  or:  mv [OPTION]... SOURCE... DIRECTORY
  or:  mv [OPTION]... -t DIRECTORY SOURCE...
Rename SOURCE to DEST, or move SOURCE(s) to DIRECTORY.
```
- rename file names `mv <name 1> <name 2>`

## Mkdir

> Create the directory, if they do not ex

## Rm (remove)

# Text Editing
> Editing text in a terminal

## Nano
very beginner friendly :>

## Vi/Vim

classic text editor wih powerful configs

https://www.vim.org/docs.php

```
vi  <filename>
vim <filename>
```

- use `:help` in the vim command window to see help.txt
- `:q` to quit `:q!` to quit without saving

# Misc

> Write first, organize later, here.

## Gcc (GNU project C and C++ compiler)

## WHOIS

- who's this public address? (linux/unix)

```
whois <IP_address>
```

https://whois.domaintools.com/

"It's a query response protocol that is used for querying databases that store an internet resource's registered users or assignees. These resources include domain names, IP address blocks and autonomous systems, but it is also used for a wider range of other information."

[WHOIS Protocol Specification: RFC3912](https://datatracker.ietf.org/doc/html/rfc3912)

## Unix Terminal

### Redirection (`>` or `>>`)

The `>` operator overwrites the content of the file if it already exists. If you want to append text to an existing file, you can use the `>>` operator.

```bash
echo "this is a test message" > test
```

The the command creates a file named `test` with the content `this is a test message inside`

```bash
echo "appended text" >> test
```

now the file `test` will have

```
this is a test message
appended text
```

## ifconfig

> Configure a network interface

