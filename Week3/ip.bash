#! /bin/bash
# return ip address without /x

ip=$(bash fullip.bash | cut -d '/' -f 1)
echo "${ip}"
