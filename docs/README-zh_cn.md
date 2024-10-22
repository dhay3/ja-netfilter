[en](https://github.com/dhay3/ja-netfilter/blob/main/README.md) | [中文](https://github.com/dhay3/ja-netfilter/blob/main/docs/README-zh_cn.md)

[![gitmoji-%20%F0%9F%98%9C%20%F0%9F%98%8D-FFDD67.svg](https://img.shields.io/badge/gitmoji-%20😜%20😍-FFDD67.svg?style=flat-square)](https://gitmoji.dev)

Linux(Xorg/Wayland) 环境下的 Jetbrains IDEs 激活工具，定时从 [ja-netfilter](https://gitee.com/ja-netfilter) 自动构建

![image](https://raw.githubusercontent.com/dhay3/ja-netfilter/refs/heads/main/assests/2024-10-22_15-10-59.png)

## 如何运行

本项目基于 
[ja-netfilter](https://gitee.com/ja-netfilter)
（它会阻止 JetBrains 激活验证的七层请求），以及
[`environment.d`](https://www.freedesktop.org/software/systemd/man/latest/environment.d.html)
让 `{JB}_VM_OPTIONS` 环境变量在任意的 DE 或者是 display manager 中都生效

## 如何使用

### 安装

1. 从 [releases page](https://github.com/dhay3/ja-netfilter/releases) 下载压缩包(不要忘记检查 sha1 校验值)
2. 解压压缩包 `bzip2 -d ja-netfilter.tar.bz2 && tar xvf ja-netfilter.tar`
3. 直接运行 `script/install.sh`，并选择想要安装的 IDE(s)
4. 从 licenses 目录下，将匹配的激活码复制到 IDE(s)
5. 登出当前用户或者是重启

### 卸载

1. 直接运行 `script/uninstall.sh`
2. 登出当前用户或者是重启

## 鸣谢

- https://zhile.io/
- https://t.me/ja_netfilter_channel
- https://gitee.com/ja-netfilter
- https://3.jetbra.in/
- https://chip-tail-e93.notion.site/Ja-netfilter-9886afbfe1ed4d5e90a713e63718f647#0c547d669d9c463d8136b4c30e156a1c

## 证书

GPLv3
