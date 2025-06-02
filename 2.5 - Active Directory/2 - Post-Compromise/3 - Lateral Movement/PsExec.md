PsExec is part of microsoft sysinternals. Three requirements for this to work for lateral movement:
* The user that authenticates to the target machine needs to be part of the Administrators local group.
* The ADMIN$ share must be available. (This is default on Windows Servers).
* File and Printer Sharing has to be turned on. (This is default on Windows Servers).

```batch
.\PsExec64.exe -i  \\$(TARGET_HOSTNAME) -u $(DOMAIN)\$(USER) -p $(PASSWORD) cmd
```
