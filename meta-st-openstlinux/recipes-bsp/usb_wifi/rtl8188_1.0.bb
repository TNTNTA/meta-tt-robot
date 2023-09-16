SUMMARY = "tt robot 80211 firmware"
DESCRIPTION = "tt robot 80211 firmware"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"
FILESEXTRAPATHS_prepend := "${THISDIR}/:"

SRC_URI = " \
    file://rtl8188eufw.bin \
    "

S = "${WORKDIR}"
do_install() {
    install -d ${D}/lib/firmware/rtlwifi

    install -m 0755 ${WORKDIR}/rtl8188eufw.bin ${D}/lib/firmware/rtlwifi
}

FILES_${PN} = "/lib/firmware/rtlwifi/*"
