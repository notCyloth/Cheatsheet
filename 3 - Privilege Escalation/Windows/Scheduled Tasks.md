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
