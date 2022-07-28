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

OpenVPn Docker is an image meant to be used within a Docker-Compose V2 configuration utilizing

 minimal base image that is configured for use within Docker containers and offers:

- Modifications for Docker-friendliness.
- Administration tools that are especially useful in the context of Docker.
- Mechanism for easily running processes as non-root.

- detect .ovpn configuration
- iptables to restrict traffic solely through VPN tunnel

```docker-compose
docker-compose pull
docker-compose up --detach
```

#### Links

*https://community.openvpn.net/openvpn*
