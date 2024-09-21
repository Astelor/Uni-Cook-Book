# HTB Blurry

A medium level Linux machine.

# Recon

## NMAP

Info
- The machine is hosting a HTTP server on port 80
- It redirects to `app.blurry.htb`

Act
- Add the host name and ip to `/ect/hosts` so it resolves the domain name correctly
- Go to the site via a web browser

## SITE

Info
- It's hosting an application called `clearML`
- A search on the CVEs to `clearML`
	- CSRF https://nvd.nist.gov/vuln/detail/CVE-2024-24593
	- 

Huh?
- Maybe I can steal the credential?
- Or maybe it doesn't handle file uploading well?