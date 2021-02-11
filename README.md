# Routeur-VPN

# Routeur-VPN



Here is a script only for raspberry. 

You want to config you're raspberry into an wifi host ?? 


You can use my script. I have do it for all people who don't no anything in web can do it at home. 


So let's start.

Require : 

- Raspberry 3B minimum ( i didn't test on 2 or older.)
- Raspbian OS LITE (0.4 GB version)


Setup : 

1. You need to install Raspberry in you're SD Card. 

2. After installation complete, don't forget to add SSH file into /boot in you're SD card before launch you're raspberry.

3. Now, launch you're rapsberry and connect via SSH. (ssh pi@youreip) If you don't no how to find you're local IP, you can download like Advanced IP scanner on Windows.

4. Now, you're connected with SSH. Use this commands : 

git clone https://github.com/alsharksultan/Routeur-VPN

cd Routeur-VPN

5. Now we are going to run the 1st script. It's an update script for basic update in raspberry. So :

chmod a+x update.sh
sudo ./update.sh

Wait for the script to end and reboot after process end. It's should automatic reboot.

6. Now we are going to run the script for install Raspap & hostapd.

chmod a+x raspap-install.sh
sudo ./raspap-install.sh

Answer yes to all question. Wait for the script to end and reboot after process successfully. 

Okay, now you have you should see you're wifi with name "raspi-webgui"

For access into admin panel you can go with this adress : 10.3.141.1

User : admin
Pass : secret

SSID Pass : ChangeME

For more information go here : https://github.com/RaspAP/raspap-webgui#quick-installer

But, we wan't to use a VPN for secure our connection. 

Prepare you're NORDVPN accounts. (login & pass)

Now run this : 

sudo chmod a+x nordvpn.sh
sudo ./nordvpn.sh

Answer to all question and now it's should worked as well.

If you have an issue i can try to answer, but, google is the best friend for any error. 
Like wifi locked by rfkill == you just need to enable wlan0 ..... 

Good anon surfing !!!!!!
