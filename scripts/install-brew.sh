#!/usr/bin/env bash
# 00：没有 Homebrew 就安装；已有则跳过
set -euo pipefail

if command -v brew >/dev/null 2>&1; then
  echo "== Homebrew 已安装：$(brew --version | head -1)"
  exit 0
fi

echo "== 未检测到 Homebrew，开始安装（需按提示回车并输入密码）"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Apple Silicon 把 brew 加入当前 shell
if [ -x /opt/homebrew/bin/brew ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

echo "== Homebrew 安装完成：$(brew --version | head -1)"
