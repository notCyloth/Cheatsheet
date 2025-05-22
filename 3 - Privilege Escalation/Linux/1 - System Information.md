# Operating system, version and architecture
```bash
cat /etc/issue
```
```bash
cat /etc/os-release
```
```bash
uname -r
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
# Network Information
```bash
ip a
```
```bash
route
```
Or
```bash
routel
```
...depending on distro.
```bash
ss -anp
```
## Firewall Rules
```bash
ls /etc/iptables
```
```bash
ls /etc | grep "ip"
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
```bash
ls -lah /etc/cron*
```
# Linpeas
```bash
wget https://github.com/carlospolop/PEASS-ng/releases/download/2021.02.20/linpeas.sh
chmod +x linpeas.sh
./linpeas.sh
```
