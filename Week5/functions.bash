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
content=$(cat "$path")

while read -r line
do
count=$("$content" | egrep 'HTTP/.*" [400-404]' | cut -d ' ' -f 1 | tr -d '] -')
num=$(echo "$count" | wc -l)
if [[ $num -ge 3 ]]
then
echo $line >> blacklisted.txt
echo $line
fi
done<$input
}

function histogram ()
{
path="/var/log/apache2/access.log"
currDate=$(date +"%d/%b/%Y:%H")
input="clientIPs.txt"
content=$(cat "$path")

while read -r line
do
count=$("$content" | grep "${currDate}" | grep "${line}" | cut -d ' ' -f 1 | tr -d '] -')
num=$(echo "$count" | egrep 'HTTP/.*" 200' | wc -l | sort | uniq -c)
done<$input
}

function block ()
{
path="/var/log/apache2/access.log"
input="blacklisted.txt"

while read -r line
do
iptables -A INPUT -s "${line}" -j DROP
done<$input
}

function resetblock ()
{
iptables -F
}

menu=true
while [[ "${menu}" == true ]]
do
echo "Please enter the input of what you would like to do: "
echo "1. Number of Visitors"
echo "2. Display Visitors"
echo "3. Show Bad Visits"
echo "4. Block Bad Visits"
echo "5. Reset Block Rules"
echo "6. Show Visit Histogram"
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
elif [[ "${choice}" == '6' ]]
then
	histogram
elif [[ "${choice}" == '4' ]]
then
	block
	iptables -L INPUT -v -n
elif [[ "${choice}" == '5' ]]
then
	resetblock
	iptables -L INPUT -v -n
elif [[ "${choice}" == '7' ]]
then
	menu=false
else
	echo "Please enter a valid choice"
fi

done
