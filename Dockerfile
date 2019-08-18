FROM debian:stable-slim

ENV DEBIAN_FRONTEND=noninteractive \
    FSVIEWER_VERSION=1.2.0

RUN apt-get update \
    && apt-get install -y --no-install-recommends --no-install-suggests \
    ca-certificates \
    curl \
    libasound2 \
    libgtk-3-0 \
    libnss3 \
    libxss1 \
    libxtst6 \
    sudo \
    unzip \
    xvfb \
    && rm -r /var/lib/apt/lists/* \
    && mkdir /app \
    && curl -L -O -s https://storage.googleapis.com/feelingsurf/FeelingSurfViewer-linux-x64-${FSVIEWER_VERSION}.zip \
    && unzip -q FeelingSurfViewer-linux-x64-${FSVIEWER_VERSION}.zip -d /app\
    && rm FeelingSurfViewer-linux-x64-${FSVIEWER_VERSION}.zip \
    && groupadd -r fsviewer \
    && useradd -rm -g fsviewer fsviewer \
    && chmod 4755 /app/chrome-sandbox \
    && echo 'pcm.!default {\n\
    type plug\n\
    slave.pcm "null"\n\
}' > /etc/asound.conf

HEALTHCHECK --interval=1m --timeout=3s \
  CMD curl -f http://localhost:3000 || exit 1

USER fsviewer

COPY run.sh /run.sh

ENTRYPOINT ["/run.sh"]
