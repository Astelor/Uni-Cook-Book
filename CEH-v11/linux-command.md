I keep forgetting important linux commands, it's annoying.
Should I include tools to another section?
> Astelor: understand the effects of the commands and use them responsibly, can perhaps keep me out of trouble. please use it within your own network or a HTB machine before understanding fully.

You can find the details of each commands using `man <command name>` or `<command name> --help`
You can find detailed information at https://www.gnu.org/software/ or the developers' website of choice

# Enumeration
## Nmap
https://nmap.org/

> "Nmap (“Network Mapper”) is an open source tool for network exploration and security auditing."

```
nmap -sC -sV -oA <directory>/<filename> <target IP address>
```
you can specify ports or addresses to avoid probing unauthorized area.

# Documentation

## Man (Manual Pages)

## Info (GNU Info System)

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

## Rm (remove)

# Text Editing

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
Write first, organize later, here.
## Gcc (GNU project C and C++ compiler)

