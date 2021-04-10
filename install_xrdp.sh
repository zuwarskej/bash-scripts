#!/bin/bash

# Description: install and configure xrdp in Ubuntu

# Check the root rights
if [ "$(id -un)" != "root" ]; then
  echo "ERROR: You must be root to run this script." >&2
  exit 1
fi

# Check supported system
[ ! -f /etc/os-release ] && \
  echo "Can\'t find /etc/os-release - Can\'t identify system!" && exit 1;

. /etc/os-release
SUPPORTED=false
for i in 18.04 20.04;  do
    [ "$VERSION_ID" == "$i" ] && SUPPORTED=true
done
[ ! "$SUPPORTED" == true ] && echo "System: $ID $VERSION_ID not supported!" && exit 1;

# Update packages
apt-get update && apt-get upgrade -yqq

# Install xrdp
if apt-get install -y --reinstall xfce4 xfce4-goodies xorg dbus-x11 x11-xserver-utils; then
  apt-get install -y --reinstall xrdp;
fi

# Add user to group ssl-cert
echo "Enter your username"
read -r group_user
usermod -a -G ssl-cert "$group_user"

# Add options to xrdp.ini
if grep -R "exec startxfce4" /etc/xrdp/xrdp.ini > /dev/null; then
  echo "String exist"
else
  echo "exec startxfce4" >> /etc/xrdp/xrdp.ini
fi

# Running/restart xrdp service
systemctl status xrdp | grep 'active (running)' > /dev/null 2>&1

if [ $? != 0 ]; then
  systemctl restart xrdp > /dev/null
fi

# Add exception for port 3389
ufw allow 3389

# Reboot system
for (( i=3; i >= 0; i-- )); do
  echo "System reboot after $i seconds"
  sleep 1s
done

reboot
