### Note: Remember to enumerate nested groups (i.e. groups within groups!).
Powershell script to dynamically enumerate the LDAP path of a domain with low privileges:
```powershell
function LDAPSearch {
    param (
        [string]$LDAPQuery
    )

    $PDC = [System.DirectoryServices.ActiveDirectory.Domain]::GetCurrentDomain().PdcRoleOwner.Name
    $DistinguishedName = ([adsi]'').distinguishedName

    $DirectoryEntry = New-Object System.DirectoryServices.DirectoryEntry("LDAP://$PDC/$DistinguishedName")

    $DirectorySearcher = New-Object System.DirectoryServices.DirectorySearcher($DirectoryEntry, $LDAPQuery)

    return $DirectorySearcher.FindAll()

}
```
```powershell
powershell -ep bypass
```
```powershell
Import-Module .\function.ps1
```
## Search all users:
```powershell
LDAPSearch -LDAPQuery "(samAccountType=805306368)"
```
## Enumerate a specific user:
```powershell
$user = LDAPSearch -LDAPQuery "(&(objectCategory=user)(cn=michelle))"
```
```powershell
$user
```
### Enumerate individual attributes of user
```powershell
$user.properties.description
```
## Search all groups:
```powershell
foreach ($group in $(LDAPSearch -LDAPQuery "(objectCategory=group)")) {
$group.properties | select {$_.cn}, {$_.member}
}
```
## Enumerate a specific group:
```powershell
$sales = LDAPSearch -LDAPQuery "(&(objectCategory=group)(cn=Sales Department))"
```
```powershell
$sales.properties.member
```
