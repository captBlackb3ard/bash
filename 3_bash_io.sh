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
 Bash Input
 --------------------------------------------------------------------------------------------------------------------------
 Parameters are usually provided when executing a script, but it is also possible to receive input from a user or file.
 
 User input can be captured using the 'read' command which places it in the shell variable REPLY
 When using 'select' user prompt is executed using 'PS3' and the value stored in the shell variable REPLY

 Bash can also read data from a file as input
'

#Get User Input
echo -e "\nRequesting User Input\n*******************************"
#To print a prompt before reading user input add the '-p' option; add the variable to store the input at the end
read -p "What is your first name: " fname
echo Hello and welcome $fname

#To add a timeout to the prompt add the '-t' option & the number of seconds to wait
read -t 10 -p "What is your last name, ${fname}? (10 seconds to respond): " lname
#Check if last name submitted
[ -z $lname ] && echo -e "\nNo last name provided." || echo -e "Welcome to Bash scripting ${fname} ${lname}."

#To prevent characters appearing as they are typed use the '-s' (silent) option
read -s -p "What is the password ${fname}? " passwd
if [[ $passwd = 123456 ]]; then
    echo -e "\nPassword is correct"
else
    echo -e "\nPassword incorrect, try again."
fi
#NOTE: passwords are stored in plaintext in memory & can be retrieved via a core dump.


#Request user for input & test the input to decide how to proceed using 'case'
echo -e "\nRequesting Yes or No\n*******************************"
read -t 15 -p "Would you like to proceed with this script?[nNyY] ": response
[ -z "$response" ] && response="N" #Set a default response
#Check the response input
case "$response" in 
    [yY] ) echo "Thank you. Script will continue with execution."
        ;;
    [nN] ) echo "Script exection will terminate."
           # exit 0  #uncomment this line to indicate successful termination
        ;;
    *    ) echo "Incorrect option submitted!" >&2
           exit 1
        ;;
esac


#Use the Bash 'select' construct to generate a menu of options
echo -e "\nBash menu option\n*******************************"
list="Apple Banana Cantelope Dates Elderberry"
PS3="Whats your favourite fruit? (Select a number 1-5, x to exit): " #input prompt used by 'select' 
select fruit in $list;
do 
    echo "Your favourite fruit is ${fruit} (No. ${REPLY})"
    break
done

echo -e "\nRetrieving Data from a File\n*******************************"
#Check if file exists
if [ ! -f data_file ]; then
    echo "File 'data_file' does not exist in the current directory! " >&2
    exit 1
else #File exists and read contents into variable
    text=$(<data_file)
    echo -e "The contents of the data_file are: \n ${text}"
fi



