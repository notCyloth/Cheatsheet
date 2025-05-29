# Pwsh
```
pwsh # Opens powershell on linux
```
Below is an example payload being encoded. 
```
$Text = '[PAYLOAD GOES HERE]'
$Bytes = [System.Text.Encoding]::Unicode.GetBytes($Text)
$EncodedText = [Convert]::ToBase64String($Bytes)
$EncodedText # COPY THE OUPUT
exit
```
Now you have a b64 encoded payload that Powershell will accept!
