#! /bin/bash

input="possibleips.txt"

output="activehosts.txt"

while IFS= read -r line
do
ping -c1 line &> /dev/null

if [ $? -eq 0 ]
then
printf "${line}\n" >> ${output}
fi
done < "$input"
