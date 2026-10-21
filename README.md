# 新 Mac 效率环境一键配置

换机后复现本机效率环境：脚本自动装好免费 / 可 brew 的应用并完成系统调优，
付费、App Store、官网应用按清单手动补齐。基于本机 2026-10-14 配置整理。

## 快速开始（一键）

```bash
git clone https://github.com/Visero/mac-setup.git
cd mac-setup
bash scripts/setup.sh
```

脚本依次完成：安装 Homebrew → 按 `Brewfile` 装免费效率应用 → 安装 AppDim 窗口变暗 →
Dock / 时钟系统调优。过程中按提示输入开机密码即可。

> 不想克隆仓库，也可以逐个运行 `scripts/` 下的脚本。

## 自动安装（brew，脚本完成）

| 应用 | 用途 | 备注 |
|---|---|---|
| Thaw | 菜单栏图标折叠 / 隐藏（Ice 继任版） | 首次需「屏幕录制」权限，建议开机自启 |
| Maccy | 剪贴板历史管理（开源） | 建议全局快捷键 ⌘⇧V |
| Keka | 压缩 / 解压 | |
| ImageOptim | 图片体积压缩 | |
| Scroll Reverser | 鼠标 / 触控板滚轮方向独立反转 | brew 版已带签名，无需手动清理 `._` 残留 |
| BetterTouchTool | 手势 / 触控板 / 窗口 / 快捷键全能 | 试用版；配置需从旧机导出后导入 |
| AppDim | 指定 App 窗口变暗（自维护，替代停更的 AppDimmer） | 脚本从 Release 拉取，首次右键 → 打开 |

对应 cask 见 [`Brewfile`](Brewfile)。

## 手动安装（付费 / App Store / 官网）

| 应用 | 用途 | 安装方式 | 备注 |
|---|---|---|---|
| Magnet | 窗口分屏 / 快捷键排布 | App Store（付费，需恢复购买） | 快捷键自定义 |
| iStat Menus 6 | CPU / 内存 / 温度监控 | 官网（付费） | 开机自启，配置可备份 |
| BetterTouchTool | 手势 / 全能控制 | 官网 / SetApp（付费） | brew 装的是试用版，正式授权在此 |
| Unclutter | 屏幕顶部滑出面板（剪贴板 / 文件 / 记事） | 官网（付费） | — |

## 常用软件参考（按需自行安装）

| 类别 | 应用 |
|---|---|
| 笔记 | Obsidian（第二大脑库）、Craft、MarginNote 3、Goodnotes |
| 浏览器 | Arc（主用）、Google Chrome |
| 终端 / 开发 | iTerm、Visual Studio Code、IntelliJ IDEA、PyCharm、CLion、Trae CN、Xcode |
| AI 客户端 | Doubao、DoubaoWork、Cherry Studio、DeepSeek |
| 沟通 / 办公 | WeChat、Lark、Microsoft Office 全家桶、WPS、TencentMeeting |
| 其他 | ClashX（代理）、OneDrive、极空间、Logi G HUB、SteelSeries GG |

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

## 权限清单（新机首次使用需在「系统设置 → 隐私与安全性」授予）

| 权限 | 涉及应用 |
|---|---|
| 屏幕录制 | Thaw、AppDim（读取窗口 / 菜单栏图标必需） |
| 辅助功能 | BetterTouchTool、Scroll Reverser |
| 输入监控 | Scroll Reverser（监听滚轮） |
| 通知 / 后台 | iStat Menus、Maccy |

## 脚本说明

```
mac-setup/
├── Brewfile                # brew bundle 安装清单
├── scripts/
│   ├── setup.sh            # 一键主入口（依次调用下面全部）
│   ├── install-brew.sh      # 安装 Homebrew（已有则跳过）
│   ├── brew-casks.sh       # 按 Brewfile 装免费应用
│   ├── install-appdim.sh   # 安装 AppDim 窗口变暗
│   └── system-tweaks.sh    # Dock / 时钟 defaults 调优
└── README.md
```

## 备注

- 付费软件 Magnet、iStat Menus、BetterTouchTool、Unclutter 需在新机重新购买 / 恢复授权。
- Arc 自定义玻璃图标素材与脚本需从旧机项目目录复用，本仓库不含。
- 本清单不含文件同步类工具（Syncthing / SyncTime / FreeFileSync）、CC Switch、Snipaste。
