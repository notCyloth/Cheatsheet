* feroxbuster
```bash
feroxbuster -u http://($IP_ADDRESS) --silent --output results.txt # optional -w [WORDLIST]
```
* dirbuster
```bash
dirbuster&
```
* ffuf
```bash
ffuf -w /usr/share/wordlists/dirbuster/directory-list-2.3-medium.txt:FUZZ -u http://$(IP_ADDRESS):$(PORT)/FUZZ -recursion -recursion-depth=1
```
* dirb
* gobuster
```bash
gobuster dir -u ($IP_ADDRESS) -w /usr/share/wordlists/dirb/common.txt -t 5
```
Remember to check for other filetypes (pdf, txt, aspx, php, etc):
```bash
gobuster dir -u ($IP_ADDRESS) -w /usr/share/wordlists/dirb/common.txt -t 5 -x pdf,txt
```
Also remember to download any files found (exiftool the files to see who made them, are they a user? etc...)!

Other wordlists:
* /usr/share/wfuzz/wordlist/general/megabeast.txt
* /usr/share/seclists/Discovery/Web-Content/raft-medium-directories.txt

# Extension Fuzzing
Remember to check for pages with extensions like .aspx, .php etc...
## Identify Server Type
Identfy the server type based on HTTP response headers. For example: 
#### apache
- .php
#### IIS
- .asp
- .aspx
## Brute force index page
```
ffuf -w /usr/share/seclists/Discovery/Web-Content/web-extensions.txt:FUZZ -u http://$(IP_ADDRESS):$(PORT)/indexFUZZ -mc 200
```
Once an extension is found, pages can be bruteforced with the -e 'extension' i.e. -e .php, so the wordlist will check the words with and without the extension.
## Check source code of page
RIgt click and check the source code of a page to see if it shows you the webpage extension.
