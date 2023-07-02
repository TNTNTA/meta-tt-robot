#!/bin/sh

#add adb_config script to enable ADB This script configures USB Gadget
#configfs to use USB OTG as a USB Ethernet Gadget with adb

usb_role_node="/sys/class/usb_role/49000000.usb-otg-role-switch/role"
configfs="/sys/kernel/config/usb_gadget"
g=g1
c=c.1
d="${configfs}/${g}"

VENDOR_ID="0x1d6b"
PRODUCT_ID="0x0104"

do_start() {
    echo "device mode, start adb config"

    if [ ! -d ${configfs} ]; then
        modprobe libcomposite
        if [ ! -d ${configfs} ]; then
        exit 1
        fi
    fi

    udc=$(ls -1 /sys/class/udc/)
    if [ -z $udc ]; then
        echo "No UDC driver registered"
        exit 1
    fi

    if [ -d ${d} ]; then
        start-stop-daemon --start --oknodo --pidfile /var/run/adbd.pid --startas /usr/bin/adbd --background
        sleep 0.2
        echo "${udc}" > "${d}/UDC"
        exit 0
    fi

    if [ ! -d "/dev/usb-ffs/adb" ]; then
        mkdir -p /dev/usb-ffs/adb -m 0770
    fi

    mkdir "${d}"
    echo ${VENDOR_ID} > "${d}/idVendor"
    echo ${PRODUCT_ID} > "${d}/idProduct"

    mkdir -p "${d}/strings/0x409"
    echo "tt-robot-adb" > "${d}/strings/0x409/serialnumber"
    echo "STMicroelectronics" > "${d}/strings/0x409/manufacturer"
    echo "STM32MP1" > "${d}/strings/0x409/product"

    # Config
    mkdir -p "${d}/functions/ffs.adb"
    mkdir -p "${d}/configs/${c}"
    mkdir -p "${d}/configs/${c}/strings/0x409"

    ln -s  "${d}/functions/ffs.adb"  "${d}/configs/${c}"
    echo "adb" > "${d}/configs/${c}/strings/0x409/configuration"
    mount -t functionfs adb /dev/usb-ffs/adb

    start-stop-daemon --start --oknodo --pidfile /var/run/adbd.pid --startas /usr/bin/adbd --background
    sleep 0.2
    echo "${udc}" > "${d}/UDC"
}

do_stop() {
    echo "none mode"

    start-stop-daemon --stop --oknodo --pidfile /var/run/adbd.pid --retry 5
    umount /dev/usb-ffs/adb
    [ -d "${d}" ]  && echo "" > "${d}/UDC"
}

monitor_usb() {
    local usb_role=""
    while true; do
        curr_role=$(cat ${usb_role_node})
        #echo "current role: ${curr_role}"
        if [ "${curr_role}" != "${usb_role}" ]; then
            usb_role="${curr_role}"
            [ ${usb_role} == "device" ] && do_start
            [ ${usb_role} == "none" ] && do_stop
            [ ${usb_role} == "host" ] && echo "host mode"
        fi
        sleep 1
    done
}

monitor_usb