#!/bin/bash

# -----------------------------------------------------------#
# Descryption: update and install some packages Debian/Ubuntu
# Written by : zuwarskej
# -----------------------------------------------------------#

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

# Install packages
for packages in curl git wget apt-transport-https openssh-server openssh-client \
build-essential bash-completion htop lnav ncdu mc tree; do
	apt-get install -y --allow-unauthenticated $packages
done
