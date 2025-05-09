secretsdump.py [DOMAIN]/[USERNAME]:'[PASSWORD]'@[IP_ADDRESS] -just-dc-ntlm
Grab the NT to crack.

Crack all NTDS.dit NT hashes
Copy the full NTDS.dit and paste it all into excel.
In excel, goto Data > Text to Columns > Delimited > Next > Delimiters - Other: ":" > Next > Finish.
This will split the NTDS.dit into the following columns: Users, rID, LM hash, NT hash
Copy all the NT hashes.
Create a file with all the hashes pasted.
hashcat -m 1000 hashes.txt /usr/share/wordlists/rockyou.txt
hashcat -m 1000 hashes.txt /usr/share/wordlists/rockyou.txt --show
Copy the output and paste it on a new excel sheet. 
Highlight the cracked passwords column, then select Home > Numbers > Dropdown menu that says "General", and change it to "Text".
Go back to the first sheet (that stores the full NTDS.dit) and select the first box in the next column.
Type into the box "=vlookup([CLICK A HASH VALUE], [CLICK BOTH COLUMNS ON THE OTHER EXCEL SHEET], 2, false" 
Double click the corner of the vlookup box so that it looks up all the hashes.


# NOTE TO SELF - NEED TO FORMAT
