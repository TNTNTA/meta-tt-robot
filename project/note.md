# Note

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