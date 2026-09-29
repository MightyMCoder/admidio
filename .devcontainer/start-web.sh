#!/usr/bin/env bash
set -euo pipefail

cd /workspaces/admidio

PID_FILE="/tmp/admidio-php-server.pid"
LOG_FILE="/tmp/admidio-php-server.log"

if [[ -f "$PID_FILE" ]] && kill -0 "$(cat "$PID_FILE")" 2>/dev/null; then
    exit 0
fi

nohup php -S 0.0.0.0:8080 -t /workspaces/admidio >"$LOG_FILE" 2>&1 &
echo $! > "$PID_FILE"
