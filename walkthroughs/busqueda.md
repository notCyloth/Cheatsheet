# Busqueda
## Linux / Easy

I start with an initial TCP scan:
```bash
sudo nmap -sC -sV 10.129.24.234 -oA sCsV_TCP
```
Which returns the following:
```
Nmap scan report for 10.129.24.234
Host is up (0.059s latency).
Not shown: 998 closed tcp ports (reset)
PORT   STATE SERVICE VERSION
22/tcp open  ssh     OpenSSH 8.9p1 Ubuntu 3ubuntu0.1 (Ubuntu Linux; protocol 2.0)
| ssh-hostkey: 
|   256 4f:e3:a6:67:a2:27:f9:11:8d:c3:0e:d7:73:a0:2c:28 (ECDSA)
|_  256 81:6e:78:76:6b:8a:ea:7d:1b:ab:d4:36:b7:f8:ec:c4 (ED25519)
80/tcp open  http    Apache httpd 2.4.52
|_http-title: Did not follow redirect to http://searcher.htb/
|_http-server-header: Apache/2.4.52 (Ubuntu)
Service Info: Host: searcher.htb; OS: Linux; CPE: cpe:/o:linux:linux_kernel

Service detection performed. Please report any incorrect results at https://nmap.org/submit/ .
Nmap done: 1 IP address (1 host up) scanned in 11.88 seconds
```
As there is only 22 / 80 open it's likely a web exploit - but I'll run an aggressive nmap scan in the background in case there are other ports/services missed.

I will add the IP to /etc/hosts as "searcher.htb".
```bash
echo "10.129.24.234  searcher.htb" | sudo tee -a /etc/hosts
```

I visit the webpage to be greeted with the following:

<img width="1170" height="755" alt="{EE502638-5AE2-4A5F-9F5D-7CD375AA578B}" src="https://github.com/user-attachments/assets/d7afb655-054a-4bc3-8111-f3f1dfd4d968" />

The first thing I notice is the "Searchor 2.4.0" and search for exploits, which finds me the following:
https://github.com/nexis-nexis/Searchor-2.4.0-POC-Exploit-

I adapt the POC to the request made for this searchor instance by doing the following:

<img width="610" height="284" alt="{5AB59924-A65D-43D6-94D3-FC66FB2D709D}" src="https://github.com/user-attachments/assets/9b0987e2-511e-4fae-8ab4-00b6e8510182" />

This works and I'm able to catch a shell!

<img width="516" height="187" alt="{3E98FF07-7608-4E8A-8E41-38BF0984EB1D}" src="https://github.com/user-attachments/assets/c61934c1-2daa-4654-9225-8355dded700b" />

With this svc user I am able to obtain the user flag. Now for priv esc...

When I list what's in the directory I land in I get the following:

<img width="487" height="136" alt="{FA33313D-2732-43B4-92BC-7F3D53A38221}" src="https://github.com/user-attachments/assets/b9cdffe4-7b95-4d68-8bb4-7d5ac04d7c67" />

.git! Always worth checking commits...

<img width="571" height="192" alt="{D99A4BAA-53F6-4E02-A249-7A833B7878DD}" src="https://github.com/user-attachments/assets/31ccb691-fb91-45fb-8cf5-6fd5875adf63" />

The commit didn't have anything sensitive... What about config?

<img width="719" height="194" alt="{32750D11-37A0-4907-95C9-A1ECE1A9D87A}" src="https://github.com/user-attachments/assets/b29ffbc6-cf44-4a3c-bd35-b333ffeba4ab" />

Bingo! We have some creds and a new domain.
```
cody / jh1usoih2bkjaspwe92
```
and the subdomain 
```
gitea.searcher.htb.
```
After attempting and failing to authenticate as cody with the creds, I add the new subdomain to /etc/hosts and access it:
```bash
echo "10.129.24.234  gitea.searcher.htb" | sudo tee -a /etc/hosts
```
<img width="1761" height="444" alt="{17B811AE-5D6A-4C3F-A164-815ECF0ED3FA}" src="https://github.com/user-attachments/assets/3ecec907-8a9a-4966-ac70-32508d451f2c" />

A nice gitea instance, where I can sign in as cody. Let's see what we can look at...
