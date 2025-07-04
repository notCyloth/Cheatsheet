```
find / -name .git 2>/dev/null
```
If there are any .git files on the machine, it's worth going to the directory .git is in and running the following:

This will show all commits:
```bash
git log
```
This will show what was changed in the commit:
```bash
git show 612ff5783cc5dbd1e0e008523dba83374a84aaf1
```
