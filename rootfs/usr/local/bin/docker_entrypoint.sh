#!/bin/bash

#=========================================================================================

# Create TUN device
if [[ ! -d /dev/net ]]; then
    mkdir -p /dev/net
fi
if [[ ! -c /dev/net/tun ]]; then
    mknod /dev/net/tun c 10 200
    chmod 666 /dev/net/tun
fi
    
#=========================================================================================

# Make sure volume '/etc/openvpn' is mounted
if [[ ! -d /etc/openvpn ]]; then
    echo -e "\nError: Volume '/etc/openvpn' not mounted.\n" >&2
    exit 1
fi

# Make sure '.ovpn' or '.conf' file exists
for file in /etc/openvpn/*.ovpn /etc/openvpn/*.conf; do
    if [[ -f $file ]]; then
        CONFIG_FILE=$file
        break
    fi
done
if [[ -z "$CONFIG_FILE" ]]; then
    echo -e "\nError: vpn configuration file in '/etc/openvpn' not found.\n" >&2
    exit 1
fi

# Fix user and group ownerships for '/etc/openvpn'
if [[ `mount | grep '/etc/openvpn' | awk -F '(' {'print $2'} | cut -c -2` == "rw" ]]; then
    chown -R root:root /etc/openvpn
    find /etc/openvpn/. -type f -name *.key -exec chmod 0600 {} \;
fi

#=========================================================================================

# Obtain VPN_GATEWAY
export VPN_GATEWAY="$(cat $CONFIG_FILE | grep remote | head -n 1 | awk -F ' ' {'print $2'})"

# Obtain VPN_PORT
export VPN_PORT="$(cat $CONFIG_FILE | grep remote | head -n 1 | awk -F ' ' {'print $3'})"

# Obtain VPN_PORT
export VPN_PROTOCOL="$(cat $CONFIG_FILE | grep proto | head -n 1 | awk -F ' ' {'print $2'})"

# Flush firewall rules
iptables -F

# Set default policies
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
iptables -A OUTPUT -o eth0 -d 172.16.0.0/12 -j ACCEPT
iptables -A INPUT  -i eth0 -s 172.16.0.0/12 -j ACCEPT
iptables -A OUTPUT -o eth0 -d 192.168.0.0/16 -j ACCEPT
iptables -A INPUT  -i eth0 -s 192.168.0.0/16 -j ACCEPT

# Route PRIVATE NETWORKS on ETH0
ip route add 192.168.0.0/16 dev eth0

# Allow ALL on LOOPBACK
iptables -A OUTPUT -o lo -j ACCEPT
iptables -A INPUT  -i lo -j ACCEPT

#=========================================================================================

# Start openvpn in console mode
exec \
    /usr/sbin/openvpn \
    --auth-nocache \
    --cd /etc/openvpn \
    --config $CONFIG_FILE
