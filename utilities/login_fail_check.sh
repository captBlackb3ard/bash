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

# Core Bash Script 
# Script reviews the Linux authentication log (auth.log) and displays the number of failed logins

#Define colors for terminal
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color


#Log File Path
LOG_FILE="/var/log/auth.log"

#Search pattern for failed logins
FAILED_LOGIN_PATTERN="password check failed" #Change to your pattern

#Output Report File
report_date=$(date -d now +"%F")
REPORT_FILE="login_report_${report_date}.txt"
REPORT_PATH="${REPORT_FILE}" #Amend to direct report 

if [ ! -f $LOG_FILE ]; then #Check if we can access the authentication log
    echo "Failed to read authentication log file: ${LOG_FILE}, or file does not exist."
else
    #Count number of failed attempts 
    num=$(grep -c -i "$FAILED_LOGIN_PATTERN" "$LOG_FILE")
    failed_login_count=$([ "$num" -lt 1 ] && echo "0" || echo "$num")
    
    #Generate report
    if [ ! -f $REPORT_PATH ]; then # File does not exist
        touch $REPORT_PATH
        echo -e "Authentication Log Summary Report" >> $REPORT_PATH
        echo -e "******************************************\n" >> $REPORT_PATH        
    fi
    
    echo "Report Date: $(date -d now +"%D %H:%M")" >> $REPORT_PATH
    echo "Failed login attempts: ${failed_login_count}" >> $REPORT_PATH


    if [ ! $REPORT_PATH ]; then
        echo "Failed to create login report file: ${REPORT_PATH}"
    else
        echo -e Authentication report generated: ${GREEN} ${REPORT_PATH} ${NC}
        echo -e Failed login attempts: ${RED}$failed_login_count${NC}
    fi
fi
