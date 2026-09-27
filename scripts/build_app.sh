#!/usr/bin/env bash
set -euo pipefail
uv sync --frozen
uv run python -m py_compile app/main.py
uv run python -c "import streamlit, pydantic_ai; print('Dependencies validated successfully')"
