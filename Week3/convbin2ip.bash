#! /bin/bash
# convert binary to an ip address

echo "Please enter a 32 digit binary number"

read binary

bin1=(echo binary | grep -Eo '.{8}')
bin2=(echo binary | grep -Eo '.{8}')
bin3=(echo binary | grep -Eo '.{8}')
bin4=(echo binary | grep -Eo '.{8}')

binary1=$(echo "obase=10;$bin1" | bc)
binary2=$(echo "obase=10;$bin2" | bc)
binary3=$(echo "obase=10;$bin3" | bc)
binary4=$(echo "obase=10;$bin4" | bc)

echo "${binary1}.${binary2}.${binary3}.${binary4}"
