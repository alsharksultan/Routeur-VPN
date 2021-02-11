#!/bin/bash
 
# INSTALL RASPAP

echo ""
echo -e "Script 2 : Installer le hotspot WIFI Raspad"
echo -e "Repondez 'y' à toutes les questions"
echo -e "Redémarrer a la fin du script."
echo -e "Github officiel : https://github.com/RaspAP/raspap-webgui"
echo ""

sleep 5
wget -q https://git.io/voEUQ -O /tmp/raspap && bash /tmp/raspap
