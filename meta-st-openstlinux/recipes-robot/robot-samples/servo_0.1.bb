SUMMARY = "tangtao demo qt code"
DESCRIPTION = "tangtao demo qt code"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"
FILESEXTRAPATHS_prepend := "${THISDIR}/:"

DEPENDS = " qtcharts "
RDEPENDS_${PN} = "qtbase"

SRC_DIR = "Servo"
SRC_URI = "file://Servo/"

S = "${WORKDIR}/Servo"

inherit  qmake5

do_install() {
    install -d ${D}${bindir}
    install -m 0755 ${B}/Servo    ${D}${bindir}
}

#FILES_${PN} += "*"
FILES_${PN} = "${bindir}/*"
#FILES_${PN}-dev = "${bindir}/*"

