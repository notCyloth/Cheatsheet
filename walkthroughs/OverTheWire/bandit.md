# OverTheWire Bandit
# Insert Liam crap here

## bandit27
```
git clone ssh://bandit27-git@bandit.labs.overthewire.org:2220/home/bandit27-git/repo
```
```
cat README
```
README contains creds. :D
## bandit28
```
git clone ssh://bandit28-git@bandit.labs.overthewire.org:2220/home/bandit28-git/repo
```
Check previous commits.
```
git log
```
```
git show <commit id>
```
Commit "add missing data" contains creds.
## bandit29
```
git clone ssh://bandit29-git@bandit.labs.overthewire.org:2220/home/bandit29-git/repo
```
List git branches:
```
git branch -a
```
Switch to dev branch and cat README...
```
git switch dev
```
```
cat README.md
```
## bandit30
```
git clone ssh://bandit30-git@bandit.labs.overthewire.org:2220/home/bandit30-git/repo
```
```
git tag
```
Shows the tag "secret". Let's view it.
```
git show secret
```
## bandit31
```
git clone ssh://bandit30-git@bandit.labs.overthewire.org:2220/home/bandit30-git/repo
```
```
cat README.md
```
README.md tells us to push a file called "key.txt" with contents "May I come in?"
```
echo "May I come in?" > key.txt
```
```
git add -f key.txt
```
```
git commit -m "Pushy"
```
```
git push
```
## bandit32
Logging into the shell shows everything going through stdin to be converted to uppercase. Breakout by invoking env var:
```
$0
```
