#!/bin/bash

# Description: generate ssh key

echo "Enter your email"
read -r email
ssh-keygen -t rsa -b 4096 -C "$email"
