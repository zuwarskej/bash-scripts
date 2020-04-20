#!/bin/bash
# -------------------------------------------------------------------
# Description: push to remotes repositories (github gitlab bitbucket)
# Written by : zuwarskej
# -------------------------------------------------------------------

# You need rename your remotes repositories before push
REMOTES=(github gitlab bitbucket)

# Push to remotes
for remote in ${REMOTES[*]}; do
  git push $remote master
done
