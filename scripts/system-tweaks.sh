#!/usr/bin/env bash
# 20：系统级调优（defaults）
set -euo pipefail

echo "== Dock 自动隐藏延迟设为 0（鼠标移上立即弹出）"
defaults write com.apple.dock autohide-delay -float 0
killall Dock || true

echo "== 菜单栏时钟显示秒"
defaults write com.apple.menuextra.clock ShowSeconds -bool true
killall ControlCenter || true

echo "== 系统调优完成（部分设置需重新登录后完全生效）"
