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

INPUT=':
![image](https://github.com/user-attachments/assets/250bcf49-a2c6-45db-b5bd-339990ce7b04)

INPUT=')#:
