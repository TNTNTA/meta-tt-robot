RDEPENDS_packagegroup-framework-sample-qt += " \
        ${@bb.utils.contains('DISTRO_FEATURES', 'systemd', 'systemd-robot-init', '', d)} \
        ttf-misans \
        servo \
        android-tools \
        android-tools-conf \
        adb-config \
        mt7601 \
        rtl8188 \
        ros-core \
        turtlesim \
        "

