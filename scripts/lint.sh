#!/usr/bin/env bash
set -euo pipefail
uv run pylint app --fail-under=8.0
