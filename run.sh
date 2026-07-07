#!/bin/bash

# Enable job control
set -m

# Clean up any stale X11 lock files
rm -f /tmp/.X99-lock

# Start Xvfb in background
/usr/bin/Xvfb :99 -screen 0 1920x1080x24 -nolisten unix &
XVFB_PID=$!

# Wait for Xvfb to be ready
sleep 1

# Export environment variables
export DISPLAY=":99"
export healthcheck=true
export healthcheck_port=3000

# Trap SIGTERM and SIGINT to gracefully shutdown
trap 'kill -TERM $XVFB_PID 2>/dev/null; exit 0' TERM INT

# Start FeelingSurf Viewer (replaces current process)
exec /usr/bin/FeelingSurfViewer \
  --disable-dev-shm-usage \
  --no-sandbox \
  --use-gl=angle \
  --use-angle=swiftshader
