[en](https://github.com/dhay3/ja-netfilter/blob/main/README.md) | [中文](https://github.com/dhay3/ja-netfilter/blob/main/docs/README-zh_cn.md)

[![gitmoji-%20%F0%9F%98%9C%20%F0%9F%98%8D-FFDD67.svg](https://img.shields.io/badge/gitmoji-%20😜%20😍-FFDD67.svg?style=flat-square)](https://gitmoji.dev)

Jetbrains IDEs activator for Linux(Xorg/Wayland), build from [ja-netfilter](https://gitee.com/ja-netfilter) nightly.

![image](https://raw.githubusercontent.com/dhay3/ja-netfilter/refs/heads/main/assests/2024-10-22_15-10-59.png)

## How to work

This project depends on 
[ja-netfilter](https://gitee.com/ja-netfilter) 
which will block the Jetbrains activation verification's L7 requests, and
[`environment.d`](https://www.freedesktop.org/software/systemd/man/latest/environment.d.html) 
to export `{JB}_VM_OPTIONS` environments to sessions no matter which DE or display manager.

## How to Use

### Installation

1. download tarball from [releases page](https://github.com/dhay3/ja-netfilter/releases)(do forget to check the sha1 checksum)
2. extract the tarball `bzip2 -d ja-netfilter.tar && tar xvf ja-netfilter.tar`
3. run `install.sh` directly, choose which IDE(s) should be activated
4. paste the matching activation code in licenses folder to IDE(s) you want to be activated
5. log out current session or reboot

### Uninstallation

1. run `uninstall.sh` directly
2. log out current sessions or reboot

## Credit

- https://zhile.io/
- https://t.me/ja_netfilter_channel
- https://gitee.com/ja-netfilter
- https://3.jetbra.in/
- https://chip-tail-e93.notion.site/Ja-netfilter-9886afbfe1ed4d5e90a713e63718f647#0c547d669d9c463d8136b4c30e156a1c

## License

GPLv3
