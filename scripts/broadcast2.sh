#!/usr/bin/env bash

f='/home/cole/Obi-Wan.Kenobi.S01E04.HDR.2160p.WEB.h265-KOGi[rarbg]/Obi-Wan.Kenobi.S01E04.HDR.2160p.WEB.h265-KOGi.mkv'
f='/mnt/rclone/incoming/test/trump.webm'

export GST_PLUGIN_PATH=$PWD/target/release:$GST_PLUGIN_PATH
gst-launch-1.0 \
  webrtcsink name=ws \
  signaller::address="ws://0.0.0.0:9443" \
  uridecodebin3 uri=file://${f} name=dsrc ! \
  videoconvert ! \
  video/x-raw ! \
  ws. \
    dsrc. ! audioconvert ! audio/x-raw ! audioresample ! ws.

