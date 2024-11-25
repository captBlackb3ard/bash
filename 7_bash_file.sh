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

#Define colors for CSV/JSON output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

: '
 File Operations
 --------------------------------------------------------------------------------------------------------------------------
 Bash provides various methods to read data from and write data to files. In addition, Bash can parse various file types including CSV files.
 Bash allows the use of common Linux terminal commands to manage and retrieve information about files.

 Use the following to check file/directory:
 [[ -f $file ]] #File exists
 [[ -d $file ]] #Dir exists
 [[ -e $file ]] #File/dir exists

 Use the following to check the file permissions
 file="./hello"
 [[ -r $file ]] #File is readable
 [[ -w $file ]] #File is writeable
 [[ -x $file ]] #File is executable

 Standard terminal commands can used within a bash script:
 mv oldname.txt newname.txt       #rename file
 rm file_name.txt                 #delete file
 cp orig_file.txt backup_file.txt #copy file and rename

 Commands: mkdir, find, head, tail, touch, chmod, gzip, gunzip, tar, grep
 
'

echo -e "Retrieving Data from a File\n*******************************"
echo -e "\nStore Contents in a Variable\n*******************************"
#Check if file exists
if [ ! -f data_file ]; then
    echo "File 'data_file' does not exist in the current directory! " >&2
    exit 1
else #File exists and read contents into variable
    text=$(<data_file)
    echo -e "The contents of the data_file are: \n ${text}"
fi

echo -e "\nUse grep to Retrieve keyword\n*******************************"
if [ ! -f data_file ]; then
    echo "File 'data_file' does not exist in the current directory! " >&2
    exit 1
else #File exists and read contents into variable
    if grep -q "banana" data_file; then
        echo "Found keyword 'banana'"
    else
        echo "Unable to find keyword"
    fi
fi

echo -e "\nRead File using While Loop\n*******************************"
#Check if file exists
if [ ! -f data_file ]; then
    echo "File 'data_file' does not exist in the current directory! " >&2
    exit 1
else #File exists output each line via while loop
    while read file; do
        echo ${file}
    done < "data_file"
fi

echo -e "\nWriting Data to a File\n*******************************"
#Use the '>>' to append data to end of file; '>' overwrites existing contents
#Check if file exists
if [ ! -f data_file ]; then
    echo "File 'data_file' does not exist in the current directory! " >&2
    exit 1
else #File exists, append data to file
    echo -n "Tokyo Berlin Quebec Madrid" >> data_file 
    echo "Data Written"
fi

echo -e "\nRetrieving File Metadata\n*******************************"
if [ ! -f data_file ]; then
    echo "File 'data_file' does not exist in the current directory! " >&2
    exit 1
else #File exists retrieve metadata
    #filesize=$(stat -c%s "data_file") #Retrieve file size
    perms=$(stat -c%A "data_file") #Retrieve file permissions
    users=$(stat -c%U "data_file") #Retrieve user information
    groups=$(stat -c%G "data_file") #Retrieve group information

    echo -e "The data_file has the following metadata:\nSize: $filesize KBs,\nPermissons: $perms,\nOwner: $users,\nGroup: $groups\n"
fi


echo -e "\nParsing CSV File\n*******************************"
if [ ! -f industry_sic.csv ]; then
    echo "File 'data_file' does not exist in the current directory! " >&2
    exit 1
else #File exists, retrieve csv line by line
    header=1
    while SEP="," read -r col1 col2; do
        if [[ $header -eq 1 ]]; then  #Print out table header
            echo -e "${BLUE}$col1\t\t|\t$col2${NC}"
            echo "*************************************************************************"
            let header++
        else
            echo -e "$col1\t|\t$col2"
        fi
    done <industry_sic.csv
fi


