require ttf.inc

SUMMARY = "MiSans Font"
DESCRIPTION = "MiSans is a popular simplified Chinese font developed by XIAOMI."

LICENSE = "GPLv2"
LIC_FILES_CHKSUM = "file://COPYING;md5=05d05b3e4f84a547c864bff1863c3ac8"

SRC_URI = " \
        file://MiSans-Bold.ttf \
        file://MiSans-Demibold.ttf \
        file://MiSans-ExtraLight.ttf \
        file://MiSans-Heavy.ttf \
        file://MiSans-Light.ttf \
        file://MiSans-Medium.ttf \
        file://MiSans-Normal.ttf \
        file://MiSans-Regular.ttf \
        file://MiSans-Semibold.ttf \
        file://MiSans-Thin.ttf \
        file://COPYING \
    "

S = "${WORKDIR}"

do_install_append() {
    install -d ${D}${datadir}/fonts/ttf/
    install -m 0644 ${S}/MiSans-*.ttf ${D}${datadir}/fonts/ttf/
}

PACKAGES = "${PN}"
FONT_PACKAGES = "${PN}"

FILES_${PN} = "${datadir}/fonts"