#!/bin/bash

#Set up git config global
echo "Enter name for git config"
read name
git config --global user.name "$name"

echo "Enter email for git config"
read email
git config --global user.email "$email"

#Check username and email settings
git config --list | grep -i user
