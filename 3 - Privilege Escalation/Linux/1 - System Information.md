Just use this: https://github.com/swisskyrepo/PayloadsAllTheThings/blob/master/Methodology%20and%20Resources/Linux%20-%20Privilege%20Escalation.md

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
List loaded kernel drivers:
```bash
lsmod
```
Display kernel driver info:
```bash
/sbin/modinfo $(KERNEL_NAME)
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
find / -perm -u=s -type f 2>/dev/null
```
# Cronjobs
```bash
crontab -l
```
```bash
sudo crontab -l
```
```bash
cat /etc/crontab
```
```bash
ls -lah /etc/cron*
```
# Enumerate installed packages
Debian:
```bash
dpkg -l
```
# Every writeable directory by current user
```bash
find / -writable -type d 2>/dev/null
```
# List mounted filesystems
List drives that will be mounted on boot:
```bash
cat /etc/fstab
```
List all mounted filesystems:
```bash
mount
```
List all available disks:
```bash
lsblk
```
# Linpeas
```bash
wget https://github.com/carlospolop/PEASS-ng/releases/download/2021.02.20/linpeas.sh
chmod +x linpeas.sh
./linpeas.sh
```
