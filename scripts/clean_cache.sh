#!/usr/bin/env bash
set -euo pipefail

find . \( -name .venv -o -name venv -o -name node_modules -o -name .git \) -prune -o \
  \( -name "__pycache__" -o -name ".pytest_cache" -o -name ".mypy_cache" -o -name ".ruff_cache" \) -type d -exec rm -rf {} +

find . \( -name .venv -o -name venv -o -name node_modules -o -name .git \) -prune -o \
  \( -name "*.pyc" -o -name "*.pyo" -o -name "*.pyd" -o -name ".DS_Store" \) -type f -exec rm -f {} +

echo "Cache cleaned successfully"
