## gobuster
```bash
gobuster dns -d 192.168.154.199 -w /usr/share/wordlists/amass/all.txt -t 5
```
## AssetFinder
Requires go to be installed.
```bash
go get -u github.com/tomnomnom/assetfinder
```
```bash
assetfinder [WEBSITE]
```
e.g. assetfinder tesla.com > results.txt

--subs-only flag only searches for directly related subdomains...
## Amass
Requires go to be installed.
```bash
export GO111MODULE=on
```
```bash
go get -v -u github.com/OWASP/Amass/v3/...
```
```bash
amass enum -d [WEBSITE]
```
i.e.
```bash
amass enum -d tesla.com
```
## httprobe (this checks if domains are alive)
Requires go to be installed.
```
go install github.com/tomnomnom/httprobe@latest
```
```bash
cat [LIST OF SUBDOMAINS FILE] | httprobe | sed 's/https\?:\/\///' | sed 's/http\?:\/\///'  | tr -d ':443' | tr -d ':80'
```
## GoWitness (screenshots domains using headless chrome)
```bash
go get -u gorm.io/gorm # Requires Go (duh!)
```
```bash
go get -u github.com/sensepost/gowitness
```
```bash
gowitness single [WEBSITE]
```
e.g. 
```bash
gowtiness single https://tesla.com
```
# Bash script
Bash script combining multiple tools results:
```bash
#!/bin/bash	
url=$1
if [ ! -d "$url" ];then
	mkdir $url
fi
if [ ! -d "$url/recon" ];then
	mkdir $url/recon
fi
if [ ! -d '$url/recon/eyewitness' ];then
	mkdir $url/recon/eyewitness
fi
if [ ! -d "$url/recon/scans" ];then
	mkdir $url/recon/scans
fi
if [ ! -d "$url/recon/httprobe" ];then
	mkdir $url/recon/httprobe
fi
if [ ! -d "$url/recon/potential_takeovers" ];then
	mkdir $url/recon/potential_takeovers
fi
if [ ! -d "$url/recon/wayback" ];then
	mkdir $url/recon/wayback
fi
if [ ! -d "$url/recon/wayback/params" ];then
	mkdir $url/recon/wayback/params
fi
if [ ! -d "$url/recon/wayback/extensions" ];then
	mkdir $url/recon/wayback/extensions
fi
if [ ! -f "$url/recon/httprobe/alive.txt" ];then
	touch $url/recon/httprobe/alive.txt
fi
if [ ! -f "$url/recon/final.txt" ];then
	touch $url/recon/final.txt
fi
 
echo "[+] Harvesting subdomains with assetfinder..."
assetfinder $url >> $url/recon/assets.txt
cat $url/recon/assets.txt | grep $1 >> $url/recon/final.txt
rm $url/recon/assets.txt
 
echo "[+] Double checking for subdomains with amass..."
amass enum -d $url >> $url/recon/f.txt
sort -u $url/recon/f.txt >> $url/recon/final.txt
rm $url/recon/f.txt
 
echo "[+] Probing for alive domains..."
cat $url/recon/final.txt | sort -u | httprobe -s -p https:443 | sed 's/https\?:\/\///' | tr -d ':443' >> $url/recon/httprobe/a.txt
sort -u $url/recon/httprobe/a.txt > $url/recon/httprobe/alive.txt
rm $url/recon/httprobe/a.txt
 
echo "[+] Checking for possible subdomain takeover..."
 
if [ ! -f "$url/recon/potential_takeovers/potential_takeovers.txt" ];then
	touch $url/recon/potential_takeovers/potential_takeovers.txt
fi
 
subjack -w $url/recon/final.txt -t 100 -timeout 30 -ssl -c ~/go/src/github.com/haccer/subjack/fingerprints.json -v 3 -o $url/recon/potential_takeovers/potential_takeovers.txt
 
echo "[+] Scanning for open ports..."
nmap -iL $url/recon/httprobe/alive.txt -T4 -oA $url/recon/scans/scanned.txt
 
echo "[+] Scraping wayback data..."
cat $url/recon/final.txt | waybackurls >> $url/recon/wayback/wayback_output.txt
sort -u $url/recon/wayback/wayback_output.txt
 
echo "[+] Pulling and compiling all possible params found in wayback data..."
cat $url/recon/wayback/wayback_output.txt | grep '?*=' | cut -d '=' -f 1 | sort -u >> $url/recon/wayback/params/wayback_params.txt
for line in $(cat $url/recon/wayback/params/wayback_params.txt);do echo $line'=';done
 
echo "[+] Pulling and compiling js/php/aspx/jsp/json files from wayback output..."
for line in $(cat $url/recon/wayback/wayback_output.txt);do
	ext="${line##*.}"
	if [[ "$ext" == "js" ]]; then
		echo $line >> $url/recon/wayback/extensions/js1.txt
		sort -u $url/recon/wayback/extensions/js1.txt >> $url/recon/wayback/extensions/js.txt
	fi
	if [[ "$ext" == "html" ]];then
		echo $line >> $url/recon/wayback/extensions/jsp1.txt
		sort -u $url/recon/wayback/extensions/jsp1.txt >> $url/recon/wayback/extensions/jsp.txt
	fi
	if [[ "$ext" == "json" ]];then
		echo $line >> $url/recon/wayback/extensions/json1.txt
		sort -u $url/recon/wayback/extensions/json1.txt >> $url/recon/wayback/extensions/json.txt
	fi
	if [[ "$ext" == "php" ]];then
		echo $line >> $url/recon/wayback/extensions/php1.txt
		sort -u $url/recon/wayback/extensions/php1.txt >> $url/recon/wayback/extensions/php.txt
	fi
	if [[ "$ext" == "aspx" ]];then
		echo $line >> $url/recon/wayback/extensions/aspx1.txt
		sort -u $url/recon/wayback/extensions/aspx1.txt >> $url/recon/wayback/extensions/aspx.txt
	fi
done
 
rm $url/recon/wayback/extensions/js1.txt
rm $url/recon/wayback/extensions/jsp1.txt
rm $url/recon/wayback/extensions/json1.txt
rm $url/recon/wayback/extensions/php1.txt
rm $url/recon/wayback/extensions/aspx1.txt
echo "[+] Running eyewitness against all compiled domains..."
python3 EyeWitness/EyeWitness.py --web -f $url/recon/httprobe/alive.txt -d $url/recon/eyewitness --resolve
```
