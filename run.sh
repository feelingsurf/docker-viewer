#!/bin/bash

# turn on bash's job control
set -m

rm -f /tmp/.X99-lock

/usr/bin/Xvfb :99 -screen 0 1920x1080x24 -nolisten unix &

sleep 1

export DISPLAY=":99"
export healthcheck=true
export healthcheck_port=3000

exec /usr/bin/FeelingSurfViewer \
  --disable-dev-shm-usage \
  --no-sandbox \
  --disable-gpu

fg %1
