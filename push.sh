#!/bin/bash
# ---------------------------------------
# Description: push to remote repository
# Written by : zuwawrskej
# ---------------------------------------

# Add all added/modified files
echo "Add all added/modified files"
git add .

# Check added files to commit
echo "Current status is:"
git status

# Make commit
echo 'Enter the commit message:'
read -r commit
git commit -m "$commit"

# Check remote repository
echo "Remote repository is:"
git remote -v

# Push to remote
read -n1 -p -r "Do you want to push to master?" push

case $push in
y|Y) git push origin master ;;
n|N) echo "Exiting" exit ;;
esac
