# Kernel
```bash
uname -r
```
```
<insert kernel version here>
```
# Current User Groups
```bash
id
```
# Services
```bash
ps aux
```
```
<insert services here>
```
# Users
```bash
cat /home
```
```
<insert home directories here>
```
```bash
cat /etc/passwd
```
```
<insert /etc/passwd here>
```
# History
```bash
cat ~/.bash_history
```
```
<insert bash history here>
```
# List Sudo Permissions
```bash
sudo -l
```
```
<insert sudo permissions here>
```

# SUIDs
```bash
find / -type f -perm /4000 2>/dev/null
```
```
<insert suid files here>
```

# Cronjobs
```bash
cat /etc/crontab
```
```
<insert cronjobs here>
```

# Linpeas
```bash
wget https://github.com/carlospolop/PEASS-ng/releases/download/2021.02.20/linpeas.sh
chmod +x linpeas.sh
./linpeas.sh
```
```
<insert linpeas output here>
```
