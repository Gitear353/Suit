#!/bin/bash
set -euo pipefail

# Only run in remote Claude Code on the web environments
if [ "${CLAUDE_CODE_REMOTE:-}" != "true" ]; then
  exit 0
fi

# Ensure Node.js >= 22 is available
NODE_VERSION=$(node --version 2>/dev/null | sed 's/v//' | cut -d. -f1 || echo "0")
if [ "$NODE_VERSION" -lt 22 ]; then
  echo "Node.js >= 22 required for HyperFrames (found: $(node --version 2>/dev/null || echo 'none'))"
  # Install Node.js 22 via nvm if available
  if command -v nvm &>/dev/null; then
    nvm install 22
    nvm use 22
  elif command -v n &>/dev/null; then
    n 22
  else
    curl -fsSL https://deb.nodesource.com/setup_22.x | bash -
    apt-get install -y nodejs
  fi
fi

# Ensure FFmpeg is available (required for npx hyperframes render)
if ! command -v ffmpeg &>/dev/null; then
  if command -v apt-get &>/dev/null; then
    apt-get install -y ffmpeg
  elif command -v brew &>/dev/null; then
    brew install ffmpeg
  else
    echo "Warning: FFmpeg not found and could not be installed automatically. Run: npx hyperframes doctor"
  fi
fi
