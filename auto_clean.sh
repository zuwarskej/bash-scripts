#!/bin/bash

# Descryption: clean and remove temporary packages in Debian/Ubuntu

# Check the root rights
if [ "$(id -un)" != "root" ]; then
  echo "ERROR: You must be root to run this script." >&2
  exit 1
fi

# Clean packages & temporary files
apt purge --auto-remove -yqq && apt autoclean
dpkg -l | awk '/^rc/ { print $2 }' >&2
apt purge "$(dpkg -l | awk '/^rc/ { print $2 }')"
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/man /usr/share/doc /usr/share/doc-base
echo "done"