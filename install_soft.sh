#!/bin/bash

# Descryption: install some packages in Debian/Ubuntu

# Check the root rights
if [ "$(id -un)" != "root" ]; then
  echo "ERROR: You must be root to run this script." >&2
  exit 1
fi

# Update and upgrade packages
apt-get update && apt-get upgrade -yqq

# Install packages
for packages in curl git wget apt-transport-https openssh-server openssh-client \
  build-essential bash-completion htop lnav ncdu mc tree net-tools; do
  apt-get install -y --allow-unauthenticated $packages
done
