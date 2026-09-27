#!/usr/bin/env bash
set -euo pipefail

KEY=$(python3 -c "import secrets; print(secrets.token_hex(32))")

if [ -f .env ] && grep -q "^SECRET_KEY=$" .env; then
    sed -i "s/^SECRET_KEY=$/SECRET_KEY=${KEY}/" .env
    echo "Injected generated SECRET_KEY into .env"
else
    echo "Generated SECRET_KEY: ${KEY}"
fi
