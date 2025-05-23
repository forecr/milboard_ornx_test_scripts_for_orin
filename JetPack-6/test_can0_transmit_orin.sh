#!/bin/bash
if [ "$(whoami)" != "root" ] ; then
	echo "Please run as root"
	exit 1
fi

sudo modprobe can
sudo modprobe can_raw
sudo modprobe mttcan
sudo ip link set can0 up type can bitrate 500000 dbitrate 2000000 berr-reporting on fd on

gpioset --mode=signal 2 7=1 &
PID_CAN0_TERM_SEL=$!

trap interrupt_func INT
interrupt_func() {
	sudo ip link set can0 down
	kill $PID_CAN0_TERM_SEL
	read -p 'Press [Enter] to exit' quit_key
}

cangen can0 -v

