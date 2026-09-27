#!/usr/bin/env bash
set -euo pipefail

uv run pre-commit run --all-files
