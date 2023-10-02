#! /bin/bash

function listips ()
{
path="/var/log/apache2/access.log"
rm clientIPs.txt
< "$path" cut -d ' ' -f 1 | sort | uniq >> clientIPs.txt
}

function visitors ()
{
path="/var/log/apache2/access.log"
currDate=$(date +"%d/%b/%Y")
input="clientIPs.txt"

while read -r line
do
cat "${path}"| grep "${currDate}" | grep "${line}" | cut -d ' ' -f 1 | sort | uniq -c 
done<$input
}

function badclients ()
{
path="/var/log/apache2/access.log"
currDate=$(date +"%d/%b/%Y:%H")
input="clientIPs.txt"
content=(cat "path")

while read -r line
do
count=$("${content}" | grep "${currDate}" | grep "${line}" | cut -d ' ' -f 1 | tr -d '] -')
num=$(echo count | egrep 'HTTP/.*" [400-404]' | cut -d ' ' -f 6)
if [[ $num -ge 3 ]]
then
echo $line >> blacklisted.txt
fi
done<$input
}

function histogram ()
{
path="/var/log/apache2/access.log"
currDate=$(date +"%d/%b/%Y:%H")
input="clientIPs.txt"
content=(cat "path")

while read -r line
do
count=$("${content}" | grep "${currDate}" | grep "${line}" | cut -d ' ' -f 1 | tr -d '] -')
num=$(echo count | egrep 'HTTP/.*" 200' | cut -d ' ' -f 6 | sort | uniq -c)
done<$input
}

function block ()
{
path="/var/log/apache2/access.log"
input="blacklisted.txt"

while read -r line
do
ufw deny from "${line}"
done<$input
}

function resetblock ()
{
ufw reset
}

menu=true
while [[ "${menu}" == true ]]
do
echo "Please enter the input of what you would like to do: "
echo "1. List ip addresses that have accesses the web page"
echo "2. Count and list the clients that have accessed your page in the last day"
echo "3. Count clients that got a bad response"
echo "4. Show how many 200 requests were recieved each day"
echo "5. Block users from option 3"
echo "6. Reset the blocked users"
echo "7. Quit"

read choice

if [[ "${choice}" == '1' ]]
then
	listips
elif [[ "${choice}" == '2' ]]
then
	visitors
elif [[ "${choice}" == '3' ]]
then 
	badclients
elif [[ "${choice}" == '4' ]]
then
	histogram
elif [[ "${choice}" == '5' ]]
then
	block
elif [[ "${choice}" == '6' ]]
then
	resetblock
else
	menu=false
fi

done
