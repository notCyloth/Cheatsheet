# XSS Notes

Cross Site Scripting - Lets us execute java script in a malcious browser.

Reflected XSS - comes from current http address
DOM based XSS - Client side has vulnerable JS that uses untrusted inputs instead of server side.
Stored - payload is stored in a database, then retrieved later 

Examples:

```
alert(1)
```

```
prompt(hello)
```


```
function logKey(event){console.log(event.key)}
document.addEventListner('keydown',logKey)
```

This logs key presses

## DOM based XSS
When we see an input field on a web page and enter data into it. If the data you inputted gets put onto the web page, the site may be vulnerable to DOM based XSS.

Whatever we put in the input field, it appears on the site. This is DOM based scripting, we can see that there is no request to the server its self, this is DOM based scripting. 

So lets try some XSS
```
<script>prompt(1)</script>
```

Adding this to the site enters a blank field. This does nothing on our page as we're not actually executing the javascript. Lets try something else. 

```
<img src=x onerror="prompt(1)">
```

We want some sort of response from the page, so what we can do is say, here's an image that doesn't exist, when you error do this thing. (as above)

## Stored based XSS
Stored cross-site scripting (also known as second-order or persistent XSS) arises when an application receives data from an untrusted source and includes that data within its later HTTP responses in an unsafe way. 

NOTES TBC
