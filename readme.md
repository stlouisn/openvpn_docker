### OpenVPN Docker

*VPN Gateway with Firewall Killswitch based on Alpine Linux*

[[openvpn.net]](https://openvpn.net/)

### Create TUN Device

     mkdir -p /dev/net
     mknod /dev/net/tun c 10 200
     chmod 666 /dev/net/tun

### VPN Configuration:

     # download and save the following files in /docker/openvpn/config

     * ca.crt
     * ta.key
     * user.crt
     * user.key
     * server.conf
     
     # set the following ENV variables
     
     * VPN_GATEWAY
     * LAN_GATEWAY