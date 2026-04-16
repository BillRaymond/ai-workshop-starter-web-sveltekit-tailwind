#!/usr/bin/env bash
set -euo pipefail

APP_PORT=""

for port in $(seq 5173 5190); do
  if ! lsof -iTCP:"$port" -sTCP:LISTEN >/dev/null 2>&1; then
    APP_PORT="$port"
    break
  fi
done

if [[ -z "$APP_PORT" ]]; then
  echo "No open port found in range 5173-5190."
  exit 1
fi

echo "Starting SvelteKit dev server on port $APP_PORT"

if pgrep -f "vite.*--port $APP_PORT" >/dev/null 2>&1; then
  echo "Dev server already running on port $APP_PORT"
  exit 0
fi

nohup npm run dev -- --host 0.0.0.0 --port "$APP_PORT" >/tmp/sveltekit-dev.log 2>&1 &

echo "SvelteKit dev server started on port $APP_PORT"
echo "Log file: /tmp/sveltekit-dev.log"
