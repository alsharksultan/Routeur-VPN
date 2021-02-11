#!/bin/bash
 
# INSTALL RASPAP

echo ""
echo -e "Script 2 : Install Hostpad & raspap WebGui"
echo -e "Answer 'y' to all question"
echo -e "Reboot at the end of script."
echo -e "Official GitHub : https://github.com/RaspAP/raspap-webgui"
echo ""

sleep 5
wget -q https://git.io/voEUQ -O /tmp/raspap && bash /tmp/raspap
