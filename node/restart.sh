#!/usr/bin/env bash

restart() {
    dir="/opt/Marzban-node"
    cd "$dir"
    docker compose down
    docker compose up -d

    echo "✅ Successfully restarted Marzban-node"
}

function main() {
    clear
    echo "🎬 Restarting Mazban-node via docker compose..."
    sleep 1
    restart
}

main
