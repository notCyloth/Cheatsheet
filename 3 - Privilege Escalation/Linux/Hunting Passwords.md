# Searching for passwords in files
```bash
grep --color=auto -rnw '/' -ie "PASSWORD" --color=always 2>/dev/null
```
```bash
grep --color=auto -rnw '/' -ie "PASSWORD=" --color=always 2>/dev/null
```
```bash
grep --color=auto -rnw '/' -ie "PASSWORD:" --color=always 2>/dev/null
```
# Searching for password files
```bash
locate password
```
```bash
locate pass
```
# Searching for SSH keys
```bash
find / -name authorized_keys 2>/dev/null
```
```bash
find / -name id_rsa 2>/dev/null
```
