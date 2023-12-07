#!/usr/bin/env bash

function get_warp_key() {
    raed -p "Enter your WARP+ key: " warp_key
}

install_dependencies() {
    apt update
    apt install -y wget 
}

install_wgcf() {
    wgcf_url="https://github.com/ViRb3/wgcf/releases/download/v2.2.19/wgcf_2.2.19_linux_amd64"
    wgcf="wgcf_2.2.19_linux_amd64"

    cd /opt
    mkdir -p wgcf
    cd wgcf

    wget $wgcf_url
    chmod +x $wgcf
    mv $wgcf wgcf
    ln -s /opt/wgcf/wgcf /usr/bin/
}

register_wgcf() {
    echo -e "\n" | wgcf register
    sleep 5
    sed -i "s/license_key/license_key = '$warp_key'/" wgcf-account.toml
    wgcf update
    sleep 3
    wgcf generate
    sleep 3
    
}

function main() {
    get_warp_key
    install_dependencies
    install_wgcf
    register_wgcf
    change_warp_key
    update_xray_config
}

main
