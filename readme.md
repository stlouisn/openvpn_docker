[circleci_logo]: https://circleci.com/gh/stlouisn/openvpn_docker.svg?style=svg
[circleci_url]: https://app.circleci.com/pipelines/github/stlouisn/openvpn_docker

[docker_version_logo]: http://img.shields.io/docker/v/stlouisn/openvpn/latest?arch=arm64
[docker_version_url]: https://hub.docker.com/r/stlouisn/openvpn

[docker_size_logo]: http://img.shields.io/docker/image-size/stlouisn/openvpn/latest
[docker_size_url]: https://hub.docker.com/r/stlouisn/openvpn

[docker_pulls_logo]: https://img.shields.io/docker/pulls/stlouisn/openvpn
[docker_pulls_url]: https://hub.docker.com/r/stlouisn/openvpn

[license_logo]: https://img.shields.io/github/license/stlouisn/openvpn_docker
[license_url]: https://github.com/stlouisn/openvpn_docker/blob/main/LICENSE

### OpenVPN Docker

[![Build Status][circleci_logo]][circleci_url]
[![Docker Version][docker_version_logo]][docker_version_url]
[![Docker Size][docker_size_logo]][docker_size_url]
[![Docker Pulls][docker_pulls_logo]][docker_pulls_url]
[![License][license_logo]][license_url]

OpenVPN Docker is a secure vpn gateway that is configured for use within a Docker-Compose V2 environment and allows for other containers to communicate through its VPN tunnel.

- Detects configuration file within /config volume.
- Establishes iptables to force traffic through VPN tunnel.
- Monitors health of VPN connection and resets if necessary.

```docker
curl -o docker-compose.yml -sSL https://raw.githubusercontent.com/stlouisn/openvpn_docker/main/docker-compose.yml
docker-compose pull
docker-compose up --detach
```

#### Links

*https://community.openvpn.net/openvpn*
