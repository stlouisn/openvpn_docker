### OpenVPN Docker

*Secure VPN Gateway*

[![Version](https://images.microbadger.com/badges/version/stlouisn/openvpn.svg)](https://microbadger.com/images/stlouisn/openvpn)
[![Commit](https://images.microbadger.com/badges/commit/stlouisn/openvpn.svg)](https://microbadger.com/images/stlouisn/openvpn)
[![Layers](https://images.microbadger.com/badges/image/stlouisn/openvpn.svg)](https://microbadger.com/images/stlouisn/openvpn)
[![Build](https://travis-ci.org/stlouisn/openvpn_docker.svg?branch=master)](https://travis-ci.org/stlouisn/openvpn_docker)

### Installation Instructions

#### Create TUN Device

     mkdir -p /dev/net
     mknod /dev/net/tun c 10 200
     chmod 666 /dev/net/tun

#### Create Docker Network

     docker network create \
       --driver macvlan \
       --subnet=192.168.100.0/24 \
       --gateway=192.168.100.1 \
       --opt parent=eth0.100 \
     isolated_network

#### Install VPN Configuration Files

     cp ca.crt openvpn/config/.
     cp ta.key openvpn/config/.
     cp user.crt openvpn/config/.
     cp user.key openvpn/config/.
     cp server.conf openvpn/config/.

### Feature Roadmap

- Use openvpn repository instead of default ubuntu
- Update docker/labels/version script

### Links

https://openvpn.net/
