Programs that can run sudo can be exploited
# Enumeration
```bash
sudo -l
```
# Exploitation
https://gtfobins.github.io/
## Troubleshooting
If there is a permission denied error, the payload was probably blocked by AppArmor (enabled by default on Debian 10+).
```bash
cat /var/log/syslog | grep $(ATTEMPTED_SUDO_PROGRAM)
```
