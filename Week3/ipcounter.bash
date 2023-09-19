#! /bin/bash

pFile="ipcount.txt"

echo "Please enter your ip address: "
read ip

echo "Please enter your ip prefix: "
read prefix

ip1=$(echo "${ip}" | cut -d '.' -f 1)
ip2=$(echo "${ip}" | cut -d '.' -f 2)
ip3=$(echo "${ip}" | cut -d '.' -f 3)

ip1binary=$(echo "obase=2;$ip1" | bc)
ip2binary=$(echo "obase=2;$ip2" | bc)
ip3binary=$(echo "obase=2;$ip3" | bc)

for i in {1..254}
do
ip4binary=$(echo "obase=2;$i" | bc)
printf '%08d' "${ip1binary}" >> ${pFile}
printf '%08d' "${ip2binary}" >> ${pFile}
printf '%08d' "${ip3binary}" >> ${pFile}
printf '%08d' "${ip4binary}" >> ${pFile}
printf "\n" >> ${pFile}
done

