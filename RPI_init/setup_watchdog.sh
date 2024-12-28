#!/bin/bash

#futtatás:
# chmod +x setup_watchdog.sh
# sudo ./setup_watchdog.sh
# sudo reboot


# Ellenőrizzük, hogy root jogosultsággal futtatjuk-e a scriptet
if [ "$EUID" -ne 0 ]
  then echo "Kérlek, futtasd ezt a scriptet root jogosultsággal (sudo)."
  exit
fi

# Rendszer frissítése és watchdog csomag telepítése
apt-get update
apt-get install -y watchdog

# Watchdog modul betöltése
modprobe bcm2835_wdt

# Watchdog szolgáltatás konfigurációs fájljának létrehozása
cat << EOF > /etc/systemd/system/watchdog.service
[Unit]
Description=Watchdog Daemon
After=multi-user.target

[Service]
Type=forking
ExecStart=/usr/sbin/watchdog -t 15 -T 60
Restart=always

[Install]
WantedBy=multi-user.target
EOF

# Watchdog konfigurációs fájl létrehozása
cat << EOF > /etc/watchdog.conf
watchdog-device = /dev/watchdog
watchdog-timeout = 15
interval = 1
realtime = yes
priority = 1
EOF

# Watchdog szolgáltatás engedélyezése és indítása
systemctl enable watchdog.service
systemctl start watchdog.service

# Kernel paraméterek beállítása a watchdog engedélyezéséhez
sed -i '$ s/$/ bcm2835_wdt.heartbeat=15/' /boot/cmdline.txt

echo "A hardware watchdog sikeresen beállítva 15 másodpercre. Kérlek, indítsd újra a Raspberry Pi-t a változtatások érvénybe lépéséhez."

