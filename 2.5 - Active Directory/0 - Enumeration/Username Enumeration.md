Good username list: https://github.com/insidetrust/statistically-likely-usernames
# lookupsid
```bash
impacket-lookupsid cicada.htb/guest:''@10.10.11.35
```
# Kerbrute
```bash
./kerbrute_linux_amd64 userenum -d EGOTISTICAL-BANK.LOCAL /usr/share/seclists/Usernames/xato-net-10-million-usernames.txt --dc 10.10.10.175
```
If pre-auth isn't required, a hash will be dumped - refer to AS-REP roasting to crack.

### NOTE: Grab the hash with impacket even if you get the hash on kerbrute - they dump from different places and the kerbrute one may be invalid.
# Use SMB Null Session
## Obtain valid list of usernames via rpcclient
```bash
rpcclient -U "" -N 1.2.3.4
```
```bash
enumdomusers
```
## Obtain list of valid usernames via enum4linux
```bash
enum4linux -U $(IP_ADDRESS) | grep "user:" | cut -f2 -d"[" | cut -f1 -d"]"
```
## Obtain list of valid usernames via NetExec
```bash
nxc smb $(IP_ADDRESS) --users
```
# Use Anonymous LDAP Access
## Obtain list of valid usernames via ldapsearch
In this command, it's attacking IP 1.2.3.4 on domain.local
```bash
ldapsearch -h 1.2.3.4 -x -b "DC=domain,DC=local" -s sub "(&(objectclass=user))" | grep sAMAccountName: | cut -f2 -d " " 
```
## Obtain list of valid usernames via windapsearch
In this command, it's attacking IP 1.2.3.4 on domain.local
```bash
./windapsearch.py --dc-ip 1.2.3.4 -u "" -U
```
