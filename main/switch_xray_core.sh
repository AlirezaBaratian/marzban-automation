#!/usr/bin/env bash

function main() {
    clear
    read -p "Enter your desired Xray virsion:  (Ex. v1.8.4)" version

    # Install dependencies
    apt install -y wget unzip

    # Downlaod and setup Xray core inside marzban data directory
    download_url="https://github.com/XTLS/Xray-core/releases/download/$version/Xray-linux-64.zip"
    xray_path="/var/lib/marzban/xray-core"

    mkdir -p "$xray_path" && cd "$xray_path"
    wget "$download_url"

    unzip Xray-linux-64.zip
    rm Xray-linux-64.zip

    # Switch Xray core in environemt variables
    env_path="/opt/marzban/.env"
    echo 'XRAY_EXECUTABLE_PATH = "/var/lib/marzban/xray-core/xray"' >> "$env_path"

    # Restart marzban
    marzban restart 
}

main
