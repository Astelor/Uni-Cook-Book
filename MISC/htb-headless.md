# Headless

# Enumeration

```
Starting Nmap 7.93 ( https://nmap.org ) at 2024-06-25 11:41 BST
Nmap scan report for 10.10.11.8
Host is up (0.053s latency).
Not shown: 998 closed tcp ports (conn-refused)
PORT     STATE SERVICE VERSION
22/tcp   open  ssh     OpenSSH 9.2p1 Debian 2+deb12u2 (protocol 2.0)
| ssh-hostkey: 
|   256 900294283dab2274df0ea3b20f2bc617 (ECDSA)
|_  256 2eb90824021b609460b384a99e1a60ca (ED25519)
5000/tcp open  upnp?
| fingerprint-strings: 
|   GetRequest: 
|     HTTP/1.1 200 OK
|     Server: Werkzeug/2.2.2 Python/3.11.2
|     Date: Tue, 25 Jun 2024 10:34:15 GMT
|     Content-Type: text/html; charset=utf-8
|     Content-Length: 2799
|     Set-Cookie: is_admin=InVzZXIi.uAlmXlTvm8vyihjNaPDWnvB_Zfs; Path=/
|     Connection: close
|     <!DOCTYPE html>
|     <html lang="en">
|     <head>
|     <meta charset="UTF-8">
|     <meta name="viewport" content="width=device-width, initial-scale=1.0">
|     <title>Under Construction</title>
|     <style>
|     body {
|     font-family: 'Arial', sans-serif;
|     background-color: #f7f7f7;
|     margin: 0;
|     padding: 0;
|     display: flex;
|     justify-content: center;
|     align-items: center;
|     height: 100vh;
|     .container {
|     text-align: center;
|     background-color: #fff;
|     border-radius: 10px;
|     box-shadow: 0px 0px 20px rgba(0, 0, 0, 0.2);
|   RTSPRequest: 
|     <!DOCTYPE HTML>
|     <html lang="en">
|     <head>
|     <meta charset="utf-8">
|     <title>Error response</title>
|     </head>
|     <body>
|     <h1>Error response</h1>
|     <p>Error code: 400</p>
|     <p>Message: Bad request version ('RTSP/1.0').</p>
|     <p>Error code explanation: 400 - Bad request syntax or unsupported method.</p>
|     </body>
|_    </html>
1 service unrecognized despite returning data. If you know the service/version, please submit the following fingerprint at https://nmap.org/cgi-bin/submit.cgi?new-service :
```
ffuf result
```
$ffuf -w "/usr/share/wordlists/dirb/big.txt" -u "http://10.10.11.8:5000/FUZZ"

        /'___\  /'___\           /'___\       
       /\ \__/ /\ \__/  __  __  /\ \__/       
       \ \ ,__\\ \ ,__\/\ \/\ \ \ \ ,__\      
        \ \ \_/ \ \ \_/\ \ \_\ \ \ \ \_/      
         \ \_\   \ \_\  \ \____/  \ \_\       
          \/_/    \/_/   \/___/    \/_/       

       v1.4.1-dev
________________________________________________

 :: Method           : GET
 :: URL              : http://10.10.11.8:5000/FUZZ
 :: Wordlist         : FUZZ: /usr/share/wordlists/dirb/big.txt
 :: Follow redirects : false
 :: Calibration      : false
 :: Timeout          : 10
 :: Threads          : 40
 :: Matcher          : Response status: 200,204,301,302,307,401,403,405,500
________________________________________________

dashboard               [Status: 500, Size: 265, Words: 33, Lines: 6, Duration: 53ms]
support                 [Status: 200, Size: 2363, Words: 836, Lines: 93, Duration: 53ms]
:: Progress: [20469/20469] :: Job [1/1] :: 354 req/sec :: Duration: [0:01:05] :: Errors: 0 ::
```

Let's see what in `dashboard`
```
curl --cookie "is_admin=InVzZXIi.uAlmXlTvm8vyihjNaPDWnvB_Zfs" -u admin:admin http://10.10.11.8:5000/dashboard -v 
*   Trying 10.10.11.8:5000...
* Connected to 10.10.11.8 (10.10.11.8) port 5000 (#0)
* Server auth using Basic with user 'admin'
> GET /dashboard HTTP/1.1
> Host: 10.10.11.8:5000
> Authorization: Basic YWRtaW46YWRtaW4=
> User-Agent: curl/7.88.1
> Accept: */*
> Cookie: is_admin=InVzZXIi.uAlmXlTvm8vyihjNaPDWnvB_Zfs
> 
< HTTP/1.1 401 UNAUTHORIZED
< Server: Werkzeug/2.2.2 Python/3.11.2
< Date: Tue, 25 Jun 2024 11:58:23 GMT
< Content-Type: text/html; charset=utf-8
< Content-Length: 317
< Connection: close
< 
<!doctype html>
<html lang=en>
<title>401 Unauthorized</title>
<h1>Unauthorized</h1>
<p>The server could not verify that you are authorized to access the URL requested. You either supplied the wrong credentials (e.g. a bad password), or your browser doesn&#39;t understand how to supply the credentials required.</p>
* Closing connection 0
```

# Foothold

> So apparently cross-site scripting (XSS) can be used to steal cookies, and we need a admin cookie to access `dashboard`.

https://medium.com/@laur.telliskivi/pentesting-basics-cookie-grabber-xss-8b672e4738b2

https://www.tutorialspoint.com/What-is-the-difference-between-session-and-cookies#:~:text=Cookies%20are%20client%2Dside%20files,files%20that%20store%20user%20information.&text=Cookies%20expire%20after%20the%20user,logs%20out%20of%20the%20program.
