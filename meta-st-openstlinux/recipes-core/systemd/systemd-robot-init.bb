# Copyright (C) 2018, STMicroelectronics - All Rights Reserved
# Released under the MIT license (see COPYING.MIT for the terms)

DESCRIPTION = "The goal is to init robot env"

LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COREBASE}/meta/files/common-licenses/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

PV = "1.0"

SRC_URI = " file://tt-robot-init.service \
    file://tt_robot_init.sh \
    "

S = "${WORKDIR}/git"

inherit systemd update-rc.d

SYSTEMD_PACKAGES += "${PN}"
SYSTEMD_SERVICE_${PN} = "tt-robot-init.service"
SYSTEMD_AUTO_ENABLE_${PN} = "enable"

do_install() {
    if ${@bb.utils.contains('DISTRO_FEATURES','systemd','true','false',d)}; then
        install -d ${D}${systemd_unitdir}/system ${D}${base_sbindir}
        install -m 0644 ${WORKDIR}/tt-robot-init.service ${D}${systemd_unitdir}/system
        install -m 0755 ${WORKDIR}/tt_robot_init.sh ${D}${base_sbindir}
    fi

    install -d ${D}${sysconfdir}/init.d
    install -m 0755 ${WORKDIR}/tt_robot_init.sh ${D}${sysconfdir}/init.d/

}

INITSCRIPT_NAME = "tt_robot_init.sh"


