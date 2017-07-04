### OpenVPN Docker

*Secure VPN Gateway*

### Docker Image

[![Version](https://images.microbadger.com/badges/version/stlouisn/openvpn.svg)](https://microbadger.com/images/stlouisn/openvpn "Get your own version badge on microbadger.com") [![](https://images.microbadger.com/badges/commit/stlouisn/openvpn.svg)](https://microbadger.com/images/stlouisn/openvpn "Get your own commit badge on microbadger.com") [![ImageLayers.io](https://images.microbadger.com/badges/image/stlouisn/openvpn.svg)](https://microbadger.com/images/stlouisn/openvpn "Get your own image badge on microbadger.com")

### Build

[![Build Status](https://travis-ci.org/stlouisn/openvpn_docker.svg?branch=master)](https://travis-ci.org/stlouisn/openvpn_docker)


### Create TUN Device

     mkdir -p /dev/net
     mknod /dev/net/tun c 10 200
     chmod 666 /dev/net/tun

### Required VPN Files

     - ca.crt
     - ta.key
     - user.crt
     - user.key
     - server.conf
       
### Links

https://openvpn.net/
