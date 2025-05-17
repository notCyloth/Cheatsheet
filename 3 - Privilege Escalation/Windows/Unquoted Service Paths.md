We can use this attack when we have Write permissions to a service's main directory or subdirectories but cannot replace files within them.

Each Windows service maps to an executable file that will be run when the service is started. If the path of this file contains one or more spaces and is not enclosed within quotes, it is potentially vulnerable.
