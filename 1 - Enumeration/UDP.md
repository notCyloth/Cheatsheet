# UDP

## 25 - SNMP
- **onesixtyone (SNMP Enumeration)**
    ```bash
    onesixtyone -c community.txt $IP_ADDRESS
    ```
    ```bash
    <insert onesixtyone output here>
    ```
- **snmpwalk (SNMP Walk)**
    ```bash
    snmpwalk -v 2c -c public $IP_ADDRESS
    ```
    ```bash
    <insert snmpwalk output here>
    ```

## 161 - SNMP (Advanced Enumeration)
- **snmpenum**
    ```bash
    snmpenum -v 2c -c public $IP_ADDRESS
    ```
    ```bash
    <insert snmpenum output here>
    ```

## 161/162 - SNMP Trap
- **SnmpTrap (Listen for SNMP Traps)**
    ```bash
    snmptrapd -f -Lo
    ```
    ```bash
    <insert snmptrap output here>
    ```

## 123 - NTP
- **NTP Enumeration**
    ```bash
    ntpdc -c sysinfo $IP_ADDRESS
    ```
    ```bash
    <insert ntpdc output here>
    ```
