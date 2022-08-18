#!/usr/bin/env bash

export GST_PLUGIN_PATH=$PWD/target/release:$GST_PLUGIN_PATH
gst-launch-1.0 webrtcsink name=ws \
  signaller::address="ws://0.0.0.0:9443" \
  videotestsrc ! ws. audiotestsrc ! ws.

exit 0

