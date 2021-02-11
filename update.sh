#!/bin/bash
 
# MAJ

echo ""
echo -n "Script 1 : Mettre à jour, installer OpenVPN et configurer le pays Wifi ? [taper oui ou non]:"
echo ""
read answer

if [[ $answer != "oui" ]]; then
        echo "Arret du script"
        exit 0
    fi
	
echo ""	
echo -n "Mettre à jour le mot de passe de pi? [taper oui ou non]: "
echo ""
read answer

if [ "$answer" != 'non' ] && [ "$answer" != 'non' ]; then
        sudo passwd pi
fi

cd /home/pi/Routeur-VPN/ || exit
sudo apt-get update -y
sudo apt dist-upgrade

echo -e "Fin du premier script : redemarrage dans 30 secondes "
echo ""
sleep 30
sudo reboot
