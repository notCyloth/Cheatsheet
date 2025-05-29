Run as many tools/recon via RDP directly as possible. Otherwise the tooling could fail because of the kerberos double hop issue.
```batch
net user /domain
```
Enumerate all users! Particularly ones with admin pre/suffix in their name. Pay attention to groups they belong to such as Domain Admins.
```batch
net user $(USER) /domain
```
Enumerate groups in the domain:
```batch
net group /domain
```
Enumerate specific groups:
```batch
net group "$(GROUP_NAME)" /domain
```
