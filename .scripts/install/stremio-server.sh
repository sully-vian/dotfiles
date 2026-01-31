#!/usr/bin/env bash

# Download server.js file for stremio

DIR="$HOME/.config/stremio-enhanced/streamingserver"
FILE="server.js"
mkdir -p "$DIR"

curl -fSL https://dl.strem.io/server/v4.20.12/desktop/server.js -o "$DIR/$FILE"
