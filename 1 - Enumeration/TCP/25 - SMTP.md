# Nmap SMTP Script Scan
```bash
nmap -p 25 --script smtp* $IP_ADDRESS
```
```
<insert nmap output here>
```
# Metasploit SMTP Enumeration
```bash
use auxiliary/scanner/smtp/smtp_version
set RHOSTS $IP_ADDRESS
run
```
```
<insert msfconsole output here>
```
# SMTP VRFY Command
```bash
telnet $IP_ADDRESS 25
VRFY <email_address>
```
