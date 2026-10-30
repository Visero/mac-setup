# 新 Mac 效率环境一键配置

换机后复现本机效率环境：脚本自动装好免费 / 可 brew 的应用并完成系统调优，
付费、App Store、官网应用按清单手动补齐。基于本机 2026-10-14 配置整理。

## 快速开始（一键）

```bash
git clone https://github.com/Visero/mac-setup.git
cd mac-setup
bash scripts/setup.sh
```

脚本依次完成：安装 Homebrew → 按 `Brewfile` 装免费效率应用 → 配好 zsh/iTerm2 美化 → 安装 AppDim 窗口变暗 →
Dock / 时钟系统调优。过程中按提示输入开机密码即可。

> 不想克隆仓库，也可以逐个运行 `scripts/` 下的脚本。

## 自动安装（brew，脚本完成）

| 应用 | 用途 | 备注 |
|---|---|---|
| Hidden Bar | 菜单栏图标折叠 / 隐藏（Thaw 开源替代） | 分隔符拖拽式，点分隔符展开/收起 |
| Maccy | 剪贴板历史管理（开源） | 建议全局快捷键 ⌘⇧V |
| Keka | 压缩 / 解压 | |
| ImageOptim | 图片体积压缩 | |
| Scroll Reverser | 鼠标 / 触控板滚轮方向独立反转 | brew 版已带签名，无需手动清理 `._` 残留 |
| BetterTouchTool | 手势 / 触控板 / 窗口 / 快捷键全能 | 试用版；配置需从旧机导出后导入 |
| Loop | 窗口贴边 / 半屏分屏（Magnet 开源替代） | 默认触发键 ⌘+方向，建议在设置里把 Modifier 改成 ⌘⌥+方向 |
| Stats | 菜单栏系统监控（开源，替代付费 iStat Menus） | CPU/内存/网络/传感器/电池，建议开机自启 |
| iTerm2 | 终端（替代系统 Terminal） | 脚本自动配好 zsh 美化 |
| Arc | 浏览器（官方 2026-12-22 停服） | 停服后换 Dia / Zen Browser |
| Clash Verge Rev | 代理客户端（ClashX 现代继任） | 导入自己的订阅链接 |
| AppDim | 指定 App 窗口变暗（自维护，替代停更的 AppDimmer） | 脚本从 Release 拉取，首次右键 → 打开 |

对应 cask 见 [`Brewfile`](Brewfile)。

## 手动安装（付费 / App Store / 官网）

| 应用 | 用途 | 安装方式 | 备注 |
|---|---|---|---|
| iStat Menus 6 | CPU / 内存 / 温度监控（可选） | 官网（付费） | 已有免费开源替代 **Stats**（已自动安装），仅在需要更精细传感器/历史图时再装 |
| BetterTouchTool | 手势 / 全能控制 | 官网 / SetApp（付费） | brew 装的是试用版，正式授权在此 |
| Unclutter | 屏幕顶部滑出面板（剪贴板 / 文件 / 记事） | 官网（付费） | — |

## 系统调优（脚本完成）

```bash
# Dock 自动隐藏：鼠标移上立即弹出（延迟 0）
defaults write com.apple.dock autohide-delay -float 0
killall Dock

# 菜单栏时钟显示秒
defaults write com.apple.menuextra.clock ShowSeconds -bool true
killall ControlCenter
```

> 想调 Dock 弹出动画速度：`defaults write com.apple.dock autohide-time-modifier -float 0.2`（0.2 最快，0.5 适中）。

## 终端 / zsh 美化（脚本完成）

`scripts/install-terminal.sh` 自动完成：

- 安装 **oh-my-zsh**；
- 主题 **Powerlevel10k**（首次打开 iTerm2 会进入配置向导）；
- 插件 `zsh-autosuggestions`、`zsh-syntax-highlighting`、`z`；
- 写入默认 `~/.zshrc`（已有会自动备份为 `~/.zshrc.bak-时间戳`）；
- 安装 MesloLGS NF 字体（Powerlevel10k 推荐字体）；
- 把 zsh 设为默认 shell。

常用别名已内置：`ll`、`..`、`...`、`gs`、`gc`。

## 脚本说明

```
mac-setup/
├── Brewfile                # brew bundle 安装清单
├── scripts/
│   ├── setup.sh            # 一键主入口（依次调用下面全部）
│   ├── install-brew.sh      # 安装 Homebrew（已有则跳过）
│   ├── brew-casks.sh       # 按 Brewfile 装免费应用
│   ├── install-terminal.sh # zsh 美化（oh-my-zsh + Powerlevel10k）
│   ├── install-appdim.sh   # 安装 AppDim 窗口变暗
│   └── system-tweaks.sh    # Dock / 时钟 defaults 调优
└── README.md
```

## 备注

- 付费软件 iStat Menus、BetterTouchTool、Unclutter 需在新机重新购买 / 恢复授权；其中 iStat Menus 可用已自动安装的开源 Stats 替代。
- Arc 自定义玻璃图标素材与脚本需从旧机项目目录复用，本仓库不含。
- 本清单不含文件同步类工具（Syncthing / SyncTime / FreeFileSync）、CC Switch、Snipaste。
