FROM debian:stable-slim

ENV DEBIAN_FRONTEND=noninteractive \
    FSVIEWER_VERSION=1.3.0

# wget is required for crash reporting
RUN apt-get update \
    && apt-get install -y --no-install-recommends --no-install-suggests \
    ca-certificates \
    curl \
    desktop-file-utils \
    libappindicator3-1 \
    libasound2 \
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
    && curl -L -O -s https://github.com/feelingsurf/viewer/releases/download/v${FSVIEWER_VERSION}/FeelingSurfViewer-linux-amd64-${FSVIEWER_VERSION}.deb \
    && dpkg -i FeelingSurfViewer-linux-amd64-${FSVIEWER_VERSION}.deb \
    && rm FeelingSurfViewer-linux-amd64-${FSVIEWER_VERSION}.deb \
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
