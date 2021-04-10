#!/bin/bash

# Descryption: set up and configure swapspace in Debian/Ubuntu

# Check the root rights
if [ "$(id -un)" != "root" ]; then
  echo "ERROR: You must be root to run this script." >&2
  exit 1
fi

# Update and upgrade packages
apt-get update && apt-get upgrade -yqq

# Install swapspace
apt-get install --reinstall swapspace

# Swap usage tune
if grep -q "vm.swappiness = 10" "/etc/sysctl.conf" > /dev/null; then
  echo @> /dev/null
else 
  echo "vm.swappiness = 10" >> /etc/sysctl.conf
fi
