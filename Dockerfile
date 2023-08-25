FROM  debian:bookworm-slim

# Install tor from Tor project repository
# https://support.torproject.org/apt/tor-deb-repo/

RUN apt update -y && apt upgrade -y \
    && apt install -y apt-transport-https wget gpg

RUN DEBIAN_DISTRIBUTION="bookworm"\
    && echo "deb-src [signed-by=/usr/share/keyrings/tor-archive-keyring.gpg] https://deb.torproject.org/torproject.org ${DEBIAN_DISTRIBUTION} main" >> /etc/apt/sources.list.d/tor.list \
    && echo "deb     [signed-by=/usr/share/keyrings/tor-archive-keyring.gpg] https://deb.torproject.org/torproject.org ${DEBIAN_DISTRIBUTION} main" >> /etc/apt/sources.list.d/tor.list

RUN wget -qO- https://deb.torproject.org/torproject.org/A3C4F0F979CAA22CDBA8F512EE8CBC9E886DDD89.asc | gpg --dearmor | tee /usr/share/keyrings/tor-archive-keyring.gpg >/dev/null

RUN apt update -y \
    && apt install -y tor deb.torproject.org-keyring

RUN sed -i \
    -e 's/#SocksPort 192.168.0.1:9100/SocksPort 0.0.0.0:9050/g' \
    -e 's/#ControlPort 9051/ControlPort 9051/g' \
    /etc/tor/torrc \
    && mkdir /etc/torrc.d \
    && echo "%include /etc/torrc.d/" >> /etc/tor/torrc

CMD tor

EXPOSE 9050/tcp 9051/tcp
