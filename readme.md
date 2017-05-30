### OpenVPN Docker

*VPN Gateway with Firewall Routing based on Alpine Linux*

[[openvpn.net]](https://openvpn.net/)

### Create TUN Device

     mkdir -p /dev/net
     mknod /dev/net/tun c 10 200
     chmod 666 /dev/net/tun

### VPN Configuration:

     # download and save the following files in openvpn/config/

     * ca.crt
     * ta.key
     * user.crt
     * user.key
     * server.conf

### Example Docker-Compose Configuration

    services:
      openvpn:
        image: stlouisn/openvpn
        container_name: openvpn
        hostname: openvpn
        labels:
          docker.openvpn.description: "secure vpn gateway"
          docker.openvpn.url: "https://openvpn.net/"
        environment:
          - TZ=Someplace/Somewhere
          - VPN_GATEWAY=123.123.123.123
          - LAN_GATEWAY=123.123.123.123
        restart: always
        volumes:
          - ./openvpn/config:/etc/openvpn:rw
        logging:
          driver: json-file
          options:
            max-size: "10m"
            max-file: "3"
        cap_add:
          - NET_ADMIN
        devices:
          - /dev/net/tun:/dev/net/tun
        networks:
          vpn_network:
            ipv4_address: 123.123.123.123
        dns: 123.123.123.123
        healthcheck:
          test: ping -c 1 -W 3 google.com
          interval: 60s
          timeout: 10s
          retries: 5