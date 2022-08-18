#!/usr/bin/env bash

f='/mnt/rclone/music/Lemaitre - Relativity 1 (2012) [16B-44.1kHz]/05. Strobes, Pt. 2.flac'

cargo build

p=/home/cole/code/gst-plugins-rs/target/release
ls $p
export GST_PLUGIN_PATH=${p}:$GST_PLUGIN_PATH
export GST_PLUGIN_PATH=$PWD/target/debug:$GST_PLUGIN_PATH
echo $GST_PLUGIN_PATH
gst-launch-1.0 \
  webrtcsink name=ws \
  signaller::address="ws://0.0.0.0:9443" \
  filesrc \
  name=spot \
  location="${f}" \
  ! flacparse \
  ! flacdec \
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
