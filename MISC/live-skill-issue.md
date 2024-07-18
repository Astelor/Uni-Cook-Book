# Live skill issue

> this is a scribbler and an attempt to fix my massive skill issue.

(Put the equation below in [desmos](https://www.desmos.com/calculator) for the funnies.)

$$2.8x^2(x^2(2.5x^2+y^2-2)+1.2y^2(y(3y-0.75)-6.0311)+3.09)+0.98y^2((y^2-3.01)y^2+3)-1.005=0$$

# /etc/passwd

> I've seen the file too many times and I still don't understand it.

Source: https://linuxize.com/post/etc-passwd-file/

```
mark:x:1001:1001:mark,,,:/home/mark:/bin/bash
[--] - [--] [--] [-----] [--------] [--------]
|    |   |    |     |         |        |
|    |   |    |     |         |        +-> 7. Login shell
|    |   |    |     |         +----------> 6. Home directory
|    |   |    |     +--------------------> 5. GECOS
|    |   |    +--------------------------> 4. GID
|    |   +-------------------------------> 3. UID
|    +-----------------------------------> 2. Password
+----------------------------------------> 1. Username

```

> So it encourages you to be paranoid as a system admin?

# Access control list (ACL)

A list of permissions attached to an object.

Used where the traditional file permission concept does not suffice.

- ✅ Granting different levels of access to different users, groups, and processes.

## ACL commands

- `getfacl`: get file access control list
- `setfacl`: set file access control list

References: https://www.redhat.com/sysadmin/linux-access-control-lists


The fuck is partition and the commands