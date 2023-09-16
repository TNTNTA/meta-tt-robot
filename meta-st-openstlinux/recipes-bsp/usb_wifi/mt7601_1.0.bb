SUMMARY = "tt robot mt7601 usb wifi firmware"
DESCRIPTION = "tt robot mt7601 usb wifi firmware"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"
FILESEXTRAPATHS_prepend := "${THISDIR}/:"

SRC_URI = " \
    file://MT7601.bin \
    file://RT2870STA.dat \
    "

S = "${WORKDIR}"
do_install() {
    install -d ${D}/lib/firmware
    install -d ${D}/etc/Wireless/RT2870STA

    install -m 0755 ${WORKDIR}/MT7601.bin ${D}/lib/firmware/mt7601u.bin
    install -m 0755 ${WORKDIR}/RT2870STA.dat ${D}/etc/Wireless/RT2870STA
}
FILES_${PN} = "/etc/Wireless/RT2870STA/*"
FILES_${PN} = "/lib/firmware/*"
