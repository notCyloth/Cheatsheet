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
ffuf -request search.req -request-proto http -w /usr/share/wordlists/seclists/Fuzzing/special-chars.txt 
```
-request-proto only is required for http as https is the default.
