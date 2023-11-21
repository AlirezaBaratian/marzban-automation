#!/usr/bin/env bash

function get_cert() {
    echo "Enter your ssl_cert_client generated by Marzban panel:
Press enter and ctrl+d when cert content is pasted."
    ssl_cert=""

    while IFS= read -r line; do
        ssl_cert+="$line"$'\n'
    done

    ssl_cert="${ssl_cert%$'\n'}"

    return $ssl_cert
}

install(cert) {
    # Install dependencies
    sudo apt install socat -y && apt install curl socat -y && apt install git -y

    # Clone the repo on /opt and get there
    sudo git clone https://github.com/Gozargah/Marzban-node /opt/Marzban-node
    cd /opt/Marzban-node

    # Install docker
    sudo curl -fsSL https://get.docker.com | sh

    # Write ssl_cert_client into a file
    cert_file="/var/lib/marzban-node/ssl_client_cert.pem"
    echo "$cert" > "$cert_file"
    chmod 644 "$cert_file"

    # Run Marzban-node
    sudo docker compose up -d

    # View the node cert
    sleep 3
    clear
    echo "Successfully installed Marzban-node. Copy the cert for the main panel setup:"
    sudo cat /var/lib/marzban-node/ssl_cert.pem

}

check_os() {
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        if [ "$ID" == "debian" ] || [ "$ID_LIKE" == "debian" ]; then
            echo "The operating system is Debian-based."
            sleep 2
            install
        else
            echo "The operating system is not Debian-based."
        fi
    else
        echo "Unable to determine the operating system."
    fi
}

function main() {
    clear
    echo "Installing Mazrban-node on /opt/"
    cert=$(get_cert)
    check_os
}

main
