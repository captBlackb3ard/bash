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
 Bash Parameters
 --------------------------------------------------------------------------------------------------------------------------
 When executing Bash scripts, it is possible to pass 'parameters' to the script to modify its behaviour.
 Parameters are passed at the end of the script when executing, e.g. when executing bash_script.sh with two parameters we 
 would pass them using the following syntax
 
 ./bash_script.sh param1 param2
 
 The parameters are indexed and can be accessed using the following syntax
 ${1} for the first parameter
 ${2} for the second paramater etc

 $# - Provides the total number of parameters provided
 $* - Returns all parameters supplied
 $@ - Returns all parameters supplied

 Execute this script with the following parameters
 ./2_bash_parameters.sh {A..D} -> Will generate a sequence between A & D, i.e. A, B, C, D
 ./2_bash_parameters.sh {a..f} -> Will generate a sequence between a & f, i.e. a, b, c, d, e, f
 ./2_bash_parameters.sh {1..5} -> Will generate a sequence between 1 & 5, i.e. 1, 2, 3, 4, 5
'
typeset -i x
x=1

#Check if one parameter provided
echo -e "\nParameter Validation\n*******************************"
if [ "$#" -eq 0 ] 
then
    echo "Please provide atleast one parameter"
else
    echo -e "Parameters detected. \nProceed with script."
fi


echo -e "\nParameters Supplied\n*******************************"
if [ "$#" -lt 2 ] 
then
    echo You supplied one parameter - ${1}
else
    echo You supplied a total of $# parameters
    for params in $@
    do
        echo Parameter $x is $params
        ((x++)) #Increment x by 1
    done
fi

: '
 It is possible to check if the number of supplied parameters is correct using the following:
 if [ "$#" -ne 3 ]
 then
    echo "Incorrect number of arguments supplied"
    exit 1
 else
    #Proceed with script execution
 fi
'


: '
 Setting Default Values
 --------------------------------------------------------------------------------------------------------------------------
 It is good practice to check if the correct parameters are supplied to a script. If not, then the user should be prompted for the correct 
 parameters and the execution exited.
 
 The alternative would be to set a default value for a required parameter to allow the script to proceed with execution.
'

echo -e "\nSetting Default Values\n*******************************"
a=Parameter2
b=$2
f=$([ "$#" -lt 2 ] && echo "$a" || echo "$b")
echo $f

: '
 Consuming Parameters
 --------------------------------------------------------------------------------------------------------------------------
 Bash script usually accept two types of parameters:
 1. Options - that modify script execution (e.g -v indicates verbose, -t indicates time, etc.)
 2. Values - that provide key information for the script (e.g. IP address, hostname, etc.)
 
 It is possible to reference parameters by index, but incase we need to loop through the parameters, we can use the 'shift' command (see example below).
'
#Check if '-v' parameter supplied and define script verbosity level
VERBOSE=0
if [[ $1 = -v ]]
then
    VERBOSE=1
    shift
fi

#Proceed with execution
echo -e "\nConsuming Parameters\n*******************************"
x=1
if (( VERBOSE == 0 ))
then
    echo -e "Script verbosity not set, but "$#" parameters supplied.\n"
else
    echo -e "Parameter -v removed from parameter list.\nThe new list is:\n"
    for params in $@
    do
        echo Parameter $x is $params
        ((x++)) #Increment x by 1
    done
    echo "" #Print new line
fi




