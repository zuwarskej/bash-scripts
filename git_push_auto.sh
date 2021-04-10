#!/bin/bash

# Description: push to remote repositories (github gitlab bitbucket)

# Rename your remote repositories to trigger the pattern
REMOTES=(github gitlab bitbucket)

# Push to main branch
for remote in ${REMOTES[*]}; do
  git push $remote main
done
