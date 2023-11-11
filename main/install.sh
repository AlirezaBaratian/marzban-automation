#!/usr/bin/env bash

function main() {
    clear
    echo "💂🏼‍♀️ We're about to install Marzban on your Ubuntu server using Docker."

    sudo bash -c "$(curl -sL https://github.com/Gozargah/Marzban-scripts/raw/master/marzban.sh)" @ install
}

main
