# TT-Robot
TT-Robot是一个yocto meta-layer，用于支持TT Robot单板

## 开发环境搭建

1. ubuntu18.04 依赖库安装：
```
sudo apt-get install gawk wget git diffstat unzip texinfo gcc-multilib \
build-essential chrpath socat cpio python3 python3-pip python3-pexpect \
xz-utils debianutils iputils-ping python3-git python3-jinja2 libegl1-mesa libsdl1.2-dev \
pylint3 xterm \
bsdmainutils \
libssl-dev libgmp-dev libmpc-dev
```
2. 下载ST 官方openSTLinux layer源码

## 编译说明

暂时支持meta-tt-robot编译的指令(后续修改为自己的DISTRO MACHINE)：
```
DISTRO=openstlinux-eglfs MACHINE=stm32mp15-eval source layers/meta-tt-robot/scripts/envsetup.sh
bitbake st-example-image-qt
```
## 烧录

## Q&A
1. Fetcher failure for URL: 'https://www.example.com/'. URL https://www.example.com/ doesn't work.
- 请设置代理，保证能连接外网
