# Host Information
## IP
```
<insert ip here>
```
## Web Domain
```
<insert domain here>
```
## Scans
### Nmap
#### Quick Scan
```bash
sudo nmap $IP_ADDRESS -oA nmap/quickscan
```
```
<insert quick scan output here>
```
#### Full Scan
```bash
sudo nmap -A -p- $IP_ADDRESS -oA nmap/fullscan
```
```
<insert full scan output here>
```
#### UDP Scan
```bash
sudo nmap -sU $IP_ADDRESS -oA nmap/udpscan
```
```
<insert udp scan output here>
```
### Searchsploit
```bash
searchsploit --nmap nmap/fullscan.xml > results.txt
```
```
<insert results here>
```
