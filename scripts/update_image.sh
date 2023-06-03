#!/bin/bash

##############   LOG  ###################
function error() {
  echo "$(tput setaf 1)ERROR: $1$(tput sgr0)"  >&2
}

function green() {
  echo "$(tput setaf 2)$1$(tput sgr0)"
}
#########################################

#########################################
BUILD_DIR=${BBPATH}
ROOT_DIR=$(dirname "${BUILD_DIR}")
FLUSH_IMAGE_DIR="tt-robot-image"
LAYOUT_FILE_PATH="${ROOT_DIR}/layers/meta-tt-robot/project"
LAYOUT_FILE="tt_robot_emmc_flush.tsv"
IMAGE_NAME="tt-robot-image-qt"
DISTRO_NAME="openstlinux-eglfs"
MACHINE_NAME="stm32mp15-robot"

IMAGE_PATH="${BUILD_DIR}/tmp-glibc/deploy/images/${MACHINE_NAME}"
TFA_SERIALBOOT_IMAGE="${IMAGE_PATH}/arm-trusted-firmware/tf-a-stm32mp157d-robot-serialboot.stm32"
TFA_IMAGE="${IMAGE_PATH}/arm-trusted-firmware/tf-a-stm32mp157d-robot-trusted.stm32"
UBOOT_IMAGE="${IMAGE_PATH}/u-boot/u-boot-stm32mp157d-robot-trusted.stm32"
BOOTFS_IMAGE="${IMAGE_PATH}/st-image-bootfs-${DISTRO_NAME}-${MACHINE_NAME}-*.bootfs.ext4"
ROOTFS_IMAGE="${IMAGE_PATH}/${IMAGE_NAME}-${DISTRO_NAME}-${MACHINE_NAME}-*.rootfs.ext4"

########################################
if [ -z "${BUILD_DIR}" ]; then
    error "please setup yocto env first! source layers/meta-tt-robot/scripts/envsetup.sh"
    exit 0
else 
    green "ROOT_DIR: ${ROOT_DIR} BUILD_DIR: ${BUILD_DIR}"
fi

[ ! -d "${ROOT_DIR}/${FLUSH_IMAGE_DIR}" ] && mkdir -p "${ROOT_DIR}/${FLUSH_IMAGE_DIR}"

if [ -f "${TFA_IMAGE}" ] && [ -f "${TFA_SERIALBOOT_IMAGE}" ]; then
    cp -r ${TFA_IMAGE} ${ROOT_DIR}/${FLUSH_IMAGE_DIR}/tt_robot_tfa.stm32
    cp -r ${TFA_SERIALBOOT_IMAGE} ${ROOT_DIR}/${FLUSH_IMAGE_DIR}/tt_robot_tfa_serialboot.stm32
else
    green "TFA_IMAGE: ${TFA_IMAGE} not exist!"
fi

if [ -f "${UBOOT_IMAGE}" ]; then
    cp -r ${UBOOT_IMAGE} ${ROOT_DIR}/${FLUSH_IMAGE_DIR}/tt_robot_uboot.stm32
else
    green "UBOOT_IMAGE: ${UBOOT_IMAGE} not exist!"
fi

if ls ${BOOTFS_IMAGE} 1> /dev/null 2>&1; then
    cp -r ${BOOTFS_IMAGE} ${ROOT_DIR}/${FLUSH_IMAGE_DIR}/tt_robot_bootfs.ext4
else
    green "BOOTFS_IMAGE: ${BOOTFS_IMAGE} not exist!"
fi

if ls ${ROOTFS_IMAGE} 1> /dev/null 2>&1; then
    cp -r ${ROOTFS_IMAGE} ${ROOT_DIR}/${FLUSH_IMAGE_DIR}/tt_robot_rootfs.ext4
else
    green "ROOTFS_IMAGE: ${ROOTFS_IMAGE} not exist!"
fi

if [ -f "${LAYOUT_FILE_PATH}/${LAYOUT_FILE}" ]; then
    cp -r ${LAYOUT_FILE_PATH}/${LAYOUT_FILE} ${ROOT_DIR}/${FLUSH_IMAGE_DIR}/
else
    green "FLUSH_LAYOUT_FILE: ${LAYOUT_FILE_PATH}/${LAYOUT_FILE} not exist!"
fi

green "update image success! please check ${ROOT_DIR}/${FLUSH_IMAGE_DIR}"