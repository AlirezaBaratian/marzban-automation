#!/usr/bin/env bash

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

setup_wgcf() {
    echo -e "\n" | wgcf register
    sleep 5
    account_config="wgcf-account.toml"
    raed -p "Enter your WARP+ key: " warp_key
    sed -i "/license_key/c\license_key = '$warp_key'" $account_config
    wgcf update
    sleep 3
    wgcf generate
    sleep 3
}

update_xray_config() {
    account_profile="wgcf-profile.toml"
    private_key=$(cat $account_profile | grep "PrivateKey = " | awk ' {print $3} ')
    xray_config="/var/lib/marzban/xray_config.json"
    jq --arg private_key "$private_key" '.outbounds[1].settings.secretKey = $private_key' $xray_config > $xray_config
    marzban restart
}

function main() {
    get_warp_key
    install_dependencies
    install_wgcf
    setup_wgcf
    update_xray_config
}

main
