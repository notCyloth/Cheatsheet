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
Get-NetComputer | select dnshostname,operatingsystem
```
