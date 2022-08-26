#!/usr/bin/env bash

set -x

dname="$1"; shift
videonr="$1"; shift

v4dev="/dev/video${videonr}"
address="ws://192.168.74.236:9443"
address="ws://localhost:9443"
# address="ws://0.0.0.0:9443"
echo $GST_PLUGIN_SYSTEM_PATH
export GST_PLUGIN_PATH="${PWD}/../target/release:${GST_PLUGIN_PATH}"
gst-launch-1.0 \
  webrtcsink name="ws" signaller::address="${address}" meta="a-structure, display-name=${dname}" \
  v4l2src device=${v4dev} name="src" ! \
    videoconvert ! \
    video/x-raw ! \
  ws. \
    # pulsesrc source-output-index=4 ! audioconvert ! audio/x-raw ! audioresample ! ws.

sleep 5
