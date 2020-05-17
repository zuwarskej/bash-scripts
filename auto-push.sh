#!/bin/bash
# -------------------------------------------------------------------#
# Description: push to remotes repositories (github gitlab bitbucket)
# Written by : zuwarskej
# -------------------------------------------------------------------#

# Check the root rights
root() {
        local id=$(id -u)
        if [ $id -ne 0 ]; then
                echo "You must be root or sudo user to run this script"
        exit 1
        fi
}
root

REMOTES=(github gitlab bitbucket) # you need rename your remotes repositories before push

# Push to remotes
for remote in ${REMOTES[*]}; do
  git push $remote master
done
