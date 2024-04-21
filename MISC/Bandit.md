# Bandit

My notes on a wargame called Bandit.

> Spoilers! 
> **If you somehow find this file, and you're not Astelor, please kindly frick off :)**
>
> Astelor: This file is intended to be my own writeup. I'm just learning linux terminal. 
> Astelor: I don't intend this file to be github-markdown friendly, but it's written with markdown stylers. 

0~5's passwords are easliy found with simple linux file discovery commands. 

bandit.labs.overthewire.org:2220

# Bandit5

> password: lrIWWI6bB37kxfiCQZqUdOIYfr6eEeqR

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

> password: P4L4vucdmLnm8I7Vl7jG1ApGSfjYKqJU

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
> find / -type f -size 33c -user bandit7 -group bandit6 2>/dev/null | cat

It now gives you the desired file directory. 

# Bandit7

> password: z7WtoNQU2XfjmMtWA8u5rN4vzqu4v99S

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

> password: TESKZC0XvTetK0S9xNwm25STk5iWrBvP

```
Puzzle:
"the only line of text that occurs only once"
```

Do I need to write a script? 
I guess I can count the number of each entries?

[Piping and Redirection](https://ryanstutorials.net/linuxtutorial/piping.php)


> Command crafting...
> 