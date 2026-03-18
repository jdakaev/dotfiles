#!/usr/bin/env bash
STREAM="https://stream-relay-geo.ntslive.net/stream2"  
mpv --input-ipc-server=/tmp/mpv-socket --volume=10 --no-video --terminal=no "$STREAM" &
for v in 15 20 25 30 40 50 60 70 80 90 100; do
  sleep 20
  echo "{ \"command\": [\"set\", \"volume\", \"$v\"] }" | socat - /tmp/mpv-socket
done
