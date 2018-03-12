### OpenVPN Docker

*Secure VPN Gateway*

[![Version](https://images.microbadger.com/badges/version/stlouisn/openvpn.svg)](https://microbadger.com/images/stlouisn/openvpn)
[![Layers](https://images.microbadger.com/badges/image/stlouisn/openvpn.svg)](https://microbadger.com/images/stlouisn/openvpn)
[![Commit](https://images.microbadger.com/badges/commit/stlouisn/openvpn.svg)](https://microbadger.com/images/stlouisn/openvpn)
[![Build](https://travis-ci.org/stlouisn/openvpn_docker.svg?branch=master)](https://travis-ci.org/stlouisn/openvpn_docker)

#### Create TUN Device on Host System

     mkdir -p /dev/net
     mknod /dev/net/tun c 10 200
     chmod 666 /dev/net/tun

#### Create Docker Network ( modify as required )

     docker network create \
       --driver macvlan \
       --subnet=192.168.20.0/24 \
       --gateway=192.168.20.1 \
       --opt parent=eth0.20 \
       vlan20

#### Functional VPN Configuration Formats

     .ovpn
     .conf

#### Required Environment Variables

     VPN_GATEWAY=123.123.123.123    # <--- vpn gateway
     VPN_PORT=1234                  # <--- vpn port
     VPN_PROTOCOL=udp               # <--- tcp/udp
     LAN_GATEWAY=123.123.123.123    # <--- router IP

#### Links

https://openvpn.net/
