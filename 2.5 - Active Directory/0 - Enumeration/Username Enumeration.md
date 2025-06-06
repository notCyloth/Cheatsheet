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
