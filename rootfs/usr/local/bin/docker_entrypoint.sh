#!/bin/bash

# Make sure volumes are mounted correctly
if [[ ! -d /etc/openvpn ]]; then
    echo -e "\nError: volume '/etc/openvpn/' not mounted.\n" >&2
    exit 1
fi

# Check for configuration file: openvpn.conf
if [[ ! -e /etc/openvpn/openvpn.conf ]]; then
    echo -e "\nError: configuration file '/etc/openvpn/openvpn.conf' is missing.\n" >&2
    exit 1
fi

# Check for configuration file: ca.crt
if [[ ! -e /etc/openvpn/ca.crt ]]; then
    echo -e "\nError: configuration file '/etc/openvpn/ca.crt' is missing.\n" >&2
    exit 1
fi

# Check for configuration file: ta.key
if [[ ! -e /etc/openvpn/ta.key ]]; then
    echo -e "\nError: configuration file '/etc/openvpn/ta.key' is missing.\n" >&2
    exit 1
fi

# Check for configuration file: user.crt
if [[ ! -e /etc/openvpn/user.crt ]]; then
    echo -e "\nError: configuration file '/etc/openvpn/user.crt' is missing.\n" >&2
    exit 1
fi

# Check for configuration file: user.key
if [[ ! -e /etc/openvpn/user.key ]]; then
    echo -e "\nError: configuration file '/etc/openvpn/user.key' is missing.\n" >&2
    exit 1
fi

# Check for environment variable: VPN_GATEWAY
if [[ -z "$VPN_GATEWAY" ]]; then
    echo -e "\nError: Environment 'VPN_GATEWAY' needs to be set.\n" >&2
    exit 1
fi

# Check for environment variable: VPN_PROTOCOL
if [[ -z "$VPN_PROTOCOL" ]]; then
    echo -e "\nError: Environment 'VPN_PROTOCOL' needs to be set!.\n" >&2
    exit 1
fi

# Check for environment variable: VPN_PORT
if [[ -z "$VPN_PORT" ]]; then
    echo -e "\nError: Environment 'VPN_PORT' needs to be set!.\n" >&2
    exit 1
fi

# Check for environment variable: LAN_GATEWAY
if [[ -z "$LAN_GATEWAY" ]]; then
    echo -e "\nError: Environment 'LAN_GATEWAY' needs to be set!.\n" >&2
    exit 1
fi

# Fix user and group ownerships and secure private keys
if [[ `mount | grep '/etc/openvpn' | awk -F '(' {'print $2'} | cut -c -2` == "ro" ]]; then
    echo -e "\nWarning: volume '/etc/openvpn/' is readonly." >&2
else
    chown -R root:root /etc/openvpn
    find /etc/openvpn/. -type f -name *.key -exec chmod 0600 {} \;
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
