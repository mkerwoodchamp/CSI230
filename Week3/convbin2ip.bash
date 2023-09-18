#! /bin/bash
# convert binary to an ip address

echo "Please enter a 32 digit binary number"

read binary

bin1="${binary:0:8}"
bin2="${binary:8:8}"
bin3="${binary:16:8}"
bin4="${binary:24:8}"

binary1=$((2#${bin1}))
binary2=$((2#${bin2}))
binary3=$((2#${bin3}))
binary4=$((2#${bin4}))

echo "${binary1}.${binary2}.${binary3}.${binary4}"
