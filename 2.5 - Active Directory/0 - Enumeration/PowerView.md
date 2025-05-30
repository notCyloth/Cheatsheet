Transfer powerview to target: https://github.com/PowerShellEmpire/PowerTools/blob/master/PowerView/powerview.ps1
```powershell
powershell -ep bypass
```
```powershell
Import-Module .\PowerView.ps1
```
# Basic Enumeration
```powershell
Get-NetDomain
```
## Get users on domain
```powershell
Get-NetUser
```
```powershell
Get-NetUser | select cn
```
```powershell
Get-NetUser | select cn,pwdlastset,lastlogon
```
### Get specific user details
```powershell
Get-NetUser fred
```
## Get groups on domain
```powershell
Get-NetGroup | select cn
```
### Get specific group members
```powershell
Get-NetGroup "Sales Department" | select member
```
## Enumerate domain-joined machines
```powershell
Get-NetComputer
```
```powershell
Get-NetComputer | select name,dnshostname,operatingsystem,operatingsystemversion
```
## Enumerate User Permissions
Check user to see if they have admin privileges on any domain machines:
```powershell
Find-LocalAdminAccess
```
## Enumerate Logged on Users
This will check a computer to see if there are any users currently logged in. Due to windows changing how to handles sessions, the API's running behind the hood may require admin:
```powershell
Get-NetSession -ComputerName files04 -Verbose
```
Alternatively, use sysinternals tool PsLoggedOn (https://learn.microsoft.com/en-us/sysinternals/downloads/psloggedon):
```powershell
.\PsLoggedon.exe \\client74
```
