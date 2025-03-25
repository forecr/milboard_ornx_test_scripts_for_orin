#!/bin/bash
if [ "$(whoami)" != "root" ] ; then
	echo "Please run as root"
	exit 1
fi

sudo modprobe can
sudo modprobe can_raw
sudo modprobe mttcan
sudo ip link set can0 up type can bitrate 500000 sjw 127 dsjw 15

sudo echo 315 > /sys/class/gpio/export
sudo echo high > /sys/class/gpio/gpio315/direction

trap interrupt_func INT
interrupt_func() {
	sudo ip link set can0 down
	sudo echo 315 > /sys/class/gpio/unexport
}

candump can0

