#!/usr/bin/env bash

p=/home/cole/code/gst-plugins-rs/target/debug
ls $p
export GST_PLUGIN_PATH=${p}:$GST_PLUGIN_PATH
export GST_PLUGIN_PATH=$PWD/target/debug:$GST_PLUGIN_PATH
echo $GST_PLUGIN_PATH
gst-launch-1.0 \
  webrtcsink name=ws \
  spotifyaudiosrc \
  name=spot \
  username="cole.mickens" \
  password="$(head -1 "/run/secrets/spotifypw.txt")" \
  track=spotify:track:3i3P1mGpV9eRlfKccjDjwi \
  ! oggdemux \
  ! vorbisdec \
  ! tee name=t1 \
  ! queue \
  ! audioconvert \
  ! audioresample \
  ! ws. \
  t1. \
    ! audioconvert \
    ! synaescope \
    ! videoconvert \
    ! ws.
