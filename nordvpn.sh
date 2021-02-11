#!/bin/bash
 
# INSTALL RASPAP

echo ""
echo -e "Script 3 : Install & config NordVPN"
echo -e ""
echo ""

sleep 2
sh <(curl -sSf https://downloads.nordcdn.com/apps/linux/install.sh)
nordvpn login
nordvpn whitelist add port 22
sudo iptables -P INPUT ACCEPT
sudo iptables -P OUTPUT ACCEPT
sudo iptables -t nat -A POSTROUTING -o tun0 -j MASQUERADE
sudo iptables -A FORWARD -i tun0 -o wlan0 -m state --state RELATED,ESTABLISHED -j ACCEPT
sudo iptables -A FORWARD -i wlan0 -o tun0 -j ACCEPT
