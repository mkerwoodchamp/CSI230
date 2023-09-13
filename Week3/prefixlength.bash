#! /bin/bash
# returns the prefix length

ip=$(bash fullip.bash | cut -d '/' -f 2)
echo "${ip}"
