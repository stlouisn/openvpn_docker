FROM stlouisn/ubuntu:rolling

COPY rootfs /

RUN \

    export DEBIAN_FRONTEND=noninteractive && \

    # Create openvpn group
    groupadd \
        --system \
        --gid 9999 \
        openvpn && \

    # Create openvpn user
    useradd \
        --system \
        --no-create-home \
        --shell /sbin/nologin \
        --comment openvpn \
        --gid 9999 \
        --uid 9999 \
        openvpn && \

    # Update apt-cache
    apt-get update && \

    # Install iptables
    apt-get install -y --no-install-recommends \
        iptables && \

    # Install inetutils
    apt-get install -y --no-install-recommends \
        inetutils-ping \
        inetutils-traceroute \
        inetutils-tools && \
    update-alternatives --install /usr/bin/ifconfig ifconfig /usr/bin/inetutils-ifconfig 1 && \

    # Install openvpn
    apt-get install -y --no-install-recommends \
        openvpn && \

    # Remove openvpn default configuration
    rm -rf /etc/openvpn && \

    # Create TUN/TAP device
    mkdir -p /dev/net && \
    mknod /dev/net/tun c 10 200 && \
    chmod 666 /dev/net/tun && \

    # Clean apt-cache
    apt-get autoremove -y --purge && \
    apt-get autoclean -y && \

    # Cleanup temporary folders
    rm -rf \
        /root/.cache \
        /root/.wget-hsts \
        /tmp/* \
        /var/lib/apt/lists/*

VOLUME /etc/openvpn

ENTRYPOINT ["/usr/local/bin/docker_entrypoint.sh"]
