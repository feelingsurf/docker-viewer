FROM debian:bookworm-slim

ENV DEBIAN_FRONTEND=noninteractive \
    FSVIEWER_VERSION=2.5.1

LABEL org.opencontainers.image.version="${FSVIEWER_VERSION}" \
      org.opencontainers.image.title="FeelingSurf Viewer" \
      org.opencontainers.image.description="FeelingSurf Viewer in a container" \
      org.opencontainers.image.vendor="FeelingSurf" \
      org.opencontainers.image.source="https://github.com/feelingsurf/viewer" \
      org.opencontainers.image.url="https://www.feelingsurf.fr"

# Install dependencies, create user, and install FeelingSurf Viewer
RUN apt-get update \
    && apt-get install -y --no-install-recommends --no-install-suggests \
    ca-certificates \
    wget \
    libasound2 \
    libgbm1 \
    libgtk-3-0 \
    libnotify4 \
    libnss3 \
    libsecret-1-0 \
    libxss1 \
    libxtst6 \
    xdg-utils \
    xvfb \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    && groupadd -r fsviewer \
    && useradd -rm -g fsviewer -G audio fsviewer \
    && echo 'pcm.!default {\n  type plug\n  slave.pcm "null"\n}' > /etc/asound.conf \
    && arch=$(arch | sed s/aarch64/arm64/ | sed s/x86_64/amd64/) \
    && wget -q https://github.com/feelingsurf/viewer/releases/download/${FSVIEWER_VERSION}/FeelingSurfViewer-linux-${arch}-${FSVIEWER_VERSION}.deb \
    && dpkg -i FeelingSurfViewer-linux-${arch}-${FSVIEWER_VERSION}.deb \
    && rm FeelingSurfViewer-linux-${arch}-${FSVIEWER_VERSION}.deb \
    && rm -rf /usr/share/doc/* /usr/share/man/* /var/cache/debconf/* /tmp/* /var/tmp/*

WORKDIR /home/fsviewer

COPY --chmod=755 run.sh /run.sh

USER fsviewer

HEALTHCHECK --interval=1m --timeout=3s --start-period=30s \
  CMD wget --no-verbose --tries=1 --spider http://localhost:3000 || exit 1

ENTRYPOINT ["/run.sh"]
