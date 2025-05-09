* Group Policy Preferences (GPP) allowed admins to create policies using embedded credentials.
* These passwords were encrypted and placed in a "cPassword".
* The key was accidentally released.
* Patched in MS14-025, but it doesn't prevent previous uses.
Patched, but if previous uses are still there, then the credentials are still there.

**STILL RELEVANT, LOOK FOR THIS EVEN ON PATCHED SYSTEMS.**
# How to do it
If you have elevated privileges, use metasploit "smb_enum_gpp" to find cPasswords.

If cPasswords is manually found in SYSVOL, use the following to decrypt the cPassword:
```bash
gpp-decrypt [cPassword]
```
