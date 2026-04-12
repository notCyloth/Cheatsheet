#!/bin/bash

# Argument/Error Handling Section
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 
   exit 1
fi

if [ $# -eq 0 ] || [ -z "$1" ];
  then
    echo "No arguments supplied. i.e. ./enum.sh [IP ADDRESS]"
    exit 1
fi

if [ $# -gt 1 ];
  then
    echo "Extra arguments detected. i.e. ./enum.sh [IP ADDRESS]"
    exit 1
fi


echo "--------------------------------------------"
echo "[!] Consider updating nmap and searchsploit."
echo "--------------------------------------------"
echo "sudo apt upgrade -y nmap"
echo "sudo searchsploit -u"
echo "--------------------------------------------"

# Scans
echo "[*] Creating /nmap directory."
mkdir -p $1/nmap/top200
mkdir -p $1/nmap/fastallport
mkdir -p $1/nmap/slowallport
mkdir -p $1/nmap/aggressiveTCP
mkdir -p $1/nmap/fastUDP
mkdir -p $1/nmap/regUDP
mkdir -p $1/searchsploit

echo "[*] Starting top200 port scan."
nmap --top-ports=200 -Pn -n $1 -oA $1/nmap/top200/top200 -T5 --max-retries=2 >/dev/null
echo "[!] top200 port scan complete. Results at: $(pwd)/$1/nmap/top200"

echo "[*] Starting fastallport scan."
nmap -p- $1 -oA $1/nmap/fastallport/fastallport -Pn -n -T5 --max-retries=2 >/dev/null
echo "[!] fastallport scan complete. Results at: $(pwd)/$1/nmap/fastallport"

echo "[*] Feeding fastallport scan into aggressiveTCP scan..."
grep "Ports:" $1/nmap/fastallport/fastallport.gnmap | sed 's/.*Ports: //' | tr ',' '\n' | grep "/open/" | awk -F'/' '{gsub(/ /,"",$1); print $1}' | sort -n | uniq | paste -sd',' - > $1/nmap/fastallports.csv

nmap -p$(cat $1/nmap/fastallports.csv) -A $1 -oA $1/nmap/aggressiveTCP/aggressiveTCP >/dev/null
echo "[!] aggressiveTCP scan complete. Results at: $(pwd)/$1/nmap/aggressiveTCP"

echo "[*] Feeding aggressiveTCP to searchsploit..."
searchsploit --nmap $1/nmap/aggressiveTCP/aggressiveTCP.xml > $1/searchsploit/searchsploitTCP.results
echo "[!] Searchsploit finished. Results at: $(pwd)/$1/searchsploit/searchsploitTCP.results"

# START SLOWALLPORT SCAN
echo "[*] Starting slowallport scan."
nmap -p- $1 -oA $1/nmap/slowallport/slowallport -Pn -n >/dev/null
echo "[!] slowallport scan complete. Results at: $(pwd)/$1/nmap/slowallport"
grep "Ports:" $1/nmap/slowallport/slowallport.gnmap | sed 's/.*Ports: //' | tr ',' '\n' | grep "/open/" | awk -F'/' '{gsub(/ /,"",$1); print $1}' | sort -n | uniq | paste -sd',' - > $1/nmap/slowallports.csv

echo "[*] Comparing slowallports.csv to fastallports.csv"

if read -n1 -d '' < <(diff $1/nmap/fastallports.csv $1/nmap/slowallports.csv); 
  then 
    echo "[!] Differences between slow and fast all port scans detected..."
    echo "[*] Feeding slowallport scan into aggressiveTCP scan..."
    nmap -p$(cat $1/nmap/slowallports.csv) -A $1 -oA $1/nmap/aggressiveTCP/aggressiveTCP >/dev/null
    echo "[!] aggressiveTCP scan complete. Results at: $(pwd)/$1/nmap/aggressiveTCP"
    echo "[*] Feeding new aggressiveTCP to searchsploit..."
    searchsploit --nmap $1/nmap/aggressiveTCP/aggressiveTCP.xml > $1/searchsploit/searchsploitTCP.results
    echo "[!] Searchsploit finished. Results at: $(pwd)/$1/searchsploit/searchsploitTCP.results"
fi

echo "[*] Starting fastUDP scan."
nmap -F -sU $1 -oA $1/nmap/fastUDP/fastUDP
echo "[!] fastUDP scan complete. Results at: $(pwd)/$1/nmap/fastUDP"
grep "Ports:" $1/nmap/fastUDP/fastUDP.gnmap | sed 's/.*Ports: //' | tr ',' '\n' | grep "/open/" | awk -F'/' '{gsub(/ /,"",$1); print $1}' | sort -n | uniq | paste -sd',' - > $1/nmap/fastUDPports.csv

echo "[*] Feeding fastUDP to searchsploit..."
searchsploit --nmap $1/nmap/fastUDP/fastUDP.xml > $1/searchsploit/searchsploitUDP.results
echo "[!] Searchsploit finished. Results at: $(pwd)/$1/searchsploit/searchsploitUDP.results"

echo "[*] Starting regUDP scan."
nmap -sU $1 -oA $1/nmap/regUDP/regUDP
echo "[!] regUDP scan complete. Results at: $(pwd)/$1/nmap/regUDP"
grep "Ports:" $1/nmap/regUDP/regUDP.gnmap | sed 's/.*Ports: //' | tr ',' '\n' | grep "/open/" | awk -F'/' '{gsub(/ /,"",$1); print $1}' | sort -n | uniq | paste -sd',' - > $1/nmap/regUDPports.csv

if read -n1 -d '' < <(diff $1/nmap/regUDPports.csv $1/nmap/fastUDPports.csv); 
  then 
    echo "[!] Differences between regular and fast UDP port scans detected..."
    echo "[*] Feeding new regUDP scan to searchsploit..."
    searchsploit --nmap $1/nmap/regUDP/regUDP.xml > $1/searchsploit/searchsploitUDP.results
    echo "[!] Searchsploit finished. Results at: $(pwd)/$1/searchsploit/searchsploitTCP.results"
fi
