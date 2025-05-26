Port Forwarding = Forwarding all traffic sent to that port to another destination (i.e. another port on another machine that isn't reachable from the attacker machine).

Example: Attacking machine wants to access port 5432 on a postgresql server, but that server is only reachable through a DMZ server in between them, thus a port forward can be set up on the DMZ for all traffic going through (for example) port 2122 to forward to port 5432 of the postgresql server.
# Using Socat
Note: Socat usually isn't installed on victim machines but it's possible to download and run a statically linked binary version instead.

Socat binaries: https://github.com/3ndG4me/socat/releases

