#!/bin/bash

# Start openvpn in console mode
exec \
    /usr/sbin/openvpn \
    --auth-nocache \
    --cd /etc/openvpn \
    --config $CONFIG_FILE
