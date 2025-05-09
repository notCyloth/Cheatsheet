Technically for Blue/Purple teams, but still very useful.
# Installation
```bash
sudo git clone https://github.com/Plumhound/Plumhound.git
cd Plumhound
sudo pip3 install -r requirements.txt
```
# Usage
Run bloodhound, then check if plumhound can connect by running:
```bash
sudo python3 plumhound.py --easy -p [Bloodhound neo4j password]
```
Start running tasks (worth checking plumhound github page):
```bash
sudo python3 plumhound.py -x tasks/default.tasks -p [BH Neo4j Password]
```
A "reports" folder will be generated with files of reports on all the default tasks run.
```bash
cd reports && firefox index.html
```