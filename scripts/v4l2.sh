#!/usr/bin/env bash

set -x

videonr="$1"; shift
v4dev="/dev/video${videonr}"
dname="${1-"${v4dev}"}"; shift

# address="${pubaddress-"ws://localhost:9443"}"
address="${pubaddress-"ws://localhost:9443"}"

echo $GST_PLUGIN_SYSTEM_PATH
export GST_PLUGIN_PATH="${PWD}/../target/release:${GST_PLUGIN_PATH}"
gst-launch-1.0 \
  webrtcsink name="ws" signaller::address="${address}" meta="a-structure, display-name=${dname}" \
  v4l2src device=${v4dev} name="src" do-timestamp=true ! \
  image/jpeg,format=MJPG,width=1280,height=720,framerate=30/1 ! \
  jpegparse ! jpegdec ! \
  videoconvert ! \
  ws. \
  # foo
  
    # videoconvert ! \
    # pulsesrc source-output-index=4 ! audioconvert ! audio/x-raw ! audioresample ! ws.

sleep 5
