FROM ubuntu:bionic AS downloader

ARG OPENTTD_VERSION="1.10.0"
ARG OPENGFX_VERSION="0.6.0"

RUN apt-get update \
    && apt-get install -y curl

RUN curl --fail --silent --show-error --location https://cdn.openttd.org/openttd-releases/${OPENTTD_VERSION}/openttd-${OPENTTD_VERSION}-linux-ubuntu-bionic-amd64.deb | dpkg-deb -X - /tmp

RUN curl --fail --silent --show-error --location https://cdn.openttd.org/opengfx-releases/${OPENGFX_VERSION}/opengfx-${OPENGFX_VERSION}-all.zip \
    | tar -xzf - -C /tmp/usr/share/games/openttd/baseset

FROM ubuntu:bionic
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        libsdl1.2debian \
        libsdl2.2 \
        libfontconfig1 \
        liblzo2-2 \
        libiculx60 \
    && rm -rf /var/lib/apt/lists/*

COPY --from=downloader /tmp/usr/games/openttd /usr/local/bin/openttd
COPY --from=downloader /tmp/usr/share/games/openttd /usr/share/games/openttd
COPY ./entrypoint.sh /
CMD ["/entrypoint.sh"]
