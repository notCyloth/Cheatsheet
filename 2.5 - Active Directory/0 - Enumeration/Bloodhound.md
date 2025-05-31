# Data Ingesters
Collects data for Bloodhound to analyse.
## Sharphound
https://github.com/SpecterOps/SharpHound/releases
### Step 1: Transfer Sharphound to target
### Step 2: Import Sharphound module
```powershell
powershell -ep bypass
```
```powershell
Import-Module .\Sharphound.ps1
```
### Step 3: Invoke-Bloodhound
```powershell
Get-Help Invoke-BloodHound
```
```powershell
Invoke-BloodHound -CollectionMethod All -OutputDirectory $(PATH_TO_CURRENT_DIRECTORY) -OutputPrefix "$(OUTPUT_FILENAME)"
```
## Bloodhound-Python
```bash
sudo bloodhound-python -d $(DOMAIN) -u $(USERNAME) -p $(PASSWORD) -ns $(DC_IP_ADDRESS) -c all
```
# Bloodhound
## How to run Bloodhound
```bash
sudo neo4j start
```
Note the link:
![image](https://github.com/user-attachments/assets/f775144d-ddcc-4a2b-8e1e-62e17eb024ac)

Log in with default credentials (neo4j/neo4j) and change the password when prompted (REMEMBER THE CREDS - I usually do neo4j1).
```bash
bloodhound
```
On bloodhound, at the menu on the right hand side, select "Upload Data".

Then, navigate to where the files were created and select them all.
## Analysis
Click the Hamburger menu at the top left. This presents the Database Info as shown below
