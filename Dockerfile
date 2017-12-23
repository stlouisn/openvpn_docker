FROM ubuntu:rolling

COPY rootfs /

RUN \

    export DEBIAN_FRONTEND=noninteractive && \

    # Update apt-cache && \
    apt-get update && \

    # Install tzdata && \
    apt-get install -y --no-install-recommends \
        tzdata && \

    # Install SSL && \
    apt-get install -y --no-install-recommends \
        ca-certificates \
        openssl && \

    # Install curl && \
    apt-get install -y --no-install-recommends \
        curl && \

    # Install gosu && \
    apt-get install -y --no-install-recommends \
        gosu && \

    # Create openvpn group && \
    groupadd \
        --system \
        --gid 9999 \
        openvpn && \

    # Create openvpn user && \
    useradd \
        --system \
        --no-create-home \
        --shell /sbin/nologin \
        --gid 9999 \
        --uid 9999 \
        openvpn && \

    # Install iptables && \
    apt-get install -y --no-install-recommends \
        iptables && \

    # Install inetutils && \
    apt-get install -y --no-install-recommends \
        inetutils-ping \
        inetutils-traceroute \
        inetutils-tools && \
    update-alternatives --install /usr/bin/ifconfig ifconfig /usr/bin/inetutils-ifconfig 1 && \

    # Install killall && \
    apt-get install -y --no-install-recommends \
        psmisc && \

    # Install openvpn && \
    apt-get install -y --no-install-recommends \
        openvpn && \

    # Remove openvpn default configuration&& \
    rm -rf /etc/openvpn && \

    # Clean apt-cache && \
    apt-get autoremove -y --purge && \
    apt-get autoclean -y && \

    # Cleanup temporary folders && \
    rm -rf \
        /root/.cache \
        /root/.wget-hsts \
        /tmp/* \
        /var/lib/apt/lists/*

VOLUME /etc/openvpn

ENTRYPOINT ["/usr/local/bin/docker_entrypoint.sh"]
