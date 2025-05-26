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
## Local Port Forwarding
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
