FROM debian:bookworm-slim

ENV DEBIAN_FRONTEND=noninteractive \
    FSVIEWER_VERSION=2.4.0

# wget is required for crash reporting
RUN apt-get update \
    && apt-get install -y --no-install-recommends --no-install-suggests \
    ca-certificates \
    curl \
    desktop-file-utils \
    libasound2 \
    libgbm1 \
    libgtk-3-0 \
    libnotify4 \
    libnss3 \
    libsecret-1-0 \
    libxss1 \
    libxtst6 \
    sudo \
    unzip \
    wget \
    xdg-utils \
    xvfb \
    && rm -r /var/lib/apt/lists/* \
    && arch=$(arch | sed s/aarch64/arm64/ | sed s/x86_64/amd64/) \
    && curl -L -O -s -f https://github.com/feelingsurf/viewer/releases/download/${FSVIEWER_VERSION}/FeelingSurfViewer-linux-${arch}-${FSVIEWER_VERSION}.deb \
    && dpkg -i FeelingSurfViewer-linux-${arch}-${FSVIEWER_VERSION}.deb \
    && rm FeelingSurfViewer-linux-${arch}-${FSVIEWER_VERSION}.deb \
    && groupadd -r fsviewer \
    && useradd -rm -g fsviewer fsviewer \
    && echo 'pcm.!default {\n\
    type plug\n\
    slave.pcm "null"\n\
}' > /etc/asound.conf

HEALTHCHECK --interval=1m --timeout=3s \
  CMD curl -f http://localhost:3000 || exit 1

USER fsviewer

COPY run.sh /run.sh

ENTRYPOINT ["/run.sh"]
