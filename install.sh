#!/bin/bash

# Descryption: install some packages in Debian/Ubuntu

# Check the root rights
root() {
    local ID=$(id -u)
        if [ "$ID" -ne 0 ]; then
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
