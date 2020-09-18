#!/bin/bash

# Descryption: update packages Debian/Ubuntu

DATE=$(date +"%m-%d-%Y")
FILE=$HOME/log_update.txt

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
	apt autoremove -yqq && apt autoclean;
fi

# Write date in file
if [ -f "$FILE" ]; then
   echo "Last system update: $DATE" >> $FILE
else
   echo "Last system update: $DATE" > $FILE
fi
