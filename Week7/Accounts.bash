#!/bin/bash 

Help(){
echo "-------------------------------"
echo "Syntax: ./Accounts.bash [- c/d]"
echo "Options:"
echo "-c: count logins of a user"
echo "-d: list disabled accounts"
echo "-------------------------------"
}

option=$1

if [ ! ${#} -eq 1 ]
then
Help
exit
fi

while getopts ":cd" option;
do
case $option in
c) #count logins
username=$(cat "user.txt")
num=$(last $username | wc -l)
echo "${username} has logged in ${num} times"
;;
d) #disabled users
cat "/etc/shadow" | grep -v "nologin" | cut -d ":" -f 1,2 | grep "*"
;;
esac
done
