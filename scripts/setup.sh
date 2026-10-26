#!/usr/bin/env bash
# 换机一键配置主入口：brew → 免费效率应用 → 终端美化 → AppDim → 系统调优
# 用法：bash scripts/setup.sh
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
STEP="$(dirname "$0")"

echo "########## 1/5 安装 Homebrew（如已有则跳过）"
bash "$STEP/install-brew.sh"

echo "########## 2/5 按 Brewfile 安装免费效率应用（含 Stats、iTerm2）"
bash "$STEP/brew-casks.sh"

echo "########## 3/5 配置 zsh 美化（oh-my-zsh + Powerlevel10k）"
bash "$STEP/install-terminal.sh"

echo "########## 4/5 安装 AppDim 窗口变暗"
bash "$STEP/install-appdim.sh"

echo "########## 5/5 系统调优"
bash "$STEP/system-tweaks.sh"

cat <<'EOF'

================ 自动部分完成 ================
还需手动完成（付费 / App Store / 官网）：
  · Magnet（App Store，窗口分屏）
  · iStat Menus（官网付费，可选：免费替代 Stats 已自动安装）
  · BetterTouchTool 配置从旧机导出导入
  · Unclutter（官网，付费）
  · Scroll Reverser 已由 brew 安装，按需在设置里反转鼠标滚轮
  · iTerm2 已安装，首次打开会引导 Powerlevel10k 主题
  · 常用软件（浏览器/笔记/办公/沟通）见 README「常用软件参考」
新机首次使用记得到「系统设置 → 隐私与安全性」授予权限，见 README 权限清单。
==============================================
EOF
