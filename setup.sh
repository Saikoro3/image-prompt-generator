#!/usr/bin/env bash
# =============================================================
# Image Prompt Generator — Setup Script
# =============================================================
# Installs dependencies and configures environment for first use.
#
# Usage:
#   chmod +x setup.sh && ./setup.sh
# =============================================================

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "========================================"
echo "  Image Prompt Generator — Setup"
echo "========================================"
echo ""

# --- 1. Check Python ---
if ! command -v python3 &>/dev/null && ! command -v python &>/dev/null; then
    echo "[ERROR] Python 3 is required but not found."
    echo "        Install from https://www.python.org/downloads/"
    exit 1
fi

PYTHON=$(command -v python3 || command -v python)
echo "[OK] Python found: $($PYTHON --version)"

# --- 2. Install gallery-dl ---
if $PYTHON -m gallery_dl --version &>/dev/null; then
    echo "[OK] gallery-dl already installed: $($PYTHON -m gallery_dl --version)"
else
    echo "[...] Installing gallery-dl..."
    $PYTHON -m pip install --user gallery-dl
    echo "[OK] gallery-dl installed"
fi

# --- 3. Create .env from template ---
if [ -f "$SCRIPT_DIR/.env" ]; then
    echo "[OK] .env already exists — skipping"
else
    if [ -f "$SCRIPT_DIR/.env.example" ]; then
        cp "$SCRIPT_DIR/.env.example" "$SCRIPT_DIR/.env"
        echo "[OK] .env created from .env.example"
        echo ""
        echo "  >>> IMPORTANT: Edit .env and add your API keys! <<<"
        echo "      Danbooru: https://danbooru.donmai.us/profile"
        echo "      Gelbooru: https://gelbooru.com/index.php?page=account&s=options"
    else
        echo "[WARN] .env.example not found — skipping .env creation"
    fi
fi

echo ""
echo "========================================"
echo "  Setup complete!"
echo "========================================"
echo ""
echo "Next steps:"
echo "  1. Edit .env with your API credentials"
echo "  2. Use this skill in Claude Code or Cowork mode"
echo ""
