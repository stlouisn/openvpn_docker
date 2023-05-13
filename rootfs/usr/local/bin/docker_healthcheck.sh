#!/bin/bash

ping -c 1 -W 3 -q google.com > /dev/null && echo OK || (killall -s SIGUSR1 openvpn; exit 1)
