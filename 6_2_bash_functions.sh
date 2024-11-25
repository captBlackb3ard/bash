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

#Basic function to check if a tools is installed.
function ensure_dependency {
    local tool=$1
    
    if  ! command -v "$tool" &> /dev/null; then
        echo "Error: ${tool} is not installed" >&2
        echo "PLease install the ${tool} before proceeding."
        exit 1
    else
        echo "${tool} installed, you may proceed."
    fi
}



ensure_dependency "git"
