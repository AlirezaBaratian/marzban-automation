#!/usr/bin/env bash

main() {
    apt update
    apt install -y haproxy
}

main
