FROM ubuntu:rolling

ARG OPENVPN_VERSION=2.4.0

ARG BUILD_DATE
ARG VCS_REF

LABEL org.label-schema.build-date=${BUILD_DATE} \
      org.label-schema.description="Secure VPN Gateway" \
      #org.label-schema.docker.cmd="" \
      org.label-schema.name="OpenVPN" \
      org.label-schema.schema-version="1.0" \
      org.label-schema.url="https://openvpn.net/" \
      org.label-schema.vcs-ref=${VCS_REF} \
      org.label-schema.vcs-url="https://github.com/stlouisn/openvpn_docker" \
      org.label-schema.vendor="stlouisn" \
      org.label-schema.version=${OPENVPN_VERSION}

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

    # Install SSL
    apt install -y --no-install-recommends \
        iptables \
        openvpn && \
        #ip6tables \

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
