How to connect to windows from kali linux:
```bash
xfreerdp /u:[USERNAME] /p:[PASSWORD] /v:[WINDOWS IP] +clipboard
```
How to connect with a shared drive:
```bash
xfreerdp /u:[USERNAME] /p:[PASSWORD] /v:[WINDOWS IP] /drive:NetworkShare,/path/to/folder/to/share
```
This results in a redirected share on the windows, allowing files to be transferred to and from the machine:

![image](https://github.com/user-attachments/assets/898dbd9f-d1d9-4368-a094-5853912b40e0)
For joining domains:
```bash
/d:DOMAIN.COM
```
