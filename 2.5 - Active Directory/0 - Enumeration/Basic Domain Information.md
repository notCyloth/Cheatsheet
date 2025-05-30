Run as many tools/recon via RDP directly as possible. Otherwise the tooling could fail because of the kerberos double hop issue.
```batch
net user /domain
```
Enumerate all users! Particularly ones with admin pre/suffix in their name. Pay attention to groups they belong to such as Domain Admins.
```batch
net user $(USER) /domain
```
Enumerate groups in the domain:
```batch
net group /domain
```
Enumerate specific groups:
```batch
net group "$(GROUP_NAME)" /domain
```
# Enumerate SPN's
When applications like Exchange, MS SQL, or Internet Information Services (IIS) are integrated into AD, a unique service instance identifier known as Service Principal Name (SPN) associates a service to a specific service account in Active Directory.
## setspn.exe
Installed on windows by default.
```batch
setspn -L $(SPN_Account)
```
## Powerview
```powershell
Get-NetUser -SPN | select samaccountname,serviceprincipalname
```
## nslookup
```batch
nslookup.exe web04.corp.com
```
