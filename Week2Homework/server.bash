
#!/bin/bash

# Storyline: Script to create a wireguard server

# Create a private key
p="$(wg genkey)"
echo "${p}" > /etc/wireguard/server_private.key

# Create a public key
pub="$(echo ${p} | wg pubkey)"
echo "${pub}" > /etc/wireguard/server_public.key

# Set the addresses
address="10.254.132.0/24"

# Set Server IP Addresses
ServerAddress="10.254.132.1/24"

# Set a listening port
lport="4282"

# Info to be used in client configuration
peerInfo="# ${address} 192.168.241.131:4282 ${pub} 8.8.8.8,1.1.1.1 1280 120 0.0.0.0/0"
# 1: #, 2: For obtaining an IP address for each client.
# 3: Server's actual IP address
# 4: clients will need server public key
# 5: dns information
# 6: determines the largest packet size allowed
# 7: keeping connection alive for
# 8: what traffic to be routed through VPN

# Filename variable
pFile="wg0.conf"

# Check for existing file
if [[ -f "${pFile}" ]]
then
	# prompt to overwrite file
	echo "The file ${pFile} already exists"
	echo -n "Would you like to overwrite it [y/n]?"
	read overwrite
	
	if [[ "${overwrite}" == "N" || "${overwrite}" == "n" || "${overwrite}" = "" ]]
	then
		exit 0
	elif [[ "${overwrite}" == "y" || "${overwrite}" == "Y" ]]
	then
		echo "Overwriting file"
	else
		exit 1
	fi
fi

echo "${peerInfo}
[Interface]
Address = ${ServerAddress}
PostUp = iptables -A FORWARD -i wg0 -j ACCEPT; iptables -t nat -A POSTROUTING -o ens33 -j MASQUERADE
PostDown = iptables -D FORWARD -i wg0 -j ACCEPT; iptables -t nat -D POSTROUTING -o ens33 -j MASQUERADE
ListenPort = ${lport}
PrivateKey = ${p}
" > wg0.conf 
