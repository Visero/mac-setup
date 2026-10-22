#!/usr/bin/env bash
# 30：安装 AppDim（自维护的窗口变暗工具，替代停更的 AppDimmer）
# 下载 release zip，解压到 /Applications；升级时把 URL 换成新版直链即可
set -euo pipefail

URL="https://github.com/Visero/AppDim/releases/download/v1.1.3/AppDim-1.1.3.zip"
TMP="$(mktemp -d)"

echo "== 下载 AppDim：$URL"
curl -fSL --retry 2 -o "$TMP/AppDim.zip" "$URL"

echo "== 解压并安装到 /Applications"
rm -rf /Applications/AppDim.app
ditto -x -k "$TMP/AppDim.zip" /Applications/

# ad-hoc 已在打包时签名；这里兜底再签一次
codesign --force --sign - /Applications/AppDim.app 2>/dev/null || true

rm -rf "$TMP"
echo "== 完成：/Applications/AppDim.app（首次右键 → 打开放行）"
