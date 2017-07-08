FROM ubuntu:rolling

LABEL org.label-schema.description="Secure VPN Gateway" \
      org.label-schema.name="OpenVPN" \
      org.label-schema.url="https://openvpn.net/index.php/open-source/"

COPY rootfs /

RUN \

    export DEBIAN_FRONTEND=noninteractive && \

    # Update apt-cache
    apt update && \

    # Install tzdata
    apt install -y --no-install-recommends \
        tzdata && \

    # Install SSL
    apt install -y --no-install-recommends \
        ca-certificates \
        openssl && \

    # Install iptables
    apt install -y --no-install-recommends \
        iptables && \

    # Install openvpn
    apt install -y --no-install-recommends \
        openvpn && \

    # Install ping and traceroute
    apt install -y --no-install-recommends \
        iputils-ping \
        iputils-tracepath && \

    # Set docker_entrypoint as executable
    chmod 0744 /usr/local/bin/docker_entrypoint.sh && \

    # Clean apt-cache
    apt autoremove -y --purge && \
    apt autoclean -y && \

    # Cleanup temporary folders
    rm -rf \
        /root/.cache \
        /root/.wget-hsts \
        /tmp/* \
        /var/lib/apt/lists/*

ENV LC_ALL=C.UTF-8

VOLUME /etc/openvpn

ENTRYPOINT ["/usr/local/bin/docker_entrypoint.sh"]
