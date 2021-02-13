#!/bin/bash
 
# INSTALL RASPAP

echo ""
echo -e "Script 2 : Manual Install Raspap"
echo -e "Answer 'y' to all question"
echo -e "Reboot at the end of script."
echo -e "Official GitHub : https://github.com/RaspAP/raspap-webgui"
echo ""

sleep 5
sudo rfkill unblock wlan
sudo apt-get install software-properties-common -y
sudo add-apt-repository ppa:ondrej/php
sudo apt-get install dhcpcd5 -y
sudo apt-get install lighttpd git hostapd dnsmasq iptables-persistent vnstat qrencode php7.3-cgi -y
sudo lighttpd-enable-mod fastcgi-php    
sudo service lighttpd force-reload
sudo systemctl restart lighttpd.service
sudo rm -rf /var/www/html
sudo git clone https://github.com/RaspAP/raspap-webgui /var/www/html
sudo cp /var/www/html/config/50-raspap-router.conf /etc/lighttpd/conf-available
sudo ln -s /etc/lighttpd/conf-available/50-raspap-router.conf /etc/lighttpd/conf-enabled/50-raspap-router.conf
sudo systemctl restart lighttpd.service
cd /var/www/html
sudo cp installers/raspap.sudoers /etc/sudoers.d/090_raspap
sudo mkdir /etc/raspap/
sudo mkdir /etc/raspap/backups
sudo mkdir /etc/raspap/networking
sudo mkdir /etc/raspap/hostapd
sudo mkdir /etc/raspap/lighttpd
sudo cp raspap.php /etc/raspap 
sudo chown -R www-data:www-data /var/www/html
sudo chown -R www-data:www-data /etc/raspap
sudo mv installers/*log.sh /etc/raspap/hostapd 
sudo mv installers/service*.sh /etc/raspap/hostapd
sudo chown -c root:www-data /etc/raspap/hostapd/*.sh 
sudo chmod 750 /etc/raspap/hostapd/*.sh 
sudo cp installers/configport.sh /etc/raspap/lighttpd
sudo chown -c root:www-data /etc/raspap/lighttpd/*.sh
sudo mv installers/raspapd.service /lib/systemd/system
sudo systemctl daemon-reload
sudo systemctl enable raspapd.service
sudo mv /etc/default/hostapd ~/default_hostapd.old
sudo cp /etc/hostapd/hostapd.conf ~/hostapd.conf.old
sudo cp config/default_hostapd /etc/default/hostapd
sudo cp config/hostapd.conf /etc/hostapd/hostapd.conf
sudo cp config/090_raspap.conf /etc/dnsmasq.d/090_raspap.conf
sudo cp config/090_wlan0.conf /etc/dnsmasq.d/090_wlan0.conf
sudo cp config/dhcpcd.conf /etc/dhcpcd.conf
sudo cp config/config.php /var/www/html/includes/
sudo cp config/defaults.json /etc/raspap/networking/
sudo systemctl stop systemd-networkd
sudo systemctl disable systemd-networkd
sudo cp config/raspap-bridge-br0.netdev /etc/systemd/network/raspap-bridge-br0.netdev
sudo cp config/raspap-br0-member-eth0.network /etc/systemd/network/raspap-br0-member-eth0.network 
sudo sed -i -E 's/^session\.cookie_httponly\s*=\s*(0|([O|o]ff)|([F|f]alse)|([N|n]o))\s*$/session.cookie_httponly = 1/' /etc/php/7.3/cgi/php.ini
sudo sed -i -E 's/^;?opcache\.enable\s*=\s*(0|([O|o]ff)|([F|f]alse)|([N|n]o))\s*$/opcache.enable = 1/' /etc/php/7.3/cgi/php.ini
sudo phpenmod opcache
echo "net.ipv4.ip_forward=1" | sudo tee /etc/sysctl.d/90_raspap.conf > /dev/null
sudo sysctl -p /etc/sysctl.d/90_raspap.conf
sudo /etc/init.d/procps restart
sudo iptables -t nat -A POSTROUTING -j MASQUERADE
sudo iptables -t nat -A POSTROUTING -s 192.168.50.0/24 ! -d 192.168.50.0/24 -j MASQUERADE
sudo iptables-save | sudo tee /etc/iptables/rules.v4
sudo systemctl unmask hostapd.service
sudo systemctl enable hostapd.service
sudo apt-get install openvpn
sudo sed -i "s/\('RASPI_OPENVPN_ENABLED', \)false/\1true/g" /var/www/html/includes/config.php
sudo systemctl enable openvpn-client@client
sudo mkdir /etc/raspap/openvpn/
sudo cp installers/configauth.sh /etc/raspap/openvpn/
sudo chown -c root:www-data /etc/raspap/openvpn/*.sh 
sudo chmod 750 /etc/raspap/openvpn/*.sh
sudo mkdir /etc/raspap/adblock
wget https://raw.githubusercontent.com/notracking/hosts-blocklists/master/hostnames.txt -O /tmp/hostnames.txt
wget https://raw.githubusercontent.com/notracking/hosts-blocklists/master/domains.txt -O /tmp/domains.txt
sudo cp /tmp/hostnames.txt /etc/raspap/adblock
sudo cp /tmp/domains.txt /etc/raspap/adblock 
sudo cp installers/update_blocklist.sh /etc/raspap/adblock/
sudo chown -c root:www-data /etc/raspap/adblock/*.*
sudo chmod 750 /etc/raspap/adblock/*.sh
sudo touch /etc/dnsmasq.d/090_adblock.conf
echo "conf-file=/etc/raspap/adblock/domains.txt" | sudo tee -a /etc/dnsmasq.d/090_adblock.conf > /dev/null 
echo "addn-hosts=/etc/raspap/adblock/hostnames.txt" | sudo tee -a /etc/dnsmasq.d/090_adblock.conf > /dev/null
sudo sed -i '/dhcp-option=6/d' /etc/dnsmasq.d/090_raspap.conf
sudo sed -i "s/\('RASPI_ADBLOCK_ENABLED', \)false/\1true/g" includes/config.php
sudo systemctl reboot
