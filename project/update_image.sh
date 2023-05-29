#!/bin/bash
TOP_PATH=$(pwd)

IMAGE_PATH="${TOP_PATH}/build-openstlinuxeglfs-stm32mp15-robot/tmp-glibc/deploy/images/stm32mp15-robot"

[ -d ${IMAGE_PATH} ] && echo "start update image..."

# cp -r ${IMAGE_PATH}/kernel/uImage--5.10.61-stm32mp-r2-r0.1-stm32mp15-robot-*.bin  ~/tftp/uImage
# cp -r ${IMAGE_PATH}/kernel/stm32mp157d-robot--5.10.61-stm32mp-r2-r0.1-stm32mp15-robot-*.dtb  ~/tftp/stm32mp157d-robot.dtb
# tar -xvf ${IMAGE_PATH}/tt-robot-image-qt-openstlinux-eglfs-stm32mp15-robot-*.rootfs.tar.xz -C /home/tangtao/nfs/rootfs

cp -r ${IMAGE_PATH}/arm-trusted-firmware/tf-a-stm32mp157d-robot-trusted.stm32 ./flush_image/tf-a-robot.stm32
cp -r ${IMAGE_PATH}/u-boot/u-boot-stm32mp157d-robot-trusted.stm32 ./flush_image/u-boot-robot.stm32
cp -r ${IMAGE_PATH}/st-image-bootfs-openstlinux-eglfs-stm32mp15-robot-2023*.bootfs.ext4 ./flush_image/tt-robot-bootfs.ext4
cp -r ${IMAGE_PATH}/tt-robot-image-qt-openstlinux-eglfs-stm32mp15-robot-*.rootfs.ext4 ./flush_image/tt-robot-rootfs.ext4

echo "update image done"
exit




#cp -r ${IMAGE_PATH}/flashlayout_tt-robot-image-qt/trusted/* .


cp -r ${IMAGE_PATH}/arm-trusted-firmware . 
cp -r ${IMAGE_PATH}/u-boot . 
cp -r ${IMAGE_PATH}/st-image-bootfs*-stm32mp15-eval-*.ext4 ./st-image-bootfs-openstlinux-eglfs-stm32mp15-eval.ext4
cp -r ${IMAGE_PATH}/st-image-userfs*-stm32mp15-eval-*.ext4 ./st-image-userfs-openstlinux-eglfs-stm32mp15-eval.ext4
cp -r ${IMAGE_PATH}/st-image-vendorfs*-stm32mp15-eval-*.ext4 ./st-image-vendorfs-openstlinux-eglfs-stm32mp15-eval.ext4

 
cp -r ${IMAGE_PATH}/st-example-image-*-eval-*.ext4 ./st-example-image-qt-openstlinux-eglfs-stm32mp15-eval.ext4 



cp -r build-openstlinuxeglfs-stm32mp15-robot/tmp-glibc/deploy/images/stm32mp15-robot/u-boot/u-boot-stm32mp157d-robot-trusted.stm32 ./u-boot-robot.stm32

