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
searchsploit --nmap $1/nmap/aggressiveTCP/aggressiveTCP.xml > $1/searchsploit/searchsploit.results
echo "[!] Searchsploit finished. Results at: $(pwd)/$1/searchsploit/searchsploitTCP.results"

# START SLOWALLPORT SCAN
echo "[*] Starting slowallport scan."
nmap -p- $1 -oA $1/nmap/slowallport/slowallport -Pn -n >/dev/null
echo "[!] slowallport scan complete. Results at: $(pwd)/$1/nmap/slowallport"
grep "Ports:" $1/nmap/slowallport/slowallport.gnmap | sed 's/.*Ports: //' | tr ',' '\n' | grep "/open/" | awk -F'/' '{gsub(/ /,"",$1); print $1}' | sort -n | uniq | paste -sd',' - > $1/nmap/slowallports.csv

# DIFF SLOW vs FAST FULL PORT SCAN - IF DIFFERENT, FEED SLOWFULLPORTSCAN INTO NEW AGGRESSIVETCP
echo "[*] Comparing slowallports.csv to fastallports.csv"

# FEED AGGRESSIVETCP SCAN INTO SEARCHSPLOIT

# RUN -F UDP SCAN

# RUN UDP PORT SCAN

# FEED UDP PORT SCAN INTO SEARCHSPLOIT

# RUN ALL UDP PORT SCAN
