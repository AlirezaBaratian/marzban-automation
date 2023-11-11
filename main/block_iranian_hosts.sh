#!/usr/bin/env bash

clear
echo "This script installs assets for blocking Iranian hosts."
sleep 2

config() {
    mkdir -p /var/lib/marzban/assets/
    wget -O /var/lib/marzban/assets/geosite.dat https://github.com/v2fly/domain-list-community/releases/latest/download/dlc.dat
    wget -O /var/lib/marzban/assets/geoip.dat https://github.com/v2fly/geoip/releases/latest/download/geoip.dat
    wget -O /var/lib/marzban/assets/iran.dat https://github.com/bootmortis/iran-hosted-domains/releases/latest/download/iran.dat

    echo "Done! now visit the docs to setup your routing rules:
    https://github.com/Gozargah/Marzban/discussions/38
    "
}

config