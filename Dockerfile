FROM ubuntu:bionic AS downloader

ARG OPENTTD_VERSION="1.9.3"
ARG OPENGFX_VERSION="0.5.5"

RUN apt-get update \
    && apt-get install -y curl

RUN curl --fail --silent --show-error --location https://proxy.binaries.openttd.org/openttd-releases/${OPENTTD_VERSION}/openttd-${OPENTTD_VERSION}-linux-ubuntu-bionic-amd64.deb | dpkg-deb -X - /tmp

RUN curl --fail --silent --show-error --location https://binaries.openttd.org/extra/opengfx/${OPENGFX_VERSION}/opengfx-${OPENGFX_VERSION}-all.zip \
    | tar -xzf - -C /tmp/usr/share/games/openttd/baseset

FROM ubuntu:bionic
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        libsdl1.2debian \
        libfontconfig1 \
        liblzo2-2 \
        libiculx60 \
    && rm -rf /var/lib/apt/lists/*

COPY --from=downloader /tmp/usr/games/openttd /usr/local/bin/openttd
COPY --from=downloader /tmp/usr/share/games /usr/share/games
COPY ./entrypoint.sh /

## Default port used by the game
#EXPOSE 3979/tcp
#EXPOSE 3979/udp
## Advertise in server list
#EXPOSE 3978/udp
#
#VOLUME /root/.openttd

#ENTRYPOINT ["/entrypoint.sh"]


