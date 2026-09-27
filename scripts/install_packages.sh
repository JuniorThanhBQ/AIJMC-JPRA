#!/usr/bin/env bash
set -euo pipefail

uv sync --all-groups

if command -v chromium >/dev/null 2>&1; then
    echo "Found system chromium at $(command -v chromium)"
elif command -v chromium-browser >/dev/null 2>&1; then
    echo "Found system chromium at $(command -v chromium-browser)"
else
    uv run playwright install chromium
fi
