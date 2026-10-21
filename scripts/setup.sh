#!/usr/bin/env bash
# 换机一键配置主入口：brew → 免费效率应用 → AppDim → 系统调优
# 用法：bash scripts/setup.sh
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
STEP="$(dirname "$0")"

echo "########## 1/4 安装 Homebrew（如已有则跳过）"
bash "$STEP/install-brew.sh"

echo "########## 2/4 按 Brewfile 安装免费效率应用"
bash "$STEP/brew-casks.sh"

echo "########## 3/4 安装 AppDim 窗口变暗"
bash "$STEP/install-appdim.sh"

echo "########## 4/4 系统调优"
bash "$STEP/system-tweaks.sh"

cat <<'EOF'

================ 自动部分完成 ================
还需手动完成（付费 / App Store / 官网）：
  · Magnet（App Store，窗口分屏）
  · iStat Menus（官网，系统监控，付费）
  · BetterTouchTool 配置从旧机导出导入
  · Unclutter（官网，付费）
  · Scroll Reverser 已由 brew 安装，按需在设置里反转鼠标滚轮
  · 常用软件（浏览器/笔记/办公/沟通）见 README「常用软件参考」
新机首次使用记得到「系统设置 → 隐私与安全性」授予权限，见 README 权限清单。
==============================================
EOF
