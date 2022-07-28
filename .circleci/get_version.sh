#!/usr/bin/env bash

set -euo pipefail

# OS version
OS_CODENAME="$(curl -fsSL https://raw.githubusercontent.com/tianon/docker-brew-ubuntu-core/master/latest)"
OS_VERSION="$(curl -fsSL --retry 5 --retry-delay 2 http://releases.ubuntu.com/$OS_CODENAME/ | grep title | awk -F ' ' {'print $2'})"

# Application version
APP_VERSION="$(curl -fsSL --retry 5 --retry-delay 2 https://packages.ubuntu.com/$OS_CODENAME/openvpn | grep 'Package:' | awk -F '(' {'print $2'} | cut -d \- -f 1)"
echo "$APP_VERSION"