#!/bin/bash

# Ellenőrizzük, hogy root jogosultsággal futtatjuk-e a scriptet
if [ "$EUID" -ne 0 ]; then
    echo "Kérlek, futtasd ezt a scriptet root jogosultsággal (sudo)."
    exit 1
fi

# Szükséges csomagok telepítése
apt-get update
apt-get install -y curl jq cron

# Célkönyvtár létrehozása
INSTALL_DIR="/opt/cloudflare_updater"
mkdir -p "$INSTALL_DIR"

# Konfigurációs fájl létrehozása
CONFIG_FILE="$INSTALL_DIR/.cloudflare_config"
cat > "$CONFIG_FILE" << EOL
# Cloudflare konfigurációs beállítások
AUTH_EMAIL="diothomeautomation@gmail.com"
AUTH_KEY="e639b6a6fbb85e68c96e84cfbada92b285431"
ZONE_ID="82e220d9eb07a1838228c1e5f68195f1"
RECORD_NAME="rpi.alapala.trade"
RECORD_TYPE="A"
EOL

# Fő script létrehozása
MAIN_SCRIPT="$INSTALL_DIR/update_cloudflare_dns.sh"
cat > "$MAIN_SCRIPT" << 'EOL'
#!/bin/bash

# Konfigurációs fájl betöltése
CONFIG_FILE="/opt/cloudflare_updater/.cloudflare_config"
if [ ! -f "$CONFIG_FILE" ]; then
    echo "Hiba: A konfigurációs fájl ($CONFIG_FILE) nem található."
    exit 1
fi

source "$CONFIG_FILE"

# Ellenőrizzük, hogy minden szükséges változó be van-e állítva
for VAR in AUTH_EMAIL AUTH_KEY ZONE_ID RECORD_NAME RECORD_TYPE; do
    if [ -z "${!VAR}" ]; then
        echo "Hiba: A $VAR változó nincs beállítva a konfigurációs fájlban."
        exit 1
    fi
done

# Aktuális IP cím lekérése
CURRENT_IP=$(curl -s http://ipv4.icanhazip.com)

# DNS rekord ID lekérése
RECORD_ID=$(curl -s -X GET "https://api.cloudflare.com/client/v4/zones/$ZONE_ID/dns_records?type=$RECORD_TYPE&name=$RECORD_NAME" \
     -H "X-Auth-Email: $AUTH_EMAIL" \
     -H "X-Auth-Key: $AUTH_KEY" \
     -H "Content-Type: application/json" | jq -r '.result[0].id')

# Jelenlegi DNS rekord IP címének lekérése
EXISTING_IP=$(curl -s -X GET "https://api.cloudflare.com/client/v4/zones/$ZONE_ID/dns_records/$RECORD_ID" \
     -H "X-Auth-Email: $AUTH_EMAIL" \
     -H "X-Auth-Key: $AUTH_KEY" \
     -H "Content-Type: application/json" | jq -r '.result.content')

# IP cím frissítése, ha változott
if [ "$CURRENT_IP" != "$EXISTING_IP" ]; then
    UPDATE_RESPONSE=$(curl -s -X PUT "https://api.cloudflare.com/client/v4/zones/$ZONE_ID/dns_records/$RECORD_ID" \
         -H "X-Auth-Email: $AUTH_EMAIL" \
         -H "X-Auth-Key: $AUTH_KEY" \
         -H "Content-Type: application/json" \
         --data "{\"type\":\"$RECORD_TYPE\",\"name\":\"$RECORD_NAME\",\"content\":\"$CURRENT_IP\"}")
    
    if echo "$UPDATE_RESPONSE" | jq -e '.success' > /dev/null; then
        echo "DNS rekord sikeresen frissítve. Új IP: $CURRENT_IP"
    else
        echo "Hiba történt a DNS rekord frissítése során."
        echo "Hibaüzenet: $(echo "$UPDATE_RESPONSE" | jq -r '.errors[0].message')"
    fi
else
    echo "Az IP cím nem változott. Nincs szükség frissítésre."
fi
EOL

# Jogosultságok beállítása
chmod 600 "$CONFIG_FILE"
chmod 700 "$MAIN_SCRIPT"

# Cron job beállítása (óránkénti futtatás)
CRON_JOB="0 * * * * $MAIN_SCRIPT >> $INSTALL_DIR/cloudflare_update.log 2>&1"
(crontab -l 2>/dev/null; echo "$CRON_JOB") | crontab -

echo "Telepítés befejezve. Kérlek, szerkeszd a $CONFIG_FILE fájlt a Cloudflare beállításaiddal."
echo "A script óránként fog futni és frissíteni a DNS rekordot, ha szükséges."
echo "A log fájl itt található: $INSTALL_DIR/cloudflare_update.log"
