# docker-tor

Simple Docker container for Tor.
- Unlike other Docker images for Tor (i.e., [dperson/torproxy](https://github.com/dperson/torproxy) and [dockage/tor-privoxy](https://github.com/dockage/tor-privoxy)), this one only runs SOCKS5 proxy.
- Just the naive tor daemon. No web/HTTP proxy (Privoxy).

## Getting started
In your host machine, set up the container as following:
```sh
# Let's prepare docker-compose.yml
cp docker-compose-template.yml docker-compose.yml

# If you want to add custom torrc configuration
cp torrc.d/custom-config cp torrc.d/my-custom-config
vim torrc.d/my-custom-config

# Start the container
docker compose up -d

# Let's check if we can connect through the Tor proxy
curl -vLx socks5://localhost:9050 inet-ip.info
```
