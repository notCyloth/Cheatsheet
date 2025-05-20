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

