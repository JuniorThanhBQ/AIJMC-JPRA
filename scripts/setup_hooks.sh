#!/usr/bin/env bash
set -euo pipefail

uv run pre-commit install
echo "Pre-commit hook successfully installed to .git/hooks/pre-commit"
