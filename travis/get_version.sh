#!/usr/bin/env bash

set -euo pipefail

# Output openvpn version from ubuntu:rolling repository
echo "$(curl -fsSL https://packages.ubuntu.com/${OS_CODENAME}/openvpn | grep 'Package:' | awk -F '(' {'print $2'} | cut -d \- -f 1)"
