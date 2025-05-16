# How to run Bloodhound
## Step 1:
Make sure bloodhound is updated:
```bash
sudo apt install bloodhound
```
## Step 2:
Start neo4j console:
```bash
sudo neo4j console
```
## Step 3:
Go to the link provided:
IMAGEGOESHERE
If this is the first time, the credentials are neo4j:neo4j.
## Step 4:
Run bloodhound.
```bash
bloodhound
```
Sign in.
# How to use Bloodhound
## How to clear DB
* Click the hamburger at the top left of the screen.
* Scroll down and click "Clear Database".
## How to use an Ingester
Ingesters are used to gather details on the domain.
```bash
mkdir bloodhound
cd bloodhound
sudo bloodhound-python -d $(DOMAIN) -u $(USERNAME) -p $(PASSWORD) -ns $(DC_IP_ADDRESS) -c all
```
On bloodhound, at the menu on the right hand side, select "Upload Data".
Then, navigate to where the files were created and select them all.
## Analysis
On the top right menu, there is an analysis tab, start with looking at "Find all Domain Admins" From there, look at: 
* Individual nodes 
* What targets and GPO's affect the user? 
* The description? 
* Service Principal name (aka is it a service)?
* High value users/targets kerberoastable?
