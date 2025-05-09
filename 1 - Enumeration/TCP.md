# TCP

## 22 - SSH
### ssh-audit
```bash
ssh-audit.py $IP_ADDRESS
```
```
<insert ssh-audit output here>
```
### Hydra (Brute Force SSH Login)
```bash
hydra -l $USERNAME -P /usr/share/wordlists/rockyou.txt ssh://$IP_ADDRESS:$PORT -t 4 -V
```
```
<insert hydra output here>
```
### Password Spraying (if there’s a known password)
```bash
hydra -L /usr/share/wordlists/dirb/others/names.txt -p "$PASSWORD" ssh://$IP_ADDRESS
```
```
<insert hydra output here>
```

## 25 - SMTP
### Nmap SMTP Script Scan
```bash
nmap -p 25 --script smtp* $IP_ADDRESS
```
```
<insert nmap output here>
```
### Metasploit SMTP Enumeration
```bash
use auxiliary/scanner/smtp/smtp_version
set RHOSTS $IP_ADDRESS
run
```
```
<insert msfconsole output here>
```
### SMTP VRFY Command
```bash
telnet $IP_ADDRESS 25
VRFY <email_address>
```

## 80 - HTTP
### Nikto
```bash
nikto -h http://$IP_ADDRESS
```
```
<insert nikto output here>
```
### DirBuster (Directory Bruteforce)
```bash
dirbuster -u http://$IP_ADDRESS -l /usr/share/dirb/wordlists/common.txt
```
```
<insert dirbuster output here>
```
### Wappalyzer (Web Technology Fingerprinting)
```bash
wappalyzer http://$IP_ADDRESS
```
```
<insert wappalyzer output here>
```
### Sitemaps
#### robots.txt
```bash
curl http://$IP_ADDRESS/robots.txt
```
```
<insert robots.txt output here>
```
#### sitemap.xml
```bash
curl http://$IP_ADDRESS/sitemap.xml
```
```
<insert sitemap.xml output here>
```
### WPScan (WordPress Enumeration)
```bash
wpscan --url http://$IP_ADDRESS
```
```
<insert wpscan output here>
```
### Page Source Inspection
```bash
curl http://$IP_ADDRESS
```
```
<insert page source here>
```

## 139/445 - NetBIOS/SMB
### Enum4Linux (SMB Enumeration)
```bash
enum4linux -a $IP_ADDRESS
```
```
<insert enum4linux output here>
```
### Smbclient (SMB Share Discovery)
```bash
smbclient -L //$IP_ADDRESS -U guest
```
```
<insert smbclient output here>
```

## 3389 - RDP
### Hydra (RDP Brute Force)
```bash
hydra -l $USERNAME -P /usr/share/wordlists/rockyou.txt rdp://$IP_ADDRESS:$PORT -t 4 -V
```
```
<insert hydra output here>
```
### Password Spraying (if there’s a known password)
```bash
hydra -L /usr/share/wordlists/dirb/others/names.txt -p "$PASSWORD" rdp://$IP_ADDRESS
```
```
<insert hydra output here>
```
### Connecting to RDP
```bash
xfreerdp /u:[USERNAME] /p:[PASSWORD] /v:[WINDOWS IP]
```

## 53 - DNS
### DNS Zone Transfer (AXFR)
```bash
dig @<DNS_SERVER> $DOMAIN_NAME axfr
```
```
<insert zone transfer output here>
```
### DNS Recon (Subdomain Enumeration)
```bash
dnsrecon -d $DOMAIN_NAME
```
```
<insert dnsrecon output here>
```
