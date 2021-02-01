#!/bin/bash

# Description: push to remotes repositories (github gitlab bitbucket)

# Check the root rights
root() {
    local ID=$(id -u)
        if [ "$ID" -ne 0 ]; then
            echo "You must be root or sudo user to run this script"
            exit 1
        fi
}
root

REMOTES=(github gitlab bitbucket) # you should rename your remotes repositories before push

# Push to remotes
for remote in ${REMOTES[*]}; do
    git push $remote master
done
