#!/bin/bash

# Descryption: set up and configure swapspace Debian/Ubuntu

# Check the root rights
root() {
        local id=$(id -u)
        if [ $id -ne 0 ]; then
                echo "You must be root or sudo user to run this script"
        exit 1
        fi
}
root

# Update and upgrade packages
if apt update && apt upgrade -yqq; then
	apt full-upgrade -yqq;
fi

# Install swapspace
apt install --reinstall swapspace

# Swap usage tune
if grep -q "vm.swappiness = 10" "/etc/sysctl.conf" > /dev/null;	then
	echo @> /dev/null
   else echo "vm.swappiness = 10" >> /etc/sysctl.conf
fi
