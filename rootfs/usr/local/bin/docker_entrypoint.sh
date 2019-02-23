#!/bin/bash

#=========================================================================================

# Create TUN/TAP device
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
if [[ `mount | grep '/etc/openvpn' | awk -F '(' {'print $2'} | cut -c -2` == "rW" ]]; then
    chown -R root:root /etc/openvpn
    find /etc/openvpn/. -type f -name *.key -exec chmod 0600 {} \;
fi

#=========================================================================================	

# Start openvpn in console mode
exec \
    /usr/sbin/openvpn \
    --auth-nocache \
    --cd /etc/openvpn \
    --config $CONFIG_FILE
