# Note

## 1. 移植记录
### 1.1 TFA
本小节记录移植TFA的基本流程
1. 创建仓库
使用devtool创建调试仓库
```
devtool modify -x tf-a-stm32mp src/tf-a
```
仓库路径为： build-openstlinuxeglfs-stm32mp15-robot/src/tf-a

2. 新建设备树文件并编译
首先以官方stm32mp157d-ed1开发板为参考板创建我们自己的单板设备树文件
```
cp fdts/stm32mp157d-ed1.dts fdts/stm32mp157d-robot.dts
cp fdts/stm32mp15xx-edx.dtsi fdts/stm32mp157d-robot.dtsi
```
后续所有TFA的移植都是修改我们自己的单板设备树文件
修改meta-tt-robot/meta-st-stm32mp/recipes-bsp/trusted-firmware-a/tf-a-stm32mp-config.inc中的TF_A_CONFIG配置，默认的编译目标是\${STM32MP_DEVICETREE}，暂时手动替换为stm32mp157d-robot，后续项目移植完毕以后在更改为\${STM32MP_DEVICETREE}

3. 针对外设变化修改设备树文件
本部分详细修改对比stm32mp157d-robot.dtsi文件即可，不列举具体修改
- pmic电源芯片替换为独立电源
ST官方开发板所有供电均来自PMIC芯片，我们单板上没有，需要在dts中删除相关配置并手动添加需要的电源节点
这里注意修改plat/st/stm32mp1/stm32mp1_def.h这里面的PLAT_NB_FIXED_REGS宏定义，不然会执行crash，有点坑

- 修改TF卡和EMMC设备树

- OTG和USB相关修改

4. 生成补丁并回写到原meta recipes
```
git add .
git commit -s
devtool update-recipe tf-a-stm32mp
```

### 1.2 Uboot
1. 创建调试仓库
添加uboot仓库到workspace, 在src/u-boot下面会解压源码并打补丁
```
devtool modify -x u-boot-stm32mp src/u-boot
```

2. 新建默认配置文件和设备树
默认的配置文件为configs/stm32mp15_trusted_defconfig
以官方stm32mp157d-ed1开发板为参考板创建我们自己的单板设备树文件
```
cp arch/arm/dts/stm32mp157d-ed1.dts arch/arm/dts/stm32mp157d-robot.dts
cp arch/arm/dts/stm32mp15xx-edx.dtsi arch/arm/dts/stm32mp157d-robot.dtsi
cp arch/arm/dts/stm32mp157a-ed1-u-boot.dtsi arch/arm/dts/stm32mp157d-atk-u-boot.dtsi 
```
然后在arch/arm/dts/Makefile中dtb-\$(CONFIG_STM32MP15x)配置项目下面添加stm32mp157d-robot.dtb

3. 针对外设变化修改设备树文件
主要修改点同TFA，不列举详细修改
- pmic电源芯片替换为独立电源
- 修改TF卡和EMMC设备树
- OTG和USB相关修改

4. 生成补丁并回写到原meta recipes
```
git add .
git commit -s
devtool update-recipe u-boot-stm32mp
```
5. 修改启动参数
常用启动参数设置
```
setenv bootargs 'console=ttySTM0,115200 root=/dev/mmcblk1p3 rootwait rw'
setenv bootcmd 'ext4load mmc 1:2 c2000000 uImage;ext4load mmc 1:2 c4000000 stm32mp157d-robot.dtb;bootm c2000000 - c4000000'

setenv bootargs 'console=ttySTM0,115200 root=/dev/nfs nfsroot=192.168.31.171:/home/tangtao/work/nfs/rootfs,proto=tcp rw ip=192.168.31.112:192.168.31.171:192.168.31.1:255.255.255.0::eth0:off'
setenv bootcmd  'tftp c2000000 uImage;tftp c4000000 stm32mp157d-robot.dtb;bootm c2000000 - c4000000'

```
### 1.3 Kernel
1. 创建调试仓库
添加kernel仓库到workspace, 在src/linux下面会解压源码并打补丁
```
devtool modify -x linux-stm32mp src/linux
```

2. kernel配置和更改
```
bitbake linux-stm32mp -c menuconfig
bitbake linux-stm32mp -c diffconfig
```

3. 生成补丁并回写到原meta recipes
```
git add .
git commit -s
devtool update-recipe u-boot-stm32mp
```

## 如何调试
1. bitbake查看一个bb文件有哪些任务
```
bitbake -c listtasks linux-stm32mp
```

查找某个变量和路径
```
bitbake -e linux-stm32mp | grep KERNEL_MODULES_PACKAGE
```

开发完毕如不需要可以删除工作区仓库
```
devtool reset linux-stm32mp
```