#!/bin/bash

# Set timezone
TZ=${TZ:-UTC}
cp /usr/share/zoneinfo/$TZ /etc/localtime
echo $TZ > /etc/timezone

# Make sure volumes are mounted correctly
if [ ! -d /etc/openvpn ]; then
    printf "\nERROR: volume \"/etc/openvpn\" not mounted.\n" >&2
    exit 1
fi

# Check for configuration file: openvpn.conf
if [ ! -e /etc/openvpn/openvpn.conf ]; then
    printf "\nERROR: configuration file \"/etc/openvpn/openvpn.conf\" missing.\n" >&2
    exit 1
fi

# Check for configuration file: ca.crt
if [ ! -e /etc/openvpn/ca.crt ]; then
    printf "\nERROR: configuration file \"/etc/openvpn/ca.crt\" missing.\n" >&2
    exit 1
fi

# Check for configuration file: ta.key
if [ ! -e /etc/openvpn/ta.key ]; then
    printf "\nERROR: configuration file \"/etc/openvpn/ta.key\" missing.\n" >&2
    exit 1
fi

# Check for configuration file: user.crt
if [ ! -e /etc/openvpn/user.crt ]; then
    printf "\nERROR: configuration file \"/etc/openvpn/user.crt\" missing.\n" >&2
    exit 1
fi

# Check for configuration file: user.key
if [ ! -e /etc/openvpn/user.key ]; then
    printf "\nERROR: configuration file \"/etc/openvpn/user.key\" missing.\n" >&2
    exit 1
fi

# Fix user and group ownerships
chown -R root:root /etc/openvpn

# Secure VPN keys
find /etc/openvpn/. -type f -name *.key -exec chmod 0600 {} \;

# Verify required environment variable - VPN_GATEWAY
if [ -z "$VPN_GATEWAY" ]; then
    echo $'\nERROR: Environment VPN_GATEWAY needs to be set!' >&2
    exit 1
fi

# Verify required environment variable - VPN_PORT
if [ -z "$VPN_PORT" ]; then
    echo $'\nERROR: Environment VPN_PORT needs to be set!' >&2
    exit 1
fi

# Verify required environment variable - VPN_PROTOCOL
if [ -z "$VPN_PROTOCOL" ]; then
    echo $'\nERROR: Environment VPN_PROTOCOL needs to be set!' >&2
    exit 1
fi

# Verify required environment variable - LAN_GATEWAY
if [ -z "$LAN_GATEWAY" ]; then
    echo $'\nERROR: Environment LAN_GATEWAY needs to be set!' >&2
    exit 1
fi

# Flush all rules
iptables -F

# Set default policy
iptables --policy FORWARD DROP
iptables --policy OUTPUT  DROP
iptables --policy INPUT   DROP 

# Allow VPN connection on ETH0
iptables -A OUTPUT -o eth0 -d $VPN_GATEWAY -p $VPN_PROTOCOL --dport $VPN_PORT -j ACCEPT
iptables -A INPUT  -i eth0 -s $VPN_GATEWAY -p $VPN_PROTOCOL --sport $VPN_PORT -j ACCEPT

# Allow ALL on TUN0
iptables -A OUTPUT -o tun0 -d 0.0.0.0/0 -j ACCEPT
iptables -A INPUT  -i tun0 -s 0.0.0.0/0 -j ACCEPT

# Allow PRIVATE NETWORKS on ETH0
iptables -A OUTPUT -o eth0 -d 192.168.0.0/16 -j ACCEPT
iptables -A INPUT  -i eth0 -s 192.168.0.0/16 -j ACCEPT

# Allow ALL on LOOPBACK
iptables -A OUTPUT -o lo -j ACCEPT
iptables -A INPUT  -i lo -j ACCEPT

# Route LOCAL NETWORK traffic to ETH0
ip route add 192.168.0.0/16 via $LAN_GATEWAY dev eth0

# Start openvpn in console mode
exec /usr/sbin/openvpn \
    --auth-nocache \
    --cd /etc/openvpn \
    --config /etc/openvpn/openvpn.conf
