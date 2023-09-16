SUMMARY = "tt robot 80211 firmware"
DESCRIPTION = "tt robot 80211 firmware"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"
FILESEXTRAPATHS_prepend := "${THISDIR}/:"

SRC_URI = " \
    file://regulatory.db \
    file://regulatory.db.p7s \
    "

S = "${WORKDIR}"
do_install() {
    install -d ${D}/lib/firmware

    install -m 0755 ${WORKDIR}/regulatory.db ${D}/lib/firmware
    install -m 0755 ${WORKDIR}/regulatory.db.p7s ${D}/lib/firmware
}

FILES_${PN} = "/lib/firmware/*"
