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

#Define colors for file/directory output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

: '
 Bash Looping/Iteration
 --------------------------------------------------------------------------------------------------------------------------
 
 Iteration/looping is useful when processing lists or arrays that contain data. It is often combined with decision structures
 like if/else statements.

 Bash provide the following iteration structures:
 - While loops: (useful for uknown data sizes)
    while 
        command list 1 #Loops while command list 1 evaluates to TRUE
    do
        command list
    done

 - For loops: (useful for fixed data sizes - arrays, known limits)
    for <var> in <list>
    do
        command list
    done

  - 'seq' command prints numbers between range (useful for loops)
        seq 1 5 #Prints 1 2 3 4 5 - each on a new line
  
  - {A..Z} or {1..100} # generates the sequence of letters or numbers between the braces.
'


echo -e "Bash Iteration/Looping Statements\n*******************************"

echo -e "\n'For' Loops - using {}\n*******************************"
for num in {1..5}
do
    echo $num
done
echo -e "\n'For' Loops - using seq\n*******************************"
for nm in $(seq 6 10)
do
    echo $nm
done

echo -e "\n'For' Loops - using Arrays\n*******************************"
declare -a myArray
myArray=(a b c d e f)
for val in "${myArray[@]}"
do
    echo $val
done

echo -e "\n'While' Loops\n*******************************"
#Pipe ls into a while loop & differentiate files from directories
file_type="d" #Can be replace with the command test -d and test -e
ls -l /etc | while
 read a b c d e f g h i
do
 if [[ "${a}" =~ ^"${file_type}" ]]; then
  echo -e ${BLUE}$i${NC} is a directory #-e enable interpretation of backslash escapes
 else
  echo -e ${GREEN}$i${NC} is a file
 fi
done







