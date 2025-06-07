# To connect
```bash
mysql -u $(USER) -h $(IP_ADDRESS) --skip-ssl
```
By default, root user has no password, so try:
```bash
mysql -u root -h $(IP_ADDRESS) --skip-ssl
```
# MySQL commands
```
show databases;
```
```
connect [DATABASE]
```
```
show tables;
```
```
select * from [TABLE];
```
```
show columns from [TABLE];
```
```
describe [COLUMN];
```
