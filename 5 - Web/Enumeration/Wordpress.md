If wappalyzer or whatweb shows wordpress - check for cve's to the current version!
Also use WPScan:
# WPScan
```bash
wpscan --url [URL] --detection-mode [mixed/passive/aggressive]
```
Goto command to enumerate plugins:
```bash
wpscan --url http://$IP_ADDRESS --enumerate p --plugins-detection aggressive -o wpscan
```
