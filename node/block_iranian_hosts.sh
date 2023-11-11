#!/usr/bin/env bash

function main() {
  clear
  echo "This script downlaods iran hosts data and sets up blocking procedure for the node."

  # Download iran data into marzban assets dir
  mkdir -p /var/lib/marzban/assets/

  wget -O /var/lib/marzban/assets/geosite.dat https://github.com/v2fly/domain-list-community/releases/latest/download/dlc.dat
  wget -O /var/lib/marzban/assets/geosite.dat https://github.com/v2fly/domain-list-community/releases/latest/download/dlc.dat
  wget -O /var/lib/marzban/assets/geoip.dat https://github.com/v2fly/geoip/releases/latest/download/geoip.dat
  wget -O /var/lib/marzban/assets/iran.dat https://github.com/bootmortis/iran-hosted-domains/releases/latest/download/iran.dat

  cd /opt/Marzban-node

  # Write new docker-compose config
  echo "services:
    marzban-node:
      # build: .
      image: gozargah/marzban-node:latest
      restart: always
      network_mode: host

      volumes:
        - /var/lib/marzban-node:/var/lib/marzban-node
        - /var/lib/marzban/assets:/usr/local/share/xray" > "docker-compose.yml"
        
  # Restart marzban-node
  docker compose down && docker compose up -d
}

main
