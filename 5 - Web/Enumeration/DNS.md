# Record types
Each domain can use different types of DNS records. Some of the most common types of DNS records include:
* NS: Nameserver records contain the name of the authoritative servers hosting the DNS records for a domain.
* A: Also known as a host record, the "a record" contains the IPv4 address of a hostname (such as www.megacorpone.com).
* AAAA: Also known as a quad A host record, the "aaaa record" contains the IPv6 address of a hostname (such as www.megacorpone.com).
* MX: Mail Exchange records contain the names of the servers responsible for handling email for the domain. A domain can contain multiple MX records.
* PTR: Pointer Records are used in reverse lookup zones and can find the records associated with an IP address.
* CNAME: Canonical Name Records are used to create aliases for other host records.
* TXT: Text records can contain any arbitrary data and be used for various purposes, such as domain ownership verification.
By default, the host command searches for an A record, but we can also query other fields, such as MX or TXT records, by specifying the record type in our query using the -t option:
```bash
host -t mx megacorpone.com
```
```bash
host -t txt megacorpone.com
```
It is possible to bruteforce DNS subdomains in an attempt to find them (bash one-liner):
```bash
for ip in $(cat list.txt); do host $ip.megacorpone.com; done
```
Good lists to bruteforce subdomains can be installed via sudo apt install seclists in /usr/share/seclists.

If multiple subdomains are found within the same approximate IP range (e.g. 51.222.169.X) then we can scanthe range with reverse lookups to request the hostname for each IP:
```
for ip in $(seq 200 254); do host 51.222.169.$ip; done | grep -v "not found"
```
# DNS Recon tools
## DNSrecon
Python tool to automate DNS scanning (this shows a standard scan):
```bash
dnsrecon -d megacorpone.com -t std
```
And to bruteforce using a list (e.g. /usr/share/seclists):
```bash
dnsrecon -d megacorpone.com -D ~/list.txt -t brt
```
## DNSenum
Another tool to automate DNS scanning:
```bash
dnsenum megacorpone.com
```
# Windows Enumeration
nslookup is a great tools to enumerate DNS from a windows machine, as it lives off the land!
```batch
nslookup mail.megacorptwo.com
```
