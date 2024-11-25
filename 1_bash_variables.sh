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
 Bash Variables
 --------------------------------------------------------------------------------------------------------------------------
 Variables are assigned using the '=' with no preceding or succeeding spaces
 Variable values with spaces (strings) should be enclose in quotes
 
 Reference the variable value with the '$' before the name
 
 Variables can be created adhoc or via the export command
 Remove (delete) variables with the unset command

 Use the following with conditional evaluation to confirm a variables state: 
 [[ -z $val ]] $val is null (empty)
 [[ -n $val ]] $val is not-null
'

#Define variables
x=12
message="Hello World"

echo -e "\nVariable Definition\n*******************************"
echo Without '$' the value of x is x #The name 'x' appears not the value
echo With '$' the value of x is $x  #Retrieve and print the value of x

echo Without '$' the string in message is message
echo With '$' the string in message is $message

#Separate variable names from surrounding text by using curly braces '{}'
echo The integer value \'${x}\' is stored in the variable x
echo The string value \'${message}\' is stored in the variables message

: '
 Varaible Scope
 --------------------------------------------------------------------------------------------------------------------------
 By default variables have a local scope to a script/function (and type) can be defined using the 'typeset' command.

 A variable can be accessed in other scripts/shells by using the keyword 'export'; however it is not possible to 
 change the value of the exported variable in the called script back to the calling script.

 Use the keyword 'local' to restrict variable scope to the script or function.
'
echo -e "\nVariable Scope\n*******************************"
#Define variable 'a' as having an integer value, making it easier & faster for arithmetic functions  
typeset -i a #Global scope to this script

function f1 {
    typeset -i b #Scope restricted to this function
    a=7    
    b=8
}

a=5
b=6
echo Variable a with global script scope is $a
echo Variable b with function script scope is $b
f1
echo Variable a with global script scope is $a
echo Variable b with function script scope is $b 

#Extend variable scope to called scripts
export MyVar
export my_var=value


: '
 Declare Command
 --------------------------------------------------------------------------------------------------------------------------
 Is used for more advanced variable management in Bash
 It is useful for string and array variables

 Declare Command Options
 declare -p  Display options & attributes of variables
 declare -l  Uppercase variable values converted to lowercase
 declare -u  Lowercase variable values converted to uppercase
 declare -r  Variable is read-only
'
echo -e "\nDeclare command\n*******************************"
declare -l lstring="HELlO World"
declare -u ustring="hellO worlD"
declare -r readonly="A Value"

echo lstring = $lstring
echo ustring = $ustring
echo readonly = $readonly
readonly="New Value" #Will generate an error

: '
 Arrays
 --------------------------------------------------------------------------------------------------------------------------
 Arrays can be defined using the 'declare' command with options '-a' or '-A' or using parentheses ()
 declare -a  will make an integer index array variable
 declare -A  will make an associateive array variable
'
echo -e "\nArrays\n*******************************"
declare -a MyArrayI #Integer Indexed Array
declare -A MyArrayA #Associative Array
myArray=("Apple" "Banana" "Cantelope" "Dates" "Elderberry") #Integer indexed array

MyArrayI[2]="Second Value"
echo 'MyArrayI[2] = ' ${MyArrayI[2]}
MyArrayA["hotdog"]="baseball"
echo 'MyArrayA[hotdog] = '${MyArrayA['hotdog']}
echo The first array value is ${myArray[0]} and the last value is ${myArray[4]}


: '
 Viewing All Variable Values
 --------------------------------------------------------------------------------------------------------------------------
 Use the 'set' command to see all variables & their values and function definitions for the current shell (including the system).
 Use the 'export -p' to view only those variables that have been exported & available to a subshell.
'

#Execute the 'set' command
# set #Execute this command without any parameters to display all variables (system-shell wide and script)
echo -e "\nRetrieve Variables\n*******************************"
echo -n Retrieve a specific variable name-value e.g. message pair" "
set | grep message





