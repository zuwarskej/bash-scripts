#!/bin/bash

# ------------------------------------------#
# Descryption: update packages Debian/Ubuntu
# Written by : zuwarskej
# ------------------------------------------#

# Check the root rights
root() {
	local id=$(id -u)
	if [ $id -ne 0 ]; then
		echo "You must be root user to run this script"
	exit 1
	fi
}
root

# Update and upgrade packages
if apt update && apt upgrade -yqq; then
	apt autoremove -y && apt autoclean;
fi
