FROM stlouisn/ubuntu:latest

ARG DEBIAN_FRONTEND=noninteractive

COPY rootfs /

RUN \

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

    # Clean apt-cache
    apt-get autoremove -y --purge && \
    apt-get autoclean -y && \

    # Cleanup temporary folders
    rm -rf \
        /root/.cache \
        /root/.wget-hsts \
        /tmp/* \
        /usr/local/man \
        /usr/local/share/man \
        /usr/share/doc \
        /usr/share/doc-base \
        /usr/share/man \
        /var/cache \
        /var/lib/apt \
        /var/log/*

VOLUME /config

ENTRYPOINT ["/usr/local/bin/docker_entrypoint.sh"]
