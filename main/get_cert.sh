#!/usr/bin/env bash

clear
echo "This script installs acme.sh and requests an SSL certificate for your marzban domain"
read -p "Enter your email: " email
read -p "Enter your domain: " domain

# Install acme.sh dependencies
apt update
apt install -y socat

# Install acme.sh
curl https://get.acme.sh | sh -s email=$email

# Get certificate
mkdir -p /var/lib/marzban/certs
~/.acme.sh/acme.sh \
  --issue --force --standalone -d "$domain" \
  --fullchain-file "/var/lib/marzban/certs/$domain.cer" \
  --key-file "/var/lib/marzban/certs/$domain.cer.key"

