#!/bin/bash

# Descryption: clean and remove temporary packages in Debian/Ubuntu

# Check the root rights
root() {
        local id=$(id -u)
        if [ $id -ne 0 ]; then
                echo "You must be root or sudo user to run this script"
        exit 1
        fi
}
root

# Clean packages and files
if apt-get purge --auto-remove -yqq && apt-get clean; then
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/man /usr/share/doc /usr/share/doc-base;
        echo "done"
fi
