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
       --subnet=192.168.100.0/24 \
       --gateway=192.168.100.1 \
       --opt parent=eth0.100 \
       private_network

#### Required Configuration Files

     /openvpn/config/
       ca.crt 
       ta.key
       user.crt
       user.key
       openvpn.conf

#### Required Environment Variables

     VPN_GATEWAY=x.x.x.x
     VPN_PROTOCOL=udp/tcp
     VPN_PORT=xxxx
     LAN_GATEWAY=x.x.x.x

#### Links

https://openvpn.net/
