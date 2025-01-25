#!/bin/bash

# Fájl neve: install_docker.sh

# Ellenőrizzük, hogy root jogosultsággal fut-e a szkript
if [ "$EUID" -ne 0 ]
  then echo "Kérlek, futtasd ezt a szkriptet root jogosultsággal (sudo)."
  exit
fi

# Rendszer frissítése
echo "Rendszer frissítése..."
apt update && apt upgrade -y

# Szükséges csomagok telepítése
echo "Szükséges csomagok telepítése..."
apt install -y apt-transport-https ca-certificates curl gnupg lsb-release

# Docker GPG kulcs hozzáadása
echo "Docker GPG kulcs hozzáadása..."
curl -fsSL https://download.docker.com/linux/raspbian/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# Docker repository hozzáadása
echo "Docker repository hozzáadása..."
echo "deb [arch=armhf signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/raspbian $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null

# Csomaglista frissítése
echo "Csomaglista frissítése..."
apt update

# Docker telepítése
echo "Docker telepítése..."
apt install -y docker-ce docker-ce-cli containerd.io

# Felhasználó hozzáadása a docker csoporthoz
echo "Felhasználó (rpi) hozzáadása a docker csoporthoz..."
usermod -aG docker rpi

# Docker Compose telepítése
echo "Docker Compose telepítése..."
apt install -y docker-compose

echo "A telepítés befejeződött. Kérlek, jelentkezz ki és be újra, vagy indítsd újra a rendszert a változtatások érvénybe lépéséhez."
echo "A Docker és Docker Compose verzióit a következő parancsokkal ellenőrizheted:"
echo "docker --version"
echo "docker-compose --version"
