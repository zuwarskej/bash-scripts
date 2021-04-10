#!/bin/bash

# Descryption: update packages in Debian/Ubuntu

DATE="$(date +"%m-%d-%Y")"
FILE="$HOME/log_update.txt"

# Check the root rights
if [ "$(id -un)" != "root" ]; then
  echo "ERROR: You must be root to run this script." >&2
  exit 1
fi

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
