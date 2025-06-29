https://github.com/RoqueNight/Reverse-Shell-TTY-Cheat-Sheet
```
/usr/bin/script -qc /bin/bash /dev/null
```
OR
```
python -c 'import pty; pty.spawn("/bin/bash");'
```
```
export TERM=xterm
```
```
Ctrl+Z
```
```
stty raw -echo; fg
```
