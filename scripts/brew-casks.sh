#!/usr/bin/env bash
# 10：按 Brewfile 安装免费效率应用
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"

# Apple Silicon 环境补 PATH
if [ -x /opt/homebrew/bin/brew ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

if ! command -v brew >/dev/null 2>&1; then
  echo "!! 未找到 brew，请先运行 scripts/install-brew.sh"
  exit 1
fi

brew bundle --file "$ROOT/Brewfile"
