#! /bin/bash

path="/var/log/apache2/access.log"
currDate=$(date +"%d/%b/%Y")

grep "$currDate" "$path"  | awk '{print $1}' | sort | uniq -c
