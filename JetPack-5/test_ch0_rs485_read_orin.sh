#!/bin/bash
if [ "$(whoami)" != "root" ] ; then
	echo "Please run as root"
	exit 1
fi

sudo echo 304 > /sys/class/gpio/export
sudo echo 305 > /sys/class/gpio/export
sudo echo 300 > /sys/class/gpio/export
sudo echo 306 > /sys/class/gpio/export

sudo echo high > /sys/class/gpio/gpio304/direction
sudo echo high > /sys/class/gpio/gpio305/direction
sudo echo low > /sys/class/gpio/gpio300/direction
sudo echo low > /sys/class/gpio/gpio306/direction

sudo gtkterm -p /dev/ttyTHS1 -s 115200 -w RS485

sudo echo 304 > /sys/class/gpio/unexport
sudo echo 305 > /sys/class/gpio/unexport
sudo echo 300 > /sys/class/gpio/unexport
sudo echo 306 > /sys/class/gpio/unexport

