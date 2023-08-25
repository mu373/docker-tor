# tor-docker

Simple Docker container for Tor.

## Getting started
```sh
# In your host
cp docker-compose-template.yml docker-compose.yml
docker compose up -d
curl -vLx socks5://0.0.0.0:9050 inet-ip.info
```
