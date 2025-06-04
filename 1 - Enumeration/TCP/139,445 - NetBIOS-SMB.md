SMB is a fileshare. Think shared Z: Drive at work.

# Enumerating SMB
## nmap
```bash
nmap -v -p 139,445 -oG smb.txt [IP_RANGE] # e.g. 192.168.50.1-254
```
```bash
grep open smb.txt | cut -d " " -f 2
```
```bash
nmap -v -p 139,445 --script smb-os-discovery [IP_ADDRESS]
```
## nbtscan
```bash
sudo nbtscan -r [IP/SUBNET] # e.g. 192.168.50.0/24
```
## Enumerating off Windows (Living off the Land)
net view lists domains, resources and computers belonging to a given host. 

Example listing all shares running on dc01:
```batch
net view \\dc01 /all
```
# Look for SMB Version
Metasploit has scanning/enum tools for smb.
```
msfconsole
```
```
use auxiliary/scanner/smb/smb_version
```
## enum4linux
This will apply all enumeration options:
```bash
enum4linux -a ($IP_ADDRESS)
```
How to loop enum4linux for multiple IP's...
```bash
for ip in $(cat smb_hosts.txt); do enum4linux -a $ip; done
```
# How to Connect
## smbclient
This will attempt to list shares with anonymous access. If prompted for a root password, just enter nothing:
```bash
smbclient -L \\\\$(IP_ADDRESS)\\
```
List specific chares content:
```bash
smbclient -L \\\\$(IP_ADDRESS)\\$SHARE
```
