#!/usr/bin/env bash

clear
echo "🔥 Setting up Cloudflare WARP on Marzban..."

read -p "➕ Enter your WARP+ key: " warp_key


install_wgcf() {
    download_url="https://github.com/ViRb3/wgcf/releases/download/v2.2.19/wgcf_2.2.19_linux_amd64"
    install_path="/opt/wgcf"
    exe_name="wgcf"

    mkdir -p "$install_path"
    curl -o "$install_path/$exe_name" -L "$download_url"
    chmod +x "$install_path/$exe_name"
    ln -s "$install_path/$exe_name" "/usr/bin/wgcf" 
}

setup_wgcf() {
    doc_url="https://gozargah.github.io/marzban/examples/warp"
    echo "" | wgcf register
    
    # Replcae license_key with WARP+ key
    search_keyword="license_key = license_key = "
    replacement_line="license_key = '$warp_key'"

    # Use sed to replace the line
    sed -i "s/$search_keyword/$replacement_line/g" "$install_path/wgcf-account.toml"

    wgcf generate

    # Search for private key in config file and extrct the private key
    private_key=$(grep "PrivateKey =" "$install_path/wgcf-profile.conf" | cut -d "=" -f 2 | cut -d " " -f 2)

    echo "🧨 WARP is now set up.
    👇🏼 Use the config below and choose your routing strategy in $doc_url

    {
        "tag": "warp",
        "protocol": "wireguard",
        "settings": {
            "secretKey": "$private_key",
            "DNS": "1.1.1.1",
            "address": ["172.16.0.2/32", "2606:4700:110:8756:9135:af04:3778:40d9/128"],
            "peers": [
            {
                "publicKey": "bmXOC+F1FxEMF9dyiK2H5/1SUtzH0JuVo51h2wPfgyo=",
                "endpoint": "engage.cloudflareclient.com:2408"
            }
            ]
        }
    }
    "  
}

install_wgcf
setup_wgcf