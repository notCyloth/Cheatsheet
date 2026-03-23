## LLMNR Poisoning 
Link Local Multicast Network Resolution

* Used to identify hosts when DNS fails to do so 
* Used to be known as NBT-NS

If a device fails to connect to the server, the server is going to send a request to all devices and say "Hey, who can connect to this server on the network" an attack can be sat in the middle and say "I know where this exists, send me your hash and i'll connect you". This ends up sending the attacker their password hash. 

We are going to use a tool called "Responder". 

LLMNR is very lively when people are logging in etc. 

So we're going to try and connect to a share that doesn't exist, or isn't valid. Responder is going to give us a hash that we can potentially crack. 

### How to use responder:
```bash
sudo responder -I eth0 -dwP 
```

-d : dhcp requests

-w : wpad rouge proxy server. 

-P : ProxyAuth - Force Authentication prompt

-v : verbose 

### How to use Inveigh
Inveigh is the Windows Equivalent of Responder.
#### PS Version
Note: This version is no longer maintained!
```powershell
Import-Module .\Inveigh.ps1
```
LLMNR and NBNS Spoofing:
```powershell
Invoke-Inveigh Y -NBNS Y -ConsoleOutput Y -FileOutput Y
```
#### C# Version
```
.\Inveigh.exe
```
You can also press Esc to enter the Inveigh console while it is running.
HELP command will give options.

## Cracking Hashes
```
hashcat -m 5600 ntlmv2_hash.txt /usr/share/wordlists/rockyou.txt
```
