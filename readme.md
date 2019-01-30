[travis_logo]: https://travis-ci.org/stlouisn/openvpn_docker.svg?branch=master
[travis_url]: https://travis-ci.org/stlouisn/openvpn_docker
[docker_stars_logo]: https://img.shields.io/docker/stars/stlouisn/openvpn.svg
[docker_pulls_logo]: https://img.shields.io/docker/pulls/stlouisn/openvpn.svg
[docker_hub_url]: https://hub.docker.com/r/stlouisn/openvpn
[microbadger_url]: https://microbadger.com/images/stlouisn/openvpn
[feathub_data]: http://feathub.com/stlouisn/openvpn_docker?format=svg
[feathub_url]: http://feathub.com/stlouisn/openvpn_docker
[issues_url]: https://github.com/stlouisn/openvpn_docker/issues
[slack_url]: https://stlouisn.slack.com/messages/CBRNYGY3V

## OpenVPN Docker

[![Build Status][travis_logo]][travis_url]
[![Docker Stars][docker_stars_logo]][docker_hub_url]
[![Docker Pulls][docker_pulls_logo]][docker_hub_url]
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

OpenVPN Docker is a secure VPN Gateway for other Docker Containers. It routes external traffic through a VPN while allowing local traffing to communicate via LAN. 

### Tags

[![Version](https://images.microbadger.com/badges/version/stlouisn/openvpn.svg)][microbadger_url]
[![Layers](https://images.microbadger.com/badges/image/stlouisn/openvpn.svg)][microbadger_url]

### Feature Requests

[![Feature Requests][feathub_data]][feathub_url]

### Instructions

```bash
# Create TUN Device on Host System
mkdir -p /dev/net
mknod /dev/net/tun c 10 200
chmod 666 /dev/net/tun

# Create OpenVPN Configuration Directory
mkdir -p /docker/openvpn/config

# Copy OpenVPN Configuration File
cp config.ovpn /docker/openvpn/config/.

# Create Docker Network
docker network create \
  --driver macvlan \
  --subnet=0.0.0.0/24 \
  --gateway=0.0.0.0 \
  --opt parent=eth0.0 \
  vlan
```

### Support

[![Slack Channel](https://img.shields.io/badge/-message-no.svg?colorA=a7a7a7&colorB=3eb991&logo=slack&logoWidth=14)][slack_url]
[![GitHub Issues](https://img.shields.io/badge/-issues-no.svg?colorA=a7a7a7&colorB=e01563&logo=github&logoWidth=14)][issues_url]

### Links

*https://openvpn.net/*

*https://docs.docker.com/network/macvlan/*
