#! /bin/bash

input="activehosts.txt"

output="webservers.txt"

while read -r line
do
response=$(curl "http://$line" | head -n 1)

if [[ "$response" == *"200 OK"* ]]
then
	echo $line >> "${output}"
fi

done<$input
