#!/bin/bash
# Helpful to read output when debugging
set -x

long_delay=10
medium_delay=5
short_delay=1
echo "Beginning of startup!"

function stop_display_manager_if_running {
    # Stop dm using systemd
    if command -v systemctl; then
        if systemctl is-active --quiet "$1.service" ; then
            echo $1 >> /tmp/vfio-store-display-manager
            systemctl stop "$1.service"
        fi

        while systemctl is-active --quiet "$1.service" ; do
            sleep "${short_delay}"
        done

        return
    fi

    # Stop dm using runit
    if command -v sv; then
        if sv status $1 ; then
            echo $1 >> /tmp/vfio-store-display-manager
            sv stop $1
        fi
    fi
}


# Stop currently running display manager
if test -e "/tmp/vfio-store-display-manager" ; then
    rm -f /tmp/vfio-store-display-manager
fi

stop_display_manager_if_running sddm
stop_display_manager_if_running gdm
stop_display_manager_if_running lightdm
stop_display_manager_if_running lxdm
stop_display_manager_if_running xdm
stop_display_manager_if_running mdm
stop_display_manager_if_running display-manager

echo "End of startup!"
