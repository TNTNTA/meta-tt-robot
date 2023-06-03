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
修改meta-tt-robot/meta-st-stm32mp/recipes-bsp/trusted-firmware-a/tf-a-stm32mp-config.inc中的TF_A_CONFIG配置，默认的编译目标是${STM32MP_DEVICETREE}，暂时手动替换为stm32mp157d-robot，后续项目移植完毕以后在更改为${STM32MP_DEVICETREE}
3. 针对外设变化修改设备树文件
本部分详细修改对比stm32mp157d-robot.dtsi文件即可，不列举具体修改
- pmic电源芯片替换为独立电源
ST官方开发板所有供电均来自PMIC芯片，我们单板上没有，需要在dts中删除相关配置并手动添加需要的电源节点
这里注意修改plat/st/stm32mp1/stm32mp1_def.h这里面的PLAT_NB_FIXED_REGS宏定义，不然会执行crash，有点坑

- 修改TF卡和EMMC设备树
修改TF卡和EMMC设备树的部分配置

- OTG和USB相关修改

4. 生成补丁并回写到原meta recipes
```
git add .
git commit -s
devtool update-recipe tf-a-stm32mp
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