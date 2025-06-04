# Nmap Fingerprinting
```bash
sudo nmap -p 80 -sV ($IP_ADDRESS)
```
```bash
sudo nmap -p 80 --script=http-enum ($IP_ADDRESS)
```
# Technology Stack Fingerprinting
## Wappalyzer
Use the wappalyzer extension: https://www.wappalyzer.com/
## URL extensions
Does the URL have URL extensions?
i.e. .php = php, .js, .do & .html = java
## Debugging Page Content
Open the dev tools debugger on any browser. Look for files such as jquery.min.js...


Remember, if code has been minified, it can be prettified on Firefox debugger with the following button:
![image](https://github.com/user-attachments/assets/65dcbe2d-37b8-413c-8264-0014b4b7c911)

The inspector (Right Click > Inspect) tool is also helpful for looking for hidden form fields.
## Response Headers
Check the Networking Tab in the developer tools of the browser (i.e. Firefox):
![image](https://github.com/user-attachments/assets/7fab14a8-b55b-41d4-b1c0-38e23f6c51e0)

Observe that headers such as "Server" give the technology (including the version!).
## Sitemaps
* /robots.txt
* /sitemap.xml
