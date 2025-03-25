#!/bin/bash
if [ "$(whoami)" != "root" ] ; then
	echo "Please run as root"
	exit 1
fi

sudo echo 312 > /sys/class/gpio/export
sudo echo 313 > /sys/class/gpio/export
sudo echo 308 > /sys/class/gpio/export
sudo echo 314 > /sys/class/gpio/export

sudo echo high > /sys/class/gpio/gpio312/direction
sudo echo low > /sys/class/gpio/gpio313/direction
sudo echo high > /sys/class/gpio/gpio308/direction
sudo echo low > /sys/class/gpio/gpio314/direction

sudo gtkterm -p /dev/ttyTHS0 -s 115200

sudo echo 312 > /sys/class/gpio/unexport
sudo echo 313 > /sys/class/gpio/unexport
sudo echo 308 > /sys/class/gpio/unexport
sudo echo 314 > /sys/class/gpio/unexport

