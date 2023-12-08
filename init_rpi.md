# Start with RPI

- download imagge from: [https://www.raspberrypi.com/software/operating-systems/](https://www.raspberrypi.com/software/operating-systems/)
- write to sd card with : [https://downloads.raspberrypi.org/imager/imager_latest.exe](https://downloads.raspberrypi.org/imager/imager_latest.exe)
- setup watchdog: [https://diode.io/blog/running-forever-with-the-raspberry-pi-hardware-watchdog](https://diode.io/blog/running-forever-with-the-raspberry-pi-hardware-watchdog)
- docker:
```sh
sudo apt-get purge modemmanager -Y
sudo apt-get install docker-compose -Y
sudo chmod 777 /opt
cd /opt
wget https://raw.githubusercontent.com/DIOTGIT/_infos/main/homeassistant/docker-compose.yaml
wget https://raw.githubusercontent.com/DIOTGIT/_infos/main/homeassistant/docker-update.sh
sudo chmod 755 docker-update.sh
mkdir /opt/zigbee2mqtt
mkdir /opt/zigbee2mqtt/data
cd /opt/zigbee2mqtt/data
wget https://raw.githubusercontent.com/DIOTGIT/_infos/main/homeassistant/zigbee2mqtt/data/configuration.yaml
wget https://raw.githubusercontent.com/DIOTGIT/_infos/main/homeassistant/zigbee2mqtt/data/TS0601.js
mkdir /opt/mosquitto
mkdir /opt/mosquitto/config
cd /opt/mosquitto/config
wget https://raw.githubusercontent.com/DIOTGIT/_infos/main/homeassistant/mosquitto/config/mosquitto.conf
wget https://raw.githubusercontent.com/DIOTGIT/_infos/main/homeassistant/mosquitto/config/password.txt
cd /opt
sudo chown -R rpi /opt
sudo docker-compose up -d
```
