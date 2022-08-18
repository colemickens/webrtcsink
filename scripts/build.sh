#!/usr/bin/env bash

(
  cd ..
  cargo build --release
  cargo build --release --bin server
)
