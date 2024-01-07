#!/bin/bash

main(){
    # Download assetes
    mkdir -p /var/lib/marzban/assets/
    wget -O /var/lib/marzban/assets/geosite.dat https://github.com/v2fly/domain-list-community/releases/latest/download/dlc.dat
    wget -O /var/lib/marzban/assets/geoip.dat https://github.com/v2fly/geoip/releases/latest/download/geoip.dat
    wget -O /var/lib/marzban/assets/iran.dat https://github.com/bootmortis/iran-hosted-domains/releases/latest/download/iran.dat
    echo 'XRAY_ASSETS_PATH = "/var/lib/marzban/assets/"' >> .env
    if [ $? -eq 0 ]; then
        echo "Done! Edit xray_config.json accordingly!"
    else
        echo "Something went wrong!"
    fi
}

main
