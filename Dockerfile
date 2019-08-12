FROM node:slim

ENV DEBIAN_FRONTEND=noninteractive \
    FSVIEWER_VERSION=1.2.0

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    libasound2 \
    libgconf2-4 \
    libgtk-3-0 \
    libnss3 \
    libxss1 \
    libxtst6 \
    supervisor \
    unzip \
    wget \
    xvfb \
    && rm -r /var/lib/apt/lists/* \
    && mkdir -p /var/log/supervisor \
    && sed -i 's/^\(\[supervisord\]\)$/\1\nnodaemon=true/' /etc/supervisor/supervisord.conf

RUN mkdir /app \
    && wget -q https://storage.googleapis.com/feelingsurf/FeelingSurfViewer-linux-x64-${FSVIEWER_VERSION}.zip \
    && unzip -q FeelingSurfViewer-linux-x64-${FSVIEWER_VERSION}.zip -d /app\
    && rm FeelingSurfViewer-linux-x64-${FSVIEWER_VERSION}.zip

RUN groupadd -r fsviewer \
    && useradd -rm -g fsviewer fsviewer \
    && chmod 4755 /app/chrome-sandbox

COPY supervisor/xvfb.conf /etc/supervisor/conf.d/supervisor_xvfb.conf
COPY supervisor/fsviewer.conf /etc/supervisor/conf.d/supervisor_fsviewer.conf

CMD ["supervisord", "-c", "/etc/supervisor/supervisord.conf"]
