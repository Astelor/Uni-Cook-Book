# HTB GreenHorn


# Recon

## NMAP

```bash
# Nmap 7.94SVN scan initiated Mon Aug 19 09:09:03 2024 as: nmap -sC -sV -vv -oA nmap/GreenHorn 10.10.11.25
Nmap scan report for 10.10.11.25
Host is up, received syn-ack (0.080s latency).
Scanned at 2024-08-19 09:09:05 BST for 102s
Not shown: 997 closed tcp ports (conn-refused)
PORT     STATE SERVICE REASON  VERSION
22/tcp   open  ssh     syn-ack OpenSSH 8.9p1 Ubuntu 3ubuntu0.10 (Ubuntu Linux; protocol 2.0)
| ssh-hostkey: 
|   256 57:d6:92:8a:72:44:84:17:29:eb:5c:c9:63:6a:fe:fd (ECDSA)
| ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBOp+cK9ugCW282Gw6Rqe+Yz+5fOGcZzYi8cmlGmFdFAjI1347tnkKumDGK1qJnJ1hj68bmzOONz/x1CMeZjnKMw=
|   256 40:ea:17:b1:b6:c5:3f:42:56:67:4a:3c:ee:75:23:2f (ED25519)
|_ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEZQbCc8u6r2CVboxEesTZTMmZnMuEidK9zNjkD2RGEv
80/tcp   open  http    syn-ack nginx 1.18.0 (Ubuntu)
|_http-title: Did not follow redirect to http://greenhorn.htb/
| http-methods: 
|_  Supported Methods: GET HEAD POST OPTIONS
|_http-server-header: nginx/1.18.0 (Ubuntu)
3000/tcp open  ppp?    syn-ack
| fingerprint-strings: 
|   GenericLines, Help, RTSPRequest: 
|     HTTP/1.1 400 Bad Request
|     Content-Type: text/plain; charset=utf-8
|     Connection: close
|     Request
|   GetRequest: 
|     HTTP/1.0 200 OK
|     Cache-Control: max-age=0, private, must-revalidate, no-transform
|     Content-Type: text/html; charset=utf-8
|     Set-Cookie: i_like_gitea=103460eb8538f271; Path=/; HttpOnly; SameSite=Lax
|     Set-Cookie: _csrf=snxMxDFl_v0rX9OG2yh7WlLI1J86MTcyNDA1NDM5NzAxMzU0NTQyNA; Path=/; Max-Age=86400; HttpOnly; SameSite=Lax
|     X-Frame-Options: SAMEORIGIN
|     Date: Mon, 19 Aug 2024 07:59:57 GMT
|     <!DOCTYPE html>
|     <html lang="en-US" class="theme-auto">
|     <head>
|     <meta name="viewport" content="width=device-width, initial-scale=1">
|     <title>GreenHorn</title>
|     <link rel="manifest" href="data:application/json;base64,eyJuYW1lIjoiR3JlZW5Ib3JuIiwic2hvcnRfbmFtZSI6IkdyZWVuSG9ybiIsInN0YXJ0X3VybCI6Imh0dHA6Ly9ncmVlbmhvcm4uaHRiOjMwMDAvIiwiaWNvbnMiOlt7InNyYyI6Imh0dHA6Ly9ncmVlbmhvcm4uaHRiOjMwMDAvYXNzZXRzL2ltZy9sb2dvLnBuZyIsInR5cGUiOiJpbWFnZS9wbmciLCJzaXplcyI6IjUxMng1MTIifSx7InNyYyI6Imh0dHA6Ly9ncmVlbmhvcm4uaHRiOjMwMDAvYX
|   HTTPOptions: 
|     HTTP/1.0 405 Method Not Allowed
|     Allow: HEAD
|     Allow: HEAD
|     Allow: GET
|     Cache-Control: max-age=0, private, must-revalidate, no-transform
|     Set-Cookie: i_like_gitea=ff9835a40ae51ef8; Path=/; HttpOnly; SameSite=Lax
|     Set-Cookie: _csrf=6rDmMtAYbkOBBdXKXFQw9z88UFU6MTcyNDA1NDQwMjc1NzY4NzYyNQ; Path=/; Max-Age=86400; HttpOnly; SameSite=Lax
|     X-Frame-Options: SAMEORIGIN
|     Date: Mon, 19 Aug 2024 08:00:02 GMT
|_    Content-Length: 0
1 service unrecognized despite returning data. If you know the service/version, please submit the following fingerprint at https://nmap.org/cgi-bin/submit.cgi?new-service :

...

Service detection performed. Please report any incorrect results at https://nmap.org/submit/ .
# Nmap done at Mon Aug 19 09:10:47 2024 -- 1 IP address (1 host up) scanned in 103.78 seconds
```

- http server
- unknown service at port 3000

## FFUF

Directory fuzzing:
- nothing interesting

```bash
$ffuf -w /usr/share/wordlists/dirb/big.txt -u http://greenhorn.htb/FUZZ -fl 1

        /'___\  /'___\           /'___\       
       /\ \__/ /\ \__/  __  __  /\ \__/       
       \ \ ,__\\ \ ,__\/\ \/\ \ \ \ ,__\      
        \ \ \_/ \ \ \_/\ \ \_\ \ \ \ \_/      
         \ \_\   \ \_\  \ \____/  \ \_\       
          \/_/    \/_/   \/___/    \/_/       

       v2.1.0-dev
________________________________________________

 :: Method           : GET
 :: URL              : http://greenhorn.htb/FUZZ
 :: Wordlist         : FUZZ: /usr/share/wordlists/dirb/big.txt
 :: Follow redirects : false
 :: Calibration      : false
 :: Timeout          : 10
 :: Threads          : 40
 :: Matcher          : Response status: 200-299,301,302,307,401,403,405,500
 :: Filter           : Response lines: 1
________________________________________________

data                    [Status: 301, Size: 178, Words: 6, Lines: 8, Duration: 54ms]
docs                    [Status: 301, Size: 178, Words: 6, Lines: 8, Duration: 88ms]
files                   [Status: 301, Size: 178, Words: 6, Lines: 8, Duration: 54ms]
images                  [Status: 301, Size: 178, Words: 6, Lines: 8, Duration: 59ms]
robots.txt              [Status: 200, Size: 47, Words: 4, Lines: 3, Duration: 64ms]
:: Progress: [20469/20469] :: Job [1/1] :: 628 req/sec :: Duration: [0:00:59] :: Errors: 0 ::
```

Domain fuzzing gave nothing

## Service Hosted

http://greenhorn.htb/login.php

- Admin login page
- Gives the service version `pluck 4.7.18`
- The login has wrong password timeout, potentially no brute-forcing.

Apparently this service version is vulnerable to RCE

https://nvd.nist.gov/vuln/detail/CVE-2023-50564

https://www.exploit-db.com/exploits/51592
