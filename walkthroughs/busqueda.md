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
and the subdomain...
```
gitea.searcher.htb
```
After attempting and failing to authenticate as cody with the creds, I add the new subdomain to /etc/hosts and access it:
```bash
echo "10.129.24.234  gitea.searcher.htb" | sudo tee -a /etc/hosts
```
<img width="1761" height="444" alt="{17B811AE-5D6A-4C3F-A164-815ECF0ED3FA}" src="https://github.com/user-attachments/assets/3ecec907-8a9a-4966-ac70-32508d451f2c" />

A nice gitea instance, where I can sign in as cody. Let's see what we can look at...

Hmm, that has nothing except showing an administrator user exists...

Let's go back on our shell and do some priv esc checks.

```
sudo -l
```
When prompted for a password, cody's gitea password works!
```
Matching Defaults entries for svc on busqueda:
    env_reset, mail_badpass,
    secure_path=/usr/local/sbin\:/usr/local/bin\:/usr/sbin\:/usr/bin\:/sbin\:/bin\:/snap/bin, use_pty

User svc may run the following commands on busqueda:
    (root) /usr/bin/python3 /opt/scripts/system-checkup.py *
```
Looking at this python checkup script - I can see three different options. Let's go through them all. 
```
Usage: /opt/scripts/system-checkup.py <action> (arg1) (arg2)

     docker-ps     : List running docker containers
     docker-inspect : Inpect a certain docker container
     full-checkup  : Run a full system checkup
```
```
sudo /usr/bin/python3 /opt/scripts/system-checkup.py docker-ps
```
```
CONTAINER ID   IMAGE                COMMAND                  CREATED       STATUS       PORTS                                             NAMES
960873171e2e   gitea/gitea:latest   "/usr/bin/entrypoint…"   3 years ago   Up 4 hours   127.0.0.1:3000->3000/tcp, 127.0.0.1:222->22/tcp   gitea
f84a6b33fb5a   mysql:8              "docker-entrypoint.s…"   3 years ago   Up 4 hours   127.0.0.1:3306->3306/tcp, 33060/tcp               mysql_db
```
Aha, we can see some docker containers... Let's try and interact with these using the docker-inspect command on the script. I suspect this is the same as the official docker inspect command (https://docs.docker.com/reference/cli/docker/inspect/).

According to the docs, I run the following command to get the config of the gitea container:
```
sudo /usr/bin/python3 /opt/scripts/system-checkup.py docker-inspect --format='{{json .Config}}' 960873171e2e
```
Which gives the following:
```
--format={"Hostname":"960873171e2e","Domainname":"","User":"","AttachStdin":false,"AttachStdout":false,"AttachStderr":false,"ExposedPorts":{"22/tcp":{},"3000/tcp":{}},"Tty":false,"OpenStdin":false,"StdinOnce":false,"Env":["USER_UID=115","USER_GID=121","GITEA__database__DB_TYPE=mysql","GITEA__database__HOST=db:3306","GITEA__database__NAME=gitea","GITEA__database__USER=gitea","GITEA__database__PASSWD=yuiu1hoiu4i5ho1uh","PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin","USER=git","GITEA_CUSTOM=/data/gitea"],"Cmd":["/bin/s6-svscan","/etc/s6"],"Image":"gitea/gitea:latest","Volumes":{"/data":{},"/etc/localtime":{},"/etc/timezone":{}},"WorkingDir":"","Entrypoint":["/usr/bin/entrypoint"],"OnBuild":null,"Labels":{"com.docker.compose.config-hash":"e9e6ff8e594f3a8c77b688e35f3fe9163fe99c66597b19bdd03f9256d630f515","com.docker.compose.container-number":"1","com.docker.compose.oneoff":"False","com.docker.compose.project":"docker","com.docker.compose.project.config_files":"docker-compose.yml","com.docker.compose.project.working_dir":"/root/scripts/docker","com.docker.compose.service":"server","com.docker.compose.version":"1.29.2","maintainer":"maintainers@gitea.io","org.opencontainers.image.created":"2022-11-24T13:22:00Z","org.opencontainers.image.revision":"9bccc60cf51f3b4070f5506b042a3d9a1442c73d","org.opencontainers.image.source":"https://github.com/go-gitea/gitea.git","org.opencontainers.image.url":"https://github.com/go-gitea/gitea"}}
```
In that lovely mess there is the following: 
```
GITEA__database__PASSWD=yuiu1hoiu4i5ho1uh
```
I attempted this new password for administrator user and it worked. So the creds are:
```
administrator / yuiu1hoiu4i5ho1uh
```
With this new access we can see administrator/scripts!

<img width="1510" height="523" alt="{561BC553-8C2A-465A-B0CE-FE64644CE1F3}" src="https://github.com/user-attachments/assets/9cbd9a1b-4fab-4681-a42b-f629949bf9b8" />

Here it is in all it's glory!

<img width="1218" height="491" alt="{296426E4-92D4-417F-8512-9848A11EE5CE}" src="https://github.com/user-attachments/assets/3493bbad-1427-4dc4-8df1-d45e18fa22ae" />

I want to check system-checkup.py as thats what we run as sudo, and I got a "Something went wrong" error message whenever running full-checkup.

<img width="345" height="201" alt="{C3E319C2-2E5E-4439-B86F-E21883324425}" src="https://github.com/user-attachments/assets/80caa8e4-c159-46d2-9588-4d0e95cc93e4" />

Aha! Looks like it looks for a local script called ./full-checkup.sh and runs it! This could mean we may be able to run this script as root! Let's make a revshell to run and call it full-checkup.sh.

