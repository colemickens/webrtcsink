#!/usr/bin/env bash

export WEBRTCSINK_SIGNALLING_SERVER_LOG=debug
cargo run --release --bin server -- --port 9443 --host 0.0.0.0
