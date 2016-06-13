#!/bin/bash
# Copyright (c) 2016 Trevor Woerner
# see LICENSE file in top-level directory

SLEEPTIME_MS=120000

if [ ! -d /sys/class/gpio/gpiochip338 ]; then
	echo "can't find /sys/class/gpio/gpiochip338, wrong board?"
	exit 1
fi

gpio_start() {
	echo 338 > /sys/class/gpio/export
	echo 339 > /sys/class/gpio/export
	echo 340 > /sys/class/gpio/export

	echo out > /sys/class/gpio/gpio338/direction
	echo out > /sys/class/gpio/gpio339/direction
	echo out > /sys/class/gpio/gpio340/direction

	echo 1 > /sys/class/gpio/gpio338/active_low
	echo 1 > /sys/class/gpio/gpio339/active_low
	echo 1 > /sys/class/gpio/gpio340/active_low

	echo 0 > /sys/class/gpio/gpio338/value
	echo 0 > /sys/class/gpio/gpio339/value
	echo 0 > /sys/class/gpio/gpio340/value
}

gpio_cleanup() {
	echo 0 > /sys/class/gpio/gpio338/value
	echo 0 > /sys/class/gpio/gpio339/value
	echo 0 > /sys/class/gpio/gpio340/value

	echo 338 > /sys/class/gpio/unexport
	echo 339 > /sys/class/gpio/unexport
	echo 340 > /sys/class/gpio/unexport
}

trap gpio_cleanup EXIT

gpio_cleanup > /dev/null 2>&1
gpio_start
while [ 1 ]; do
	# white
	echo 1 > /sys/class/gpio/gpio338/value
	echo 1 > /sys/class/gpio/gpio339/value
	echo 1 > /sys/class/gpio/gpio340/value
	usleep $SLEEPTIME_MS

	# blue + red = magenta
	echo 1 > /sys/class/gpio/gpio338/value
	echo 0 > /sys/class/gpio/gpio339/value
	echo 1 > /sys/class/gpio/gpio340/value
	usleep $SLEEPTIME_MS

	# red
	echo 1 > /sys/class/gpio/gpio338/value
	echo 0 > /sys/class/gpio/gpio339/value
	echo 0 > /sys/class/gpio/gpio340/value
	usleep $SLEEPTIME_MS

	# off
	echo 0 > /sys/class/gpio/gpio338/value
	echo 0 > /sys/class/gpio/gpio339/value
	echo 0 > /sys/class/gpio/gpio340/value
	usleep $SLEEPTIME_MS

	# blue
	echo 0 > /sys/class/gpio/gpio338/value
	echo 0 > /sys/class/gpio/gpio339/value
	echo 1 > /sys/class/gpio/gpio340/value
	usleep $SLEEPTIME_MS

	# blue + green = cyan
	echo 0 > /sys/class/gpio/gpio338/value
	echo 1 > /sys/class/gpio/gpio339/value
	echo 1 > /sys/class/gpio/gpio340/value
	usleep $SLEEPTIME_MS

	# green
	echo 0 > /sys/class/gpio/gpio338/value
	echo 1 > /sys/class/gpio/gpio339/value
	echo 0 > /sys/class/gpio/gpio340/value
	usleep $SLEEPTIME_MS

	# red + green = yellow
	echo 1 > /sys/class/gpio/gpio338/value
	echo 1 > /sys/class/gpio/gpio339/value
	echo 0 > /sys/class/gpio/gpio340/value
	usleep $SLEEPTIME_MS
done
