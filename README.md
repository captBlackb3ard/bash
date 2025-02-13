# Bash Project

This project contains essential information to assist in the development and maintenance of Bash scripts and utility scripts for system administration and security.

## Bash Basics

Bash is a command-line interpreter widely used on Linux systems and is used as the default login shell.
Bash scripting is used to automate a variety of tasks on Linux systems.

## Bash Scripting 

* Bash scripts do not need to end with the extension `.sh`, but it is good practice to do so.
* Bash files need to include this statement at the top of the file
`#!/bin/bash`
* This will tell the system to use Bash to execute the script and commands that follow.
* Check the secure Bash scripting techniques.

### Bash Comments

* To add single comments to a Bash script, use the `#` character/symbol.
* To add multi-line comments to a Bash script, use the following characters (and spacing).
```
: '
 Everything within these characters will be a comment and will not be executed.
'
```
### Running Bash Scripts
* To run a Bash script, ensure it has execute permissions (never as root) using the command
`chmod u+x bash_script.sh` or `chmod 700 bash_script.sh`.
* Then followed by the command `./bash_script.sh` OR `bash bash_script.sh`.

### Exit Bash Script Execution
* It is possible to terminate the execution of a Bash script using the following commands:
 - The `exit` command allows exiting a script at any point of execution & optionally returns a status. The exit status is an integer with '0' (zero), while a non-zero status indicates an error.
 - The `return` command is generally used to terminate a function & return a value to the caller.
 - The `kill` command sends the 'TERM' signal to a process (the script) to forcefully stop the process. The script will need its process ID to terminate itself (use `PID=$!` to get the process ID, then execute with the statement: `kill -9 $PID`).
* To break out of a loop, iteration, or `select` use the keyword `break`.
  
## Secure Bash Scripting Overview
* Scripts should reliably do ONLY what they are supposed to do.
* Scripts do not lend themselves to being exploited to gain root access.
* Scripts should leak sensitive information (passwords, configurations, etc.)
* Scripts should be robust and fail gracefully.
* Scripts should sanitize all user input.
* scripts should contain only clear, readable code and documentation.
* Review dependencies: ensure external commands/tools used in the script are secure, up-to-date, and necessary.


## Secure Bash Scripting Techniques
