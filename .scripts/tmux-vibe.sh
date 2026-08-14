#!/usr/bin/env bash

set -euo pipefail

vibe --agent chat --resume "$(jq -r 'select(.environment.working_directory == env.PWD) | .session_id' ~/.vibe/logs/session/*/meta.json | tail -n 1)"
