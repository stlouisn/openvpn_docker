#!/usr/bin/env bash

set -euo pipefail

# OS codename
OS_CODENAME="$(curl -fsSL https://raw.githubusercontent.com/tianon/docker-brew-ubuntu-core/master/latest)"

# Application version
APP_VERSION="$(curl -fsSL --retry 5 --retry-delay 2 https://packages.ubuntu.com/$OS_CODENAME/openvpn | grep 'Package:' | awk -F '(' {'print $2'} | cut -d \- -f 1)"

# Export C_VERSION
echo "export C_VERSION=\""$APP_VERSION"\"" >> $BASH_ENV
