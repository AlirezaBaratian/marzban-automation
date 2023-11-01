#!/usr/bin/env bash

clear
echo "🚫 This script installs assets for blocking Iranian hosts."
sleep 1

config() {
    mkdir -p /var/lib/marzban/assets/
    wget -O /var/lib/marzban/assets/geosite.dat https://github.com/v2fly/domain-list-community/releases/latest/download/dlc.dat
    wget -O /var/lib/marzban/assets/geoip.dat https://github.com/v2fly/geoip/releases/latest/download/geoip.dat
    wget -O /var/lib/marzban/assets/iran.dat https://github.com/bootmortis/iran-hosted-domains/releases/latest/download/iran.dat

    echo "✅ Done!\n🧢Now add this line to Marzban .env file:\nXRAY_ASSETS_PATH = \"/var/lib/marzban/assets/\""
}

config