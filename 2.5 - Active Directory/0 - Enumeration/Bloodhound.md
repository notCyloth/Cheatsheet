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
