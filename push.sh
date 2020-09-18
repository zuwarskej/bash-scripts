#!/bin/bash

# Description: push to remote repository

# Add all added/modified files
echo "Add all added/modified files"
git add .

# Check added files to commit
echo "Current status is:"
git status

# Make commit
echo "Enter the commit message:"
read -r commit
git commit -m "$commit"

# Push to remote repository
echo "Push to remote repository"
read -r branch
git push origin "$branch"
