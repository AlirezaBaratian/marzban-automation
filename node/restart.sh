#!/usr/bin/env bash

clear
echo "🎬 Restarting Mazban-node via docker compose..."
sleep 1

restart() {
    dir="/opt/Marzban-node"
    cd "$dir"
    docker compose down
    docker compose up -d

    echo "✅ Successfully restarted Marzban-node"
}

restart