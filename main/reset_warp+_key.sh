#!/usr/bin/env bash

clear
echo "🔑 Reseting WARP+ key..."
sleep 1

main() {
    read -p "🗝 Enter your WARP+ key: " key
    read -p "🎬 Enter wgcf configs directory: " dir

    old_pattern="license_key ="
    new_line="license_key = '$key'"
    config_file="$dir/wgcf-account.toml"

    sed -i "s/$old_pattern/$new_line/" "$config_file"

    wgcf update
    wgcf generate

    search_pattern="PrivateKey = "
    config_file="$dir/wgcf-profile.conf"

    secret_key=$(grep "$search_pattern" "$config_file") | cut -d= -f2 | cut -d" " -f2

    old_pattern="\"secretKey\": "
    new_line="\"secretKey\": $secret_key"
    config_file="/var/lib/marzban/xray_config.json"

    sed -i "s/$old_pattern/$new_line/" "$config_file"

    marzban restart
}

main