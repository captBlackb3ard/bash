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
 Bash Selection (Conditional Statements)
 --------------------------------------------------------------------------------------------------------------------------
 Sequence, Selection, and Iteration are the three fundamental programming constructs.

 Sequence - code/instructions are processed in the order they are written (from top to bottom) in the programming file/script.
 Selection - code/instruction execution path changes based on current evaluated conditions.
 Iteration - code/instructions are repeated with defined parameters to achieve a desired result.

 Bash provides the following selection constructs:
  - if [ evaluation ]; then 
        #execute code
    fi

  - if [ evaluation ]; then
        #execute code
    else
        #execute alternative code
    fi
  - case EXPRESSION in
        pattern_1 )
            #execute code
            ;;
        pattern_2 )
            #execute alternative code
            ;;
        pattern_n )
            #execute alternative code
            ;;
        * )
            #execute alternative code
            ;;
    esac
  - expr?expr:expr
 
 These constructs can be nested within each other to provide additional specific paths based on previous evaluated conditions.

 NOTE: This page provides a list of the possible conditions/expressions to evaluate (https://tldp.org/LDP/Bash-Beginners-Guide/html/sect_07_01.html)

  String Comparison
  val=a
  [[ "$val" == "a" ]] -> equal
  [[ "$val" != "b"]]  -> not equal

  #Numerical Comparison
  num=1
  [[ "$num" -eq 1 ]] #equal
  [[ "$num" -ne 2 ]] #not equal
  [[ "$num" -lt 3 ]] #less than
  [[ "$num" -le 4 ]] #less than or equal
  [[ "$num" -gt 5 ]] #greater than
  [[ "$num" -ge 1 ]] #greater than or equal

  #Combined conditionals
  [[ $num -gt 0 ]] && [[ $num -lt 2 ]] #Logical AND
  [[ $num -gt 0 ]] || [[ $num -lt 2 ]] #Logical OR
'      

typeset -i a
typeset -i b
a=3
b=5
c=3
cd="abcdef"
ef="abcdef"
gh="cd"

echo -e "Display Variable values\n*******************************"
echo "The value of a is ${a}, the value of b is ${b}, and the value of c is ${c}."
echo -e "The value of cd is ${cd}.\nThe value of ef is ${ef}.\nThe value of gh is ${gh}."

echo -e "\nBeginning 'IF' Conditional Evaluation\n*******************************"

if [[ $a -eq $c ]]; then #Integer comparison & operations require (( ))
    echo -E "Executing \$a == \$c: a is equal to c"
fi

if [[ $a -lt $c ]]; then
    echo -E "Executing \$a < \$b: a is less than b"
fi

if [[ $b -lt $c ]]; then
    echo -E "Executing \$b < \$c: b is less than c"
else
    echo -E "Executing \$b < \$c: b is greater than c (else executed)"
fi


if [[ $cd == $ef ]]; then #String comparison & operations require [[ ]]
    echo -E "Executing \$cd -eq \$ef: cd is equal to ef"
fi

if [[ ! $gh == $cd ]]; then
    echo -E "Executing ! \$gh == \$cd: gh is not equal to cd"
fi

if echo "$cd" | grep -q "$gh"; then
    echo "${cd} contains the subsstring '${gh}'"
fi

echo -e "\nBeginning 'Tenary' Conditional Evaluation\n*******************************"
#Bash tenary construct similar to (cond eval) ? TRUE else FALSE
num=$((($a==$c)) && echo "Tenary: a is equal to c" || echo "Tenary: a is not equal to c")
echo $num

#Bash tenary construct similar to (cond eval) ? TRUE else FALSE
stat=$([[ $cd == $ef ]] && echo "Tenary: cd is equal to ef" || echo "Tenary: cd is not equal to ef")
echo $stat

echo -e "\nBeginning 'CASE' Conditional Evaluation\n*******************************"
echo "Which color do you like best? (number 1-5)"
echo "1 - Blue"
echo "2 - Red"
echo "3 - Yellow"
echo "4 - Green"
echo "5 - Orange"
read color;
case $color in
    1) echo "Blue is a primary color.";;
    2) echo "Red is a primary color.";;
    3) echo "Yellow is a primary color.";;
    4) echo "Green is a secondary color.";;
    5) echo "Orange is a secondary color.";;
    *) echo "Color is not available. Please choose a different one.";;
esac


