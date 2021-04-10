#!/bin/bash

# Description: push to remote repository

# Index files to commit 
echo "Index files to commit"
git add .

# Check status
echo "Current status is:"
git status

# Commit changes 
echo "Enter the commit message:"
read -r commit
git commit -m "$commit"

# Push to remote repository
echo "Push to remote repository"
read -r branch
git push github "$branch"
