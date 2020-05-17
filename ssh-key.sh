#!/bin/bash
# ------------------------------#
# Description: generate ssh key
# Written by : zuwarskej
# ------------------------------#

echo "Enter your email"
read -r email
ssh-keygen -t rsa -b 4096 -C "$email"
