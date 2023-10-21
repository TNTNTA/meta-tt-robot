# TT-Robot
TT-Robot是一个yocto meta-layer，用于支持TT Robot单板

## 开发环境搭建

1. 资源要求
- 软件： Ubuntu18.04
- 硬件： 内存：>8G 硬盘空间 >50G

2. 依赖库安装
- ubuntu18.04 
```
sudo apt-get install gawk wget git diffstat unzip texinfo gcc-multilib \
build-essential chrpath socat cpio python3 python3-pip python3-pexpect \
xz-utils debianutils iputils-ping python3-git python3-jinja2 libegl1-mesa libsdl1.2-dev \
pylint3 xterm \
bsdmainutils \
libssl-dev libgmp-dev libmpc-dev libyaml-dev
```

- ubuntu20.04
```
gawk wget git diffstat unzip texinfo gcc-multilib \
build-essential chrpath socat cpio python3 python3-pip python3-pexpect \
xz-utils debianutils iputils-ping python3-git python3-jinja2 libegl1-mesa libsdl1.2-dev \
pylint xterm \
bsdmainutils \
libssl-dev libgmp-dev libmpc-dev libyaml-dev
```

3. 下载完整TTRobot Yocto layer源码
```
repo init -u https://github.com/TNTNTA/robot-manifest.git
repo sync
```
同步代码以后如下所示：
```
➜  layers ls
meta-openembedded  meta-qt5  meta-ros  meta-tt-robot  openembedded-core
```

## 编译打包说明
1. 环境准备
```
DISTRO=openstlinux-eglfs MACHINE=stm32mp15-robot source layers/meta-tt-robot/scripts/envsetup.sh
```
2. 编译镜像
```
bitbake tt-robot-image-qt			        
```
3. 编译SDK
```
bitbake tt-robot-image-qt -c populate_sdk
```
4. 生成刷机包
```
// 请确认脚本执行路径，执行成功会在layers同层级目录下生成tt-robot-image文件夹
./../layers/meta-tt-robot/scripts/update_image.sh
```

## 烧录

## Q&A
1. Fetcher failure for URL: 'https://www.example.com/'. URL https://www.example.com/ doesn't work.
- 请设置代理，保证能连接外网
