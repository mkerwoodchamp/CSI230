#! /bin/bash

input="ipcount.txt"

output="possibleips.txt"

while IFS= read -r line
do
bin1="${line:0:8}"
bin2="${line:8:8}"
bin3="${line:16:8}"
bin4="${line:24:8}"

binary1=$((2#${bin1}))
binary2=$((2#${bin2}))
binary3=$((2#${bin3}))
binary4=$((2#${bin4}))

printf "${binary1}.${binary2}.${binary3}.${binary4}\n" >> ${output}
done < "$input"
