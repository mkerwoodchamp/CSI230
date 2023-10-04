#! /bin/bash

logDir="/var/log/apache2/"

alllogs=$(ls "${logDir}" | grep "access.log" | grep -v "other_vhosts" | grep -v "gz")
echo "${alllogs}"

:> access.txt

for i in ${alllogs}
do 
	cat "${logDir}${i}" >> access.txt
done

logFile="access.txt"
cut -d ' ' -f 1 access.txt | sort | uniq
