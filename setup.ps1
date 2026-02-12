# =============================================================
# Image Prompt Generator — Setup Script (Windows PowerShell)
# =============================================================
# Installs dependencies and configures environment for first use.
#
# Usage:
#   powershell -ExecutionPolicy Bypass -File setup.ps1
# =============================================================

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Definition

Write-Host ""
Write-Host "========================================"
Write-Host "  Image Prompt Generator — Setup"
Write-Host "========================================"
Write-Host ""

# --- 1. Check Python ---
$Python = $null
if (Get-Command python3 -ErrorAction SilentlyContinue) {
    $Python = "python3"
} elseif (Get-Command python -ErrorAction SilentlyContinue) {
    $Python = "python"
}

if (-not $Python) {
    Write-Host "[ERROR] Python 3 is required but not found." -ForegroundColor Red
    Write-Host "        Install from https://www.python.org/downloads/"
    exit 1
}

$PyVersion = & $Python --version 2>&1
Write-Host "[OK] Python found: $PyVersion" -ForegroundColor Green

# --- 2. Install gallery-dl ---
$GdlInstalled = $false
try {
    $GdlVersion = & $Python -m gallery_dl --version 2>&1
    if ($LASTEXITCODE -eq 0) {
        $GdlInstalled = $true
    }
} catch {}

if ($GdlInstalled) {
    Write-Host "[OK] gallery-dl already installed: $GdlVersion" -ForegroundColor Green
} else {
    Write-Host "[...] Installing gallery-dl..."
    & $Python -m pip install --user gallery-dl
    if ($LASTEXITCODE -ne 0) {
        Write-Host "[ERROR] gallery-dl installation failed." -ForegroundColor Red
        exit 1
    }
    Write-Host "[OK] gallery-dl installed" -ForegroundColor Green
}

# --- 3. Create .env from template ---
$SkillDir = Join-Path $ScriptDir "skills\image-prompt-generator"
$EnvFile = Join-Path $SkillDir ".env"
$EnvExample = Join-Path $SkillDir ".env.example"

if (Test-Path $EnvFile) {
    Write-Host "[OK] skills\image-prompt-generator\.env already exists — skipping" -ForegroundColor Green
} elseif (Test-Path $EnvExample) {
    Copy-Item $EnvExample $EnvFile
    Write-Host "[OK] .env created in skills\image-prompt-generator\" -ForegroundColor Green
} else {
    Write-Host "[WARN] .env.example not found in skill directory — skipping .env creation" -ForegroundColor Yellow
}

Write-Host ""
Write-Host "========================================"
Write-Host "  Setup complete!"
Write-Host "========================================"
Write-Host ""
Write-Host "Next steps:"
Write-Host "  1. (Optional) Edit .env with your API credentials"
Write-Host "     Location: skills\image-prompt-generator\.env"
Write-Host "     Danbooru: https://danbooru.donmai.us/profile"
Write-Host "     Gelbooru: https://gelbooru.com/index.php?page=account&s=options"
Write-Host ""
Write-Host "  NOTE: .env setup is optional!"
Write-Host "  Claude will ask for API keys interactively if .env is not found."
Write-Host ""
Write-Host "  2. Use this skill in Claude Code or Cowork mode"
Write-Host ""
