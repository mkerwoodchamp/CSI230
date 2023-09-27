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

function badClients ()
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

listips
visitors
badClients
histogram
