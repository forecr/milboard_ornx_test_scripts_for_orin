#!/bin/bash
if [ "$(whoami)" != "root" ] ; then
	echo "Please run as root"
	exit 1
fi

sudo modprobe can
sudo modprobe can_raw
sudo modprobe mttcan
sudo ip link set can1 up type can bitrate 500000 sjw 127 dsjw 15

gpioset --mode=signal 2 15=1 &
PID_CAN1_TERM_SEL=$!

trap interrupt_func INT
interrupt_func() {
	sudo ip link set can1 down
	kill $PID_CAN1_TERM_SEL
	read -p 'Press [Enter] to exit' quit_key
}

cangen can1 -v

