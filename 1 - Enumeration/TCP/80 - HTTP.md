
# Nikto
```bash
nikto -h http://$IP_ADDRESS
```
```
<insert nikto output here>
```
# DirBuster (Directory Bruteforce)
```bash
dirbuster -u http://$IP_ADDRESS -l /usr/share/dirb/wordlists/common.txt
```
```
<insert dirbuster output here>
```
# Wappalyzer (Web Technology Fingerprinting)
```bash
wappalyzer http://$IP_ADDRESS
```
```
<insert wappalyzer output here>
```
# Sitemaps
## robots.txt
```bash
curl http://$IP_ADDRESS/robots.txt
```
```
<insert robots.txt output here>
```
## sitemap.xml
```bash
curl http://$IP_ADDRESS/sitemap.xml
```
```
<insert sitemap.xml output here>
```
# WPScan (WordPress Enumeration)
```bash
wpscan --url http://$IP_ADDRESS --enumerate p --plugins-detection aggressive -o wpscan
```
```
<insert wpscan output here>
```
# Page Source Inspection
```bash
curl http://$IP_ADDRESS
```
```
<insert page source here>
```
