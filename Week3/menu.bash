#! bin/bash/
# Menu that allows user to access all other scripts

echo "Welcome"

menu=true
while [[ "${menu}" == true ]];
do
echo "Please enter the number for the input you would like to see"
echo "1. Get my ip address"
echo "2. Get my ip address in binary"
echo "3. Get my network mask in binary"
echo "4. Get my network address in binary"
echo "5. Convert a binary to IP address"
echo "6. Quit"

read choice

if [[ "${choice}" == '1' ]];
then
  bash ip.bash
elif [[ "${choice}" == '2' ]];
then
  bash myipbinary.bash
elif [[ "${choice}" == '3' ]];
then
  bash subnetmask.bash
elif [[ "${choice}" == '4' ]];
then
  bash mynetworkbinary.bash
elif [[ "${choice}" == '5' ]];
then
  bash convbin2ip.bash
else
  menu=false
fi

done
