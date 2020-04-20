#!/bin/bash

# ------------------------------------------------------
# Descryption: update and install packages Debian/Ubuntu
# Written by : zuwarskej
# ------------------------------------------------------

# Check the root rights
root() {
	local id=$(id -u)
	if [ $id -ne 0 ]; then
		echo "You must be root user to run this script"
	exit 1
	fi
}
root

if apt update && apt upgrade -y && sudo apt autoremove -y && sudo apt autoclean; then
	 apt install -y curl git wget;
fi
