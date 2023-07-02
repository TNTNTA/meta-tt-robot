# Copyright (C) 2018, STMicroelectronics - All Rights Reserved
# Released under the MIT license (see COPYING.MIT for the terms)

DESCRIPTION = "The goal is to enable USB gadget configuration"

LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COREBASE}/meta/files/common-licenses/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

PV = "1.0"

SRC_URI = " file://adb-gadget-config.service \
    file://adb_usb_gadget_config.sh \
    "

S = "${WORKDIR}/git"

inherit systemd update-rc.d

SYSTEMD_PACKAGES += "${PN}"
SYSTEMD_SERVICE_${PN} = "adb-gadget-config.service"
SYSTEMD_AUTO_ENABLE_${PN} = "enable"

do_install() {
    if ${@bb.utils.contains('DISTRO_FEATURES','systemd','true','false',d)}; then
        install -d ${D}${systemd_unitdir}/system ${D}${base_sbindir}
        install -m 0644 ${WORKDIR}/adb-gadget-config.service ${D}${systemd_unitdir}/system
        install -m 0755 ${WORKDIR}/adb_usb_gadget_config.sh ${D}${base_sbindir}
    fi

    install -d ${D}${sysconfdir}/init.d
    install -m 0755 ${WORKDIR}/adb_usb_gadget_config.sh ${D}${sysconfdir}/init.d/

}

INITSCRIPT_NAME = "adb_usb_gadget_config.sh"
INITSCRIPT_PARAMS = "start 22 5 3 ."


