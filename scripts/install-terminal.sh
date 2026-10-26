#!/usr/bin/env bash
# 配置 zsh 美化：oh-my-zsh + Powerlevel10k + autosuggestions/syntax-highlighting
# 用法：bash scripts/install-terminal.sh
# 说明：~/.zshrc 已有则备份为 ~/.zshrc.bak-时间戳，不覆盖。
set -euo pipefail

ZSH="$HOME/.oh-my-zsh"
ZSH_CUSTOM="${ZSH_CUSTOM:-$ZSH/custom}"

# 1) oh-my-zsh（已存在则跳过）
if [ ! -d "$ZSH" ]; then
  echo "== 安装 oh-my-zsh =="
  RUNZSH=no CHSH=no KEEP_ZSHRC=yes \
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
  echo "== oh-my-zsh 已存在，跳过 =="
fi

# 2) Powerlevel10k 主题
if [ ! -d "$ZSH_CUSTOM/themes/powerlevel10k" ]; then
  echo "== 安装 Powerlevel10k =="
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git \
    "$ZSH_CUSTOM/themes/powerlevel10k"
else
  echo "== Powerlevel10k 已存在，跳过 =="
fi

# 3) 常用插件（已存在则跳过）
for p in zsh-autosuggestions zsh-syntax-highlighting; do
  if [ ! -d "$ZSH_CUSTOM/plugins/$p" ]; then
    echo "== 安装插件 $p =="
    git clone --depth=1 "https://github.com/zsh-users/$p.git" "$ZSH_CUSTOM/plugins/$p"
  fi
done

# 4) 写 ~/.zshrc（仅在不存在或用户确认时；这里自动备份）
ZSHRC="$HOME/.zshrc"
if [ -f "$ZSHRC" ] && ! grep -q "# >>> powerlevel10k" "$ZSHRC" 2>/dev/null; then
  BAK="$ZSHRC.bak-$(date +%Y%m%d%H%M%S)"
  echo "== 备份现有 ~/.zshrc -> $BAK =="
  cp "$ZSHRC" "$BAK"
fi

if [ ! -f "$ZSHRC" ] || ! grep -q "ZSH_THEME=\"powerlevel10k/powerlevel10k\"" "$ZSHRC" 2>/dev/null; then
  echo "== 写入默认 ~/.zshrc =="
  cat > "$ZSHRC" <<'EOF'
# ---- oh-my-zsh ----
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"
plugins=(git z extract zsh-autosuggestions zsh-syntax-highlighting)
source $ZSH/oh-my-zsh.sh

# ---- 终端体验 ----
export LANG=en_US.UTF-8
export EDITOR="vim"
HIST_STAMPS="yyyy-mm-dd"

# 常用别名
alias ll="ls -alh"
alias ..="cd .."
alias ...="cd ../.."
alias gs="git status"
alias gc="git checkout"
alias ..g="cd .."

# ---- Powerlevel10k 配置（首次打开 iTerm2 会运行引导向导） ----
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh
EOF
fi

# 5) 确保默认 shell 是 zsh
if [ "$SHELL" != "$(command -v zsh)" ]; then
  echo "== 设置 zsh 为默认 shell（可能要求输入密码）=="
  chsh -s "$(command -v zsh)" || true
fi

echo "== 完成：重新打开 iTerm2，首次会进入 Powerlevel10k 配置向导。"
