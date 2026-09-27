#!/usr/bin/env bash
set -euo pipefail

uv run streamlit run app/main.py --server.port 8501 --server.headless false
