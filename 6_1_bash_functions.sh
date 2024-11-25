#!/bin/bash

# Setup Secure Bash Script Configurations
#Set Secure Path
PATH='/usr/local/bin:/bin:/usr/bin'
export PATH 

#Clear Aliases
\unalias -a

#Disable filename expansion
set -f

#Clear the command path hash
hash -r

#Disable core dumps
ulimit -H -c 0 --

#Catch errors and handle unexpected behaviour
ulimit -H -c 0 -- 

#Core Bash Script 


: '
 Functions
 --------------------------------------------------------------------------------------------------------------------------
 Functions can be declared on-the-fly or using the 'declare' command
 declare -f function_name -> Declare a Bash function (not a variable)
 declare -F function_name -> Display the functions name & attributes

'
#Define functions
#----------------------------------
function print_hello {
    echo Hello
}


#Return command exits function execution
function func_return {
 echo Starting execution ...
 return
 echo Ending execution ... # This statement will not be executed
}

#Functions do not explicit accept arguments though they can be passed to a function
function greet {
    echo "${1} John Smith"  
}

create_greet() {
    current_hour=$(date +%H) #Use 10$current_hour to prevent numbers with a leading zero
    if (( 10#$current_hour >= 5 && 10#$current_hour < 12 )); then
        echo "Good morning"
    elif (( 10#$current_hour >= 12 && 10#$current_hour < 18 )); then
        echo "Good afternoon"
    elif (( 10#$current_hour >= 18 && 10#$current_hour < 22 )); then
        echo "Good evening"
    else
        echo "Good night"
    fi
}

#Exit command terminates the entire shell process (not just the function)
function func_exit {
 # exit <value> sets the exit status (default 0 indicates successful, anything else is not successful)
 # Retrieve exit value with '$?' 
 echo Testing 'exit' keyword
 exit 7
 echo $? 
}



#Call Functions
print_hello
func_return
greet "$(create_greet)" #Use command substitution to submit a function's output as an argument to another

#Functions produce results that be captured e.g. in a variable
hvar=$(print_hello)
echo hvar 'function' value is $hvar




func_exit

