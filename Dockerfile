FROM alpine:latest

RUN \

  # Install tzdata
  apk add \
    --no-cache \
    tzdata && \

  # Install SSL
  apk add \
    --no-cache \
    ca-certificates \
    openssl && \

  # Install curl
  apk add \
    --no-cache \
    curl && \

  # Install su-exec
  apk add \
    --no-cache \
    su-exec && \

  # Install openvpn
  apk add \
    --no-cache \
    openvpn \
    iptables \
    ip6tables

COPY rootfs /

RUN chmod 0744 /usr/local/bin/docker_entrypoint.sh

VOLUME /etc/openvpn

ENTRYPOINT ["/usr/local/bin/docker_entrypoint.sh"]