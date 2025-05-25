SUID = Set-User-ID

Capability = Granular control over certain permissions i.e. can the file access raw netsockets? Set uids?
# Enumerate 
## Enumerate SUID's
```bash
find / -perm -u=s -type f 2>/dev/null
```
## Enumerate capabilities
```bash
/usr/sbin/getcap -r / 2>/dev/null
```
Pay particular attention to cap_setuid+ep perms. 

+ep = effective and permitted
# Exploiting SUID's or Capabilities
https://gtfobins.github.io/
# PwnKit
If pkexec is < version 0.120, it is vulnerable to pwnkit.
```bash
pkexec --version
```
https://github.com/arthepsy/CVE-2021-4034
