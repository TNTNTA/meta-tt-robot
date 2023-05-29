# TT-Robot
TT-Robot是一个yocto meta-layer，用于支持TT Robot单板

## 开发环境搭建

1. 资源要求
- 软件： Ubuntu18.04
- 硬件： 内存：>8G 硬盘空间 >50G

2. ubuntu18.04 依赖库安装
```
sudo apt-get install gawk wget git diffstat unzip texinfo gcc-multilib \
build-essential chrpath socat cpio python3 python3-pip python3-pexpect \
xz-utils debianutils iputils-ping python3-git python3-jinja2 libegl1-mesa libsdl1.2-dev \
pylint3 xterm \
bsdmainutils \
libssl-dev libgmp-dev libmpc-dev
```
3. 下载ST 官方openSTLinux layer源码
```
// STM32MP15-Ecosystem-v3.1.0 release
repo init -u https://github.com/STMicroelectronics/oe-manifest.git  \
        -b refs/tags/openstlinux-5.10-dunfell-mp1-21-11-17
repo sync

```
4. 下载本仓库，添加到layers中
```
git clone https://github.com/TNTNTA/meta-tt-robot.git
拷贝meta-tt-robot到上面下载的layers下面：
➜  layers ls
meta-openembedded  meta-qt5  meta-st  meta-tt-robot  openembedded-core
```

## 编译说明

支持meta-tt-robot编译的指令：
```
DISTRO=openstlinux-eglfs MACHINE=stm32mp15-robot source layers/meta-tt-robot/scripts/envsetup.sh
bitbake tt-robot-image-qt			                            //编译image
bitbake tt-robot-image-qt -c populate_sdk	 //编译sdk
```

## 如何调试
本小节介绍如何修改源码并合并到meta layer中，下面以uboot仓库为例：
1. 添加uboot仓库到workspace, 在src/u-boot下面会解压源码并打补丁
```
devtool modify -x u-boot-stm32mp src/u-boot
```
2. 修改src/u-boot源码以后编译
```
devtool build u-boot-stm32mp
```
3. 生成补丁并回写到原meta recipes
```
git add .
git commit -s
devtool update-recipe u-boot-stm32mp
```
4. kernel配置和更改
```
bitbake linux-stm32mp -c menuconfig
bitbake linux-stm32mp -c diffconfig

```
## 烧录

## Q&A
1. Fetcher failure for URL: 'https://www.example.com/'. URL https://www.example.com/ doesn't work.
- 请设置代理，保证能连接外网
