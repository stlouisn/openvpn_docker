FROM ubuntu:rolling

COPY docker.rootfs /

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

    # Install curl
    apt install -y --no-install-recommends \
        curl && \

    # Install gosu
    apt install -y --no-install-recommends \
        gosu && \

    # Create dockeruser group
    groupadd \
        --system \
        --gid 9999 \
        dockeruser && \

    # Create dockeruser user
    useradd \
        --system \
        --no-create-home \
        --shell /sbin/nologin \
        --gid 9999 \
        --uid 9999 \
        dockeruser && \

    # Install iptables
    apt install -y --no-install-recommends \
        iptables && \

    # Install ping and traceroute
    apt install -y --no-install-recommends \
        iputils-ping \
        iputils-tracepath && \

    export OPENVPN_VERSION=`curl -sSL https://raw.githubusercontent.com/stlouisn/openvpn_docker/master/docker.labels/version | bash` && \

    # Install openvpn
    apt install -y --no-install-recommends \
        openvpn && \

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

VOLUME /etc/openvpn

ENTRYPOINT ["/usr/local/bin/docker_entrypoint.sh"]
