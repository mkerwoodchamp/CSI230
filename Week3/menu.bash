#! bin/bash/
# Menu that allows user to access all other scripts

echo "Welcome"

menu=true
while [["${menu}" == true]]
do
echo "Please enter the number for the input you would like to see"
echo "1. Get my ip address"
echo "2. Get my ip address in binary"
echo "3. Get my network mask in binary"
echo "4. Get my network address in binary"
echo "5. Convert a binary to IP address"
echo "6. Quit"

read choice

if [["${choice}" == '1']]
then
  echo$(bash ip.bash)
else if [["${choice}" == '2']]
then
  echo$(bash myipbinary.bash)
else if [["${choice}" == '3']]
then
  echo$(bash subnetmask.bash)
else if [["${choice}" == '4']]
then
  echo$(bash mynetworkbinary.bash)
else if [["${choice}" == '5']]
then
  echo$(bash convbin2ip.bash)
else
  exit 1
done
