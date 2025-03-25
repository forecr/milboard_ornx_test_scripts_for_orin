#!/bin/bash
if [ "$(whoami)" != "root" ] ; then
	echo "Please run as root"
	exit 1
fi

sudo modprobe can
sudo modprobe can_raw
sudo modprobe mttcan
sudo ip link set can1 up type can bitrate 500000 dbitrate 2000000 berr-reporting on fd on

sudo echo 307 > /sys/class/gpio/export
sudo echo high > /sys/class/gpio/gpio307/direction

trap interrupt_func INT
interrupt_func() {
	sudo ip link set can1 down
	sudo echo 307 > /sys/class/gpio/unexport
	read -p 'Press [Enter] to exit' quit_key
}

cangen can1 -v

