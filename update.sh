#!/bin/bash
 
# MAJ

echo ""
echo -n "Script 1 : Update, install OpenVPN et config Contry ? [type yes or no]:"
echo ""
read answer

if [[ $answer != "yes" ]]; then
        echo "Stopping Script"
        exit 0
    fi
	
echo ""	
echo -n "Update pi password? [type yes or no]: "
echo ""
read answer

if [ "$answer" != 'no' ] && [ "$answer" != 'no' ]; then
        sudo passwd pi
fi

cd /home/pi/Routeur-VPN/ || exit
sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt dist-upgrade -y
sudo cp /etc/wpa_supplicant/wpa_supplicant.conf /etc/wpa_supplicant/wpa_supplicant.conf.org
sudo  rm  /etc/wpa_supplicant/wpa_supplicant.conf

echo -e "End of 1st script : reboot in 30 seconds "
echo ""
sleep 30
sudo reboot
