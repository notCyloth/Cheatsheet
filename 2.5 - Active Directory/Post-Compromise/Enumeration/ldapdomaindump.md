# Step 1:
Create a folder for the domain details to go to.
```bash
mkdir marvel.local
```
# Step 2:
Run ldapdomaindump in that folder.
```bash
sudo ldapdomaindump ldaps://$(DC_IP_ADDRESS) -u '$(DOMAIN_USERNAME)' -p $(PASSWORD)
```
Example:
```bash
sudo ldapdomaindump ldaps://192.168.138.136 -u 'MARVEL\fcastle' -p Password1
```
Look for domain admins (in the domain_users_by_group.html), credentials in descriptions, domain_policy.html. domain_computers.html might detail if any out of date computers that could be targeted.
