#!/bin/bash

# turn on bash's job control
set -m

rm -f /tmp/.X99-lock

/usr/bin/Xvfb :99 -screen 0 1920x1080x24 -nolisten unix &

sleep 1

DISPLAY=":99" healthcheck=true healthcheck_port=3000 exec /usr/bin/FeelingSurfViewer

fg %1