#!/bin/bash

# turn on bash's job control
set -m

/usr/bin/Xvfb :99 -screen 0 1920x1080x24 -nolisten unix &

sleep 1

DISPLAY=":99" healthcheck=true healthcheck_port=3000 exec /app/FeelingSurfViewer

fg %1