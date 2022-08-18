#!/usr/bin/env bash

videonr="$1"; shift
display="$1"; shift

address="ws://192.168.74.236:9443"
address="ws://localhost:9443"
# address="ws://0.0.0.0:9443"
export GST_PLUGIN_PATH="${PWD}/../target/release:${GST_PLUGIN_PATH}"
gst-launch-1.0 \
  webrtcsink name="ws" signaller::address="${address}" \
  v4l2src device=/dev/video${videonr} name="src" ! \
    videoconvert ! \
    video/x-raw ! \
  ws. \
    # pulsesrc source-output-index=4 ! audioconvert ! audio/x-raw ! audioresample ! ws.

sleep 5
