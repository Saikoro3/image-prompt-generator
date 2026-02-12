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
SKILL_DIR="$SCRIPT_DIR/skills/image-prompt-generator"

# Create .env in skill directory
if [ -f "$SKILL_DIR/.env" ]; then
    echo "[OK] skills/image-prompt-generator/.env already exists — skipping"
else
    if [ -f "$SKILL_DIR/.env.example" ]; then
        cp "$SKILL_DIR/.env.example" "$SKILL_DIR/.env"
        echo "[OK] .env created in skills/image-prompt-generator/"
    else
        echo "[WARN] .env.example not found in skill directory — skipping .env creation"
    fi
fi

echo ""
echo "========================================"
echo "  Setup complete!"
echo "========================================"
echo ""
echo "Next steps:"
echo "  1. (Optional) Edit .env with your API credentials"
echo "     Location: skills/image-prompt-generator/.env"
echo "     Danbooru: https://danbooru.donmai.us/profile"
echo "     Gelbooru: https://gelbooru.com/index.php?page=account&s=options"
echo ""
echo "  NOTE: .env setup is optional!"
echo "  Claude will ask for API keys interactively if .env is not found."
echo ""
echo "  2. Use this skill in Claude Code or Cowork mode"
echo ""
