#!/usr/bin/env bash

# Download server.js file for stremio

DIR="$XDG_CONFIG_HOME/stremio-enhanced/streamingserver"
FILE="server.js"
VERSION="v4.20.17"
mkdir -p "$DIR"

curl -fSL https://dl.strem.io/server/$VERSION/desktop/server.js -o "$DIR/$FILE"
