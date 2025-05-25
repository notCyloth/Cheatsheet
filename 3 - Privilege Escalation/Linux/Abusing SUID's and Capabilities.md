SUID = Set-User-ID
Capability = Granular control over certain permissions i.e. can the file access raw netsockets? Set uids?
# Enumerate capabilities
```bash
/usr/sbin/getcap -r / 2>/dev/null
```
