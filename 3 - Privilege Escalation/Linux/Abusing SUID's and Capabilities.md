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
# Exploiting SUID's or Capabilities
https://gtfobins.github.io/
